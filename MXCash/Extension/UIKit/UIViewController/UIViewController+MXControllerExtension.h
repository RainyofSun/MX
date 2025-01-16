//
//  UIViewController+MXControllerExtension.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ControllerShouldPopProtocol <NSObject>

- (BOOL)currentViewControllerShouldPop;

@end

@interface UIViewController (MXControllerExtension)<ControllerShouldPopProtocol>

- (UIViewController *)topMostController;
- (void)showSystemStyleSettingAlert:(NSString *)content okTitle:(NSString * _Nullable )ok cancelTitle:(NSString * _Nullable )cancel;
- (void)updateSystemNavigationBarAppearance:(UIColor *)tintColor backColor:(UIColor *)backColor;

@end

NS_ASSUME_NONNULL_END
