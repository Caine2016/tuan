//
//  YLOrderDealsController.m
//  YPTuan
//
//  Created by gd on 2018/12/20.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLOrderDealsController.h"
#import <WebKit/WebKit.h>

#define MainColor     UIColorFromRGB(0x1FB5EC)  //进度条颜色

@interface YLOrderDealsController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (assign, nonatomic) NSUInteger loadCount;

@end

@implementation YLOrderDealsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    
    // Do any additional setup after loading the view.
}


#pragma mark -- View --
-(void) addView{
    [self addWebView];
    
//    NSString *path=[[NSBundle mainBundle] pathForResource:_urlString ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:path];
    
    
}



#pragma mark -- webView


-(void) addWebView{
    
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kBaseTopHeight-1, self.view.frame.size.width, 0)];
    //progressView.tintColor = WebViewNav_TintColor;
    progressView.tintColor = MainColor;
    progressView.trackTintColor = VCBGColor;
    
    self.progressView = progressView;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,kBaseTopHeight, kScreenWidth,kScreenHeight-kBaseTopHeight)];
    //   self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = VCBGColor;
    
    [self.view insertSubview:self.webView belowSubview:progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:self.webView];
    
    [self.view addSubview:progressView];
    
    
    self.customTitle = @"加载中...";
    
   [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
}



// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }else if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView) {
            self.customTitle = self.webView.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    
    
}
// 记得取消监听
- (void)dealloc {
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [GDNotificationCenter removeObserver:self];
}
#pragma mark - WKNavigationDelegate


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //http://wx.fygdrs.com/temple/lampview.html?
    
}



// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        
        NLog(@"%@ --cookie",cookie);
    }
    
    
    //这句是必须加上的，不然会异
    decisionHandler(WKNavigationResponsePolicyAllow);
    
    
}



// 在发送请求之前，决定是否跳转


- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{
    
    
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    NSString *urlString = [navigationAction.request.URL absoluteString];
    
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlString containsString:@"weixin://wap/pay?"]) {
        
        actionPolicy =WKNavigationActionPolicyCancel;
        
        //解决wkwebview weixin://无法打开微信客户端的处理
        
        NSURL*url = [NSURL URLWithString:urlString];
        
        if ([[UIApplication sharedApplication]respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {   }];
            } else {
                // Fallback on earlier versions
            }
            
        } else {
            
            [[UIApplication sharedApplication]openURL:webView.URL];
            
        }
        
    }
    
    //这句是必须加上的，不然会异常
    
    decisionHandler(actionPolicy);
    
    
    
}

@end
