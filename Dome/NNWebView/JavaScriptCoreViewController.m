//
//  JavaScriptCoreViewController.m
//  NNWebView
//
//  Created by anlaiye on 16/9/29.
//  Copyright © 2016年 NT. All rights reserved.
//

#import "JavaScriptCoreViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
@interface JavaScriptCoreViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (nonatomic, strong) NJKWebViewProgress      *progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView      *progressView;
@property (nonatomic, strong) UIWebView      *webView;

@end

@implementation JavaScriptCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.progressView setProgress:1 animated:NO];
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"jsButton"] = ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"点击了JS按钮" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sureAlertAction];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    };
    
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _webView.delegate = self;
        _webView.delegate = self.progressProxy;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JavaScriptCore" ofType:@"html"];
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlString baseURL:baseURL];
    }
    return _webView;
}
- (NJKWebViewProgress *)progressProxy{
    if (!_progressProxy) {
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
    }
    return _progressProxy;
}
- (NJKWebViewProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[NJKWebViewProgressView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 3)];
        [_progressView setProgress:0.1 animated:NO];
        _progressView.progressBarView.backgroundColor = [UIColor redColor];
    }
    return _progressView;
}


-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    
    [self.progressView setProgress:progress animated:NO];
}
@end
