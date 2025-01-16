//
//  UIViewController+MXControllerExtension.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "UIViewController+MXControllerExtension.h"

@implementation UIViewController (MXControllerExtension)

- (BOOL)currentViewControllerShouldPop {
    return YES;
}

- (UIViewController *)topMostController {
    UIViewController *presentVC = self.presentedViewController;
    if (presentVC != nil) {
        return presentVC.topMostController;
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self;
        return nav.visibleViewController.topMostController;
    } else if ([self isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)self;
        return tabVC.selectedViewController.topMostController;
    } else {
        return self;
    }
}

- (void)showSystemStyleSettingAlert:(NSString *)content okTitle:(NSString *)ok cancelTitle:(NSString *)cancel {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:content preferredStyle:UIAlertControllerStyleAlert];
    
    NSString *okTitle = [NSString isEmptyString:ok] ? [[MXAPPLanguage language] languageValue:@"alert_sheet_ok"] : ok;
    NSString *cancelTitle = [NSString isEmptyString:cancel] ? [[MXAPPLanguage language] languageValue:@"alert_sheet_cancel"] : cancel;
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:okAction];
    [alertVC addAction:cancelAction];
    
    dispatch_async_on_main_queue(^{
        [self presentViewController:alertVC animated:YES completion:nil];
    });
}

- (void)updateSystemNavigationBarAppearance:(UIColor *)tintColor backColor:(UIColor *)backColor {
    NSDictionary *attributes = @{};
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: tintColor, NSFontAttributeName: [UIFont boldSystemFontOfSize:18]};
    UIImage *originalImg = [UIImage systemImageNamed:@"chevron.backward"];
    UIImage *tinedImg = [originalImg imageWithTintColor:backColor renderingMode:UIImageRenderingModeAlwaysOriginal];
    [UINavigationBar appearance].backIndicatorImage = tinedImg;
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = tinedImg;
}

@end
