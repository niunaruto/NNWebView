//
//  BViewController.m
//  NNWebView
//
//  Created by anlaiye on 16/9/29.
//  Copyright © 2016年 NT. All rights reserved.
//

#import "BViewController.h"
#import <WebViewJavascriptBridge.h>
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
@interface BViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (nonatomic, strong) NJKWebViewProgress      *progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView      *progressView;
@property (nonatomic, strong) UIWebView      *webView;
@property(nonatomic,strong)WebViewJavascriptBridge *bridge;
@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [WebViewJavascriptBridge enableLogging];
    
    
    [self.bridge registerHandler:@"scanClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"JSBridge按钮" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *sureAlertAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sureAlertAction];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }];
    

    
}
- (WebViewJavascriptBridge *)bridge{
    if (!_bridge) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];

    }
    return _bridge;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _webView.delegate = self;
        _webView.delegate = self.progressProxy;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"JSBridge" ofType:@"html"];
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [_webView loadHTMLString:htmlString baseURL:baseURL];
        
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
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.progressView setProgress:1 animated:NO];
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    
    [self.progressView setProgress:progress animated:NO];
}
@end
