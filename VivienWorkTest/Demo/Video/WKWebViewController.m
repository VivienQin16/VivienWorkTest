//
//  WKWebViewController.m
//  VivienWorkTest
//
//  Created by Vivien on 2017/8/22.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "AppDelegate.h"
#import "SupportedInterfaceOrientations.h"
@interface WKWebViewController () <WKNavigationDelegate,WKUIDelegate>
{
    WKWebView  *wkWebView;
    UIView *loadLine;
    
}
@property (nonatomic,assign)BOOL didWebViewLoadOK;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//
//    NSURL *url = [NSURL URLWithString: @"http://www.iqiyi.com/v_19rron8psw.html?src=focustext_2_20130410_1#curid=378627300_481ef4234d04240f8e3526ba4d503a1d"];
//    url = [NSURL URLWithString:@"https://v.qq.com/x/cover/j6cgzhtkuonf6te.html"];
    wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    [wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://v.youku.com/v_show/id_XMjk0NTYwODQ4NA==.html?"]]];
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
    [self.view addSubview:wkWebView];
    
    // 图片缩放的js代码
//    NSString *js = @"var count = document.images.length;for (var i = 0; i < count; i++) {var image = document.images[i];image.style.width=320;};window.alert('找到' + count + '张图');";
//    // 根据JS字符串初始化WKUserScript对象
//    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES]; // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    [config.userContentController addUserScript:script]; wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
//    [wkWebView loadHTMLString:@"<head></head><img src='http://www.nsu.edu.cn/v/2014v3/img/background/3.jpg' />"baseURL:nil];
//    
//    [self.view addSubview:wkWebView];
    
    loadLine = [[UIView alloc]initWithFrame:CGRectZero];  //CGRectMake(0, 64, kScreenWidth, 5)];
    [self.view addSubview:loadLine];
    loadLine.backgroundColor = [UIColor cyanColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 添加KVO监听
    [wkWebView addObserver:self
                forKeyPath:@"loading"
                   options:NSKeyValueObservingOptionNew
                   context:nil];
    
    [wkWebView addObserver:self
                forKeyPath:@"title"
                   options:NSKeyValueObservingOptionNew
                   context:nil];
    
    [wkWebView addObserver:self
                forKeyPath:@"estimatedProgress"
                   options:NSKeyValueObservingOptionNew
                   context:nil];
    //让播放视频时横屏
    [self registerNotifaction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [wkWebView removeObserver:self forKeyPath:@"loading" context:nil];//移除kvo
    [wkWebView removeObserver:self forKeyPath:@"title" context:nil];
    [wkWebView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];

//        [self endFullScreen];
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
#pragma mark   ————WKNavigationDelegate
#pragma mark --追踪加载过程;
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{

}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.didWebViewLoadOK = YES;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    self.didWebViewLoadOK = NO;
}

#pragma mark --页面跳转的代理方法;
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
//这个代理方法表示当客户端收到服务器的响应头，根据response相关信息，可以决定这次跳转是否进行
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
//    if (!navigationAction.targetFrame.isMainFrame) {
//        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
//    }
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:在发送请求之前，决定是否跳转
    
    NSString *url = [navigationAction.request.URL.absoluteString
                     stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"4.%@,url:%@",navigationAction.request,url);
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark ————WKUIDelegate
// 创建新的webview
// 可以指定配置对象、导航动作对象、window特性
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return nil;
}

// webview关闭时回调
- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
    
}

// 调用JS的alert()方法
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"调用alert提示框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"alert message:%@",message);
    
}

// 调用JS的confirm()方法
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:@"调用confirm提示框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"confirm message:%@", message);
}

// 调用JS的prompt()方法
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:@"调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}

#pragma mark - 监听
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    if ([keyPath isEqualToString:@"loading"]){
        NSLog(@"loading");
        
    } else if ([keyPath isEqualToString:@"title"]){
        self.title = wkWebView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]){
        NSLog(@"progress: %f", wkWebView.estimatedProgress);
        loadLine.frame = CGRectMake(0, 64, kScreenWidth*wkWebView.estimatedProgress, 5);
    }
    
    // 加载完成
    if (!wkWebView.loading)
    {
        [UIView animateWithDuration:0.5 animations:^{
            loadLine.alpha = 0;
        }];
    }
}


#pragma mark ————屏幕
- (void)registerNotifaction {
//    //将要进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];
    //退出全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];
}

- (void)startFullScreen {
    NSLog(@"进入全屏");
    if(!self.didWebViewLoadOK) {
        return;
    }
    [self setAppdelegateAllowRotation:YES];
    [[SupportedInterfaceOrientations sharedInstance]rotationLandscape];
}
/*退出全屏*/
 - (void)endFullScreen {
     [[SupportedInterfaceOrientations sharedInstance]rotationPortrait];
     [self setAppdelegateAllowRotation:NO];
 }

- (void)setAppdelegateAllowRotation:(BOOL)boolValue
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = boolValue;
}
@end
