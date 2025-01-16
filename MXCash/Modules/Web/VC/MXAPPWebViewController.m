//
//  MXAPPWebViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXAPPWebViewController.h"
#import "MXWeakScriptMessage.h"
#import <StoreKit/StoreKit.h>

@interface MXAPPWebViewController ()<WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, copy) NSString *linkURL;
@property (nonatomic, assign) BOOL toRoot;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation MXAPPWebViewController

- (instancetype)initWithWebLink:(NSString *)url backToRoot:(BOOL)toRoot {
    self = [super initWithNibName:nil bundle:nil];
    self.linkURL = url;
    self.toRoot = toRoot;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateLocation];
    self.fd_interactivePopDisabled = YES;
    [self setupUI];
    if (![NSString isEmptyString:self.linkURL]) {
        DDLogDebug(@"LINKURL = \n%@ \n--------",self.linkURL);
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkURL]]];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    DDLogDebug(@"网页加载进度 --- %f", self.webView.estimatedProgress);
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        dispatch_async_on_main_queue(^{
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if (self.webView.estimatedProgress >= 1.0) {
                self.progressView.progress = 0;
            }
        });
    }
    
    if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }
}

- (BOOL)currentViewControllerShouldPop {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self removeAllWebFuncObserver];
        if (self.navigationController != nil) {
            if (self.navigationController.childViewControllers.count > 1) {
                if (self.toRoot) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } else {
                if (self.presentingViewController != nil) {
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }
            }
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
    return NO;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.progressView.hidden = YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = YES;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    DDLogDebug(@"接受到JS传递的消息：%@ body = %@", message.name, message.body);
    if ([message.name isEqualToString:APP_CLOSE_WEB_METHOD]) {
        [self currentViewControllerShouldPop];
    }
    
    if ([message.name isEqualToString:APP_PAGE_JUMP_METHOD] || [message.name isEqualToString:APP_PAGE_JUMP_PARAMS_METHOD] ||
        [message.name isEqualToString:APP_GO_HOME_METHOD] || [message.name isEqualToString:APP_GO_LOGIN_METHOD] ||
        [message.name isEqualToString:APP_GO_CENTER_METHOD]) {
        NSArray<NSString *>* body = (NSArray <NSString *>*)message.body;
        if (body.count != 0) {
            [[MXAPPRouting shared] pageRouter:body.firstObject backToRoot:NO targetVC:nil];
        }
    }
    
    if ([message.name isEqualToString:APP_CALL_METHOD]) {
        
    }
    
    if ([message.name isEqualToString:APP_STORE_SOURCE_METHOD]) {
        [SKStoreReviewController requestReviewInScene:[UIDevice currentDevice].activeScene];
    }
    
    if ([message.name isEqualToString:APP_CONFIRM_APPLY_METHOD]) {
        self.buryBeginTime = [NSDate timeStamp];
        [MXAPPBuryReport riskControlReport:APP_EndLoanApply beginTime:self.buryBeginTime endTime:self.buryBeginTime orderNumber:[MXGlobal global].productOrderNumber];
    }
}

- (void)setupUI {    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeAllWebFuncObserver {
    [self.webView.configuration.userContentController removeAllUserScripts];
    [self.webView.configuration.userContentController removeAllScriptMessageHandlers];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (WKWebViewConfiguration *)webViewConfig {
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.minimumFontSize = 15;
    preference.javaScriptEnabled = YES;
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = preference;
    config.allowsInlineMediaPlayback = YES;
    config.allowsPictureInPictureMediaPlayback = YES;
    config.userContentController = [self buildWKUserContentController];
    return config;
}

- (WKUserContentController *)buildWKUserContentController {
    MXWeakScriptMessage *msgHandler = [[MXWeakScriptMessage alloc] initWithScriptDelegate:self];
    WKUserContentController *userContent = [[WKUserContentController alloc] init];
    // JS方法监听
    [userContent addScriptMessageHandler:msgHandler name:APP_PAGE_JUMP_METHOD];
    [userContent addScriptMessageHandler:msgHandler name:APP_PAGE_JUMP_PARAMS_METHOD];
    [userContent addScriptMessageHandler:msgHandler name:APP_CLOSE_WEB_METHOD];
    [userContent addScriptMessageHandler:msgHandler name:APP_GO_HOME_METHOD];
    [userContent addScriptMessageHandler:msgHandler name:APP_GO_LOGIN_METHOD];
    [userContent addScriptMessageHandler:msgHandler name:APP_GO_CENTER_METHOD];
    [userContent addScriptMessageHandler:msgHandler name:APP_CALL_METHOD];
    [userContent addScriptMessageHandler:msgHandler name:APP_STORE_SOURCE_METHOD];
    [userContent addScriptMessageHandler:msgHandler name:APP_CONFIRM_APPLY_METHOD];
    
    return userContent;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, [UIDevice currentDevice].app_navigationBarAndStatusBarHeight, ScreenWidth, (ScreenHeight - [UIDevice currentDevice].app_navigationBarAndStatusBarHeight)) configuration:[self webViewConfig]];
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.navigationDelegate = self;
    }
    
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.tintColor = ORANGE_COLOR_F7D376;
        _progressView.trackTintColor = ORANGE_COLOR_FA6603;
        _progressView.hidden = YES;
        _progressView.frame = CGRectMake(0, [UIDevice currentDevice].app_navigationBarAndStatusBarHeight, ScreenWidth, 2);
    }
    
    return _progressView;
}

@end
