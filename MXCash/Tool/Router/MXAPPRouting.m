//
//  MXAPPRouting.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXAPPRouting.h"
#import "MXAPPWebViewController.h"
#import "MXAPPProductViewController.h"
#import "MXCommonParams.h"
#import "MXAPPSettingViewController.h"

@implementation MXAPPRouting

+ (instancetype)shared {
    static MXAPPRouting *rout;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (rout == nil) {
            rout = [[MXAPPRouting alloc] init];
        }
    });
    
    return rout;
}

- (void)pageRouter:(NSString *)url backToRoot:(BOOL)toRoot targetVC:(UIViewController *)target {
    UITabBarController *rootVC = (UITabBarController *)[UIDevice currentDevice].keyWindow.rootViewController;
    if (rootVC == nil) {
        return;
    }
    
    UIViewController *topVC = [rootVC topMostController];
    if ([url hasPrefix:@"http"]) {
        [topVC.navigationController pushViewController:[[MXAPPWebViewController alloc] initWithWebLink:[MXCommonParams splicingCommonArgus:url] backToRoot:toRoot] animated:YES];
    } else {
        if ([url containsString:APP_SETTING_PATH]) {
            [topVC.navigationController pushViewController:[[MXAPPSettingViewController alloc] init] animated:YES];
        } else if ([url containsString:APP_HOME_PATH]) {
            [topVC.navigationController popToRootViewControllerAnimated:NO];
            rootVC.selectedIndex = 0;
        } else if ([url containsString:APP_LOGIN_PATH]) {
            // 登录失效.重新登录
            [[NSNotificationCenter defaultCenter] postNotificationName:(NSNotificationName)APP_LOGIN_EXPIRED_NOTIFICATION object:nil];
        } else if ([url containsString:APP_ORDER_PATH]) {
            [topVC.navigationController popToRootViewControllerAnimated:NO];
            rootVC.selectedIndex = 1;
        } else if ([url containsString:APP_PRODUCT_PATH]) {
            [topVC.navigationController pushViewController:[[MXAPPProductViewController alloc] initWithProductIDNumber:[self separateURLParameter:url]] animated:YES];
        } else {
            if (target != nil) {
                [topVC.navigationController pushViewController:target animated:YES];
            }
        }
    }
}

- (NSString *)separateURLParameter:(NSString *)url {
    NSString *paraStr = [url componentsSeparatedByString:@"?"].lastObject;
    return [paraStr componentsSeparatedByString:@"="].lastObject;
}

@end
