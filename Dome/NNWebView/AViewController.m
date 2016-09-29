//
//  AViewController.m
//  NNWebView
//
//  Created by anlaiye on 16/9/29.
//  Copyright © 2016年 NT. All rights reserved.
//

#import "AViewController.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
@interface AViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (nonatomic, strong) NJKWebViewProgress      *progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView      *progressView;
@property (nonatomic, strong) UIWebView      *webView;
@end

@implementation AViewController
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _webView.delegate = self;
        _webView.delegate = self.progressProxy;
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    
    [self.progressView setProgress:progress animated:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestStr = [request.URL absoluteString];
    NSLog(@"requestStr====%@",requestStr);
    
   
    
    return YES;
}


@end
