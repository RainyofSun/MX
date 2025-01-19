//
//  SceneDelegate.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/30.
//

#import "SceneDelegate.h"
#import "MXAPPNetObserver.h"
#import "MXUserDefaultCache.h"
#import "MXAuthorizationTool.h"
#import "MXGuideViewController.h"
#import "MXBaseTabbarController.h"
#import "MXNetRequestConfig.h"
#import "MXAPPLocationTool.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    // toast
    [CSToastManager setDefaultPosition:CSToastPositionCenter];
    // 网络请求初始化
    [MXNetRequestConfig requestConfig];
    // 开启网络监听
    [[MXAPPNetObserver Observer] startNetObserver];
    // 初始化多语言
    [[MXAPPLanguage language] setLanguageBundleType:[MXUserDefaultCache readLanguageCodeFromCache]];
    // 设备认证
    [MXAuthorizationTool authorization];
    // 读取本地登录信息
    [[MXGlobal global] decoderUserLoginInfo];
    // 日志初始化
#if DEBUG
    [DDLog addLogger:[DDOSLogger sharedInstance] withLevel:DDLogLevelDebug];
#else
    [DDLog addLogger:[DDOSLogger sharedInstance] withLevel:DDLogLevelOff];
#endif
    // 设置根控制器
    [self setAPPRootViewController];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self deviceAuthrization];
    });
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

#pragma mark - Private Methods
- (void)setAPPRootViewController {
    self.window.backgroundColor = [UIColor whiteColor];
    MXGuideViewController *guideVC = [[MXGuideViewController alloc] init];
    self.window.rootViewController = guideVC;
    WeakSelf;
    guideVC.dismissBlock = ^{
        CATransition *animation = [[CATransition alloc] init];
        animation.duration = 0.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionFade;
        [weakSelf.window.layer addAnimation:animation forKey:nil];
        weakSelf.window.rootViewController = [[MXBaseTabbarController alloc] init];
    };
    [self.window makeKeyAndVisible];
}

- (void)deviceAuthrization {
    [[MXAuthorizationTool authorization] requestIDFAAuthrization:^(BOOL status) {
            
    }];
    
    [[MXAuthorizationTool authorization] requestLocationAuthrization:WhenInUse completeHandler:^(BOOL status) {
        
    }];
    
    if ([[MXAuthorizationTool authorization] locationAuthorization] == Authorized || [[MXAuthorizationTool authorization] locationAuthorization] == Limited) {
        [[MXAPPLocationTool location] startLocation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 定位上报
            [MXAPPBuryReport appLocationReport];
        });
    }
    
    if ([[MXAuthorizationTool authorization] ATTTrackingStatus] == ATTrackingManagerAuthorizationStatusAuthorized) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // IDFA 上报
            [MXAPPBuryReport IDFAAndIDFVReport];
        });
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 设备信息上报
        [MXAPPBuryReport currentDeviceInfoReport];
    });
}

@end
