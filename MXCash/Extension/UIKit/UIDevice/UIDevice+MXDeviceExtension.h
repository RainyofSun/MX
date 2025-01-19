//
//  UIDevice+MXDeviceExtension.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (MXDeviceExtension)

- (NSString *)readIDFVFormKeyChain;
- (nullable UIWindowScene *)activeScene;
- (nullable UIWindow *)keyWindow;
- (CGFloat)app_safeDistanceTop;
- (CGFloat)app_safeDistanceBottom;
- (CGFloat)app_statusBarAndSafeAreaHeight;
- (CGFloat)app_navigationBarHeight;
- (CGFloat)app_navigationBarAndStatusBarHeight;
- (CGFloat)app_tabbarHeight;
- (CGFloat)app_tabbarAndSafeAreaHeight;

- (NSArray <NSString *>*)appBattery;
- (NSString *)getSIMCardInfo;
- (NSString *)getNetconnType;
- (NSArray<NSString *> *)getWiFiInfo;
- (NSString *)getIPAddress;
+ (NSDictionary *)getAppDiskSizeWithNeedFormate;
+ (NSString *)getFreeMemory;

@end

NS_ASSUME_NONNULL_END
