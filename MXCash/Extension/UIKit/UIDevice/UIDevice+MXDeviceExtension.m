//
//  UIDevice+MXDeviceExtension.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "UIDevice+MXDeviceExtension.h"
#import <YYKit/YYKeychain.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <Reachability/Reachability.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation UIDevice (MXDeviceExtension)

- (NSString *)readIDFVFormKeyChain {
    NSString *idfv = self.identifierForVendor.UUIDString;
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSString *keychainIDFA = [YYKeychain getPasswordForService:bundleID account:APP_IDFV_KEY];
    if (![NSString isEmptyString:keychainIDFA]) {
        return keychainIDFA;
    } else {
        if (![NSString isEmptyString:idfv]) {
            [YYKeychain setPassword:idfv forService:bundleID account:APP_IDFV_KEY];
            return idfv;
        }
    }
    
    return @"";
}

- (UIWindowScene *)activeScene {
    UIScene* scene = nil;
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(connectedScenes)]) {
        NSSet<UIScene*> *scenes = [[UIApplication sharedApplication] connectedScenes];
        for (UIScene *tmpScene in scenes) {
            if (tmpScene.activationState == UISceneActivationStateForegroundActive) {
                scene = tmpScene;
                break;
            }
        }
    }
    
    return (UIWindowScene *)scene;
}

- (UIWindow *)keyWindow {
    UIWindowScene* scene = [self activeScene];
    
    if (scene) {
        return scene.windows.firstObject;
    } else {
        return [[UIApplication sharedApplication] keyWindow];
    }
}

- (CGFloat)app_navigationBarAndStatusBarHeight {
    return [self app_navigationBarHeight] + [self app_statusBarAndSafeAreaHeight];
}

- (CGFloat)app_navigationBarHeight {
    return 44.0;
}

- (CGFloat)app_safeDistanceTop {
    UIWindow *window = [self keyWindow];
    return window == nil ? 0 : window.safeAreaInsets.top;
}

- (CGFloat)app_statusBarAndSafeAreaHeight {
    UIWindowScene *scene = [self activeScene];
    CGFloat statusBarHeight = scene.statusBarManager.statusBarFrame.size.height;
    return statusBarHeight;
}

- (CGFloat)app_tabbarAndSafeAreaHeight {
    return [self app_tabbarHeight] + [self app_safeDistanceBottom];
}

- (CGFloat)app_tabbarHeight {
    return 49.0;
}

- (CGFloat)app_safeDistanceBottom {
    UIWindow *window = [self keyWindow];
    return window == nil ? 0 : window.safeAreaInsets.bottom;
}


- (NSArray<NSString *> *)appBattery {
    [self setBatteryMonitoringEnabled:YES];
    if ([self isBatteryMonitoringEnabled]) {
        float batteryLevel = [self batteryLevel];
        BOOL isCharge = self.batteryState == UIDeviceBatteryStateCharging || self.batteryState == UIDeviceBatteryStateFull ? YES : NO;
        return @[[NSString stringWithFormat:@"%f", batteryLevel], [NSString stringWithFormat:@"%@", [NSNumber numberWithBool:isCharge]]];
    } else {
        return @[];
    }
}

/**
 #import <CoreTelephony/CTTelephonyNetworkInfo.h>
 #import <CoreTelephony/CTCarrier.h>
 sim卡信息
 */
- (NSString *)getSIMCardInfo {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = nil;
    NSString *radioType = nil;
    if (@available(iOS 12.1, *)) {
        if (info && [info respondsToSelector:@selector(serviceSubscriberCellularProviders)]) {
            
            NSDictionary *dic = [info serviceSubscriberCellularProviders];
            if (dic.allKeys.count) {
                carrier = [dic objectForKey:dic.allKeys[0]];
            }
        }
        
        if (info && [info respondsToSelector:@selector(serviceCurrentRadioAccessTechnology)]) {
            
            NSDictionary *radioDic = [info serviceCurrentRadioAccessTechnology];
            if (radioDic.allKeys.count) {
                radioType = [radioDic objectForKey:radioDic.allKeys[0]];
            }
        }
    } else {
        carrier = [info subscriberCellularProvider];
        radioType = [info currentRadioAccessTechnology];
    }
    
    //运营商可用
    BOOL use = carrier.allowsVOIP;
    //运营商名字
    NSString *name = carrier.carrierName;
    //ISO国家代码
    NSString *code = carrier.isoCountryCode;
    //移动国家代码
    NSString *mcc = [carrier mobileCountryCode];
    //移动网络代码
    NSString *mnc = [carrier mobileNetworkCode];
    return name;
}

- (NSString *)getNetconnType {

    NSString *netconnType = @"";

    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];

    switch ([reach currentReachabilityStatus]) {
        case NotReachable:// 没有网络
        {

            netconnType = @"no network";
        }
            break;
        case ReachableViaWiFi:// Wifi
        {
            netconnType = @"Wifi";
        }
            break;
        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];

            NSString *currentStatus = info.currentRadioAccessTechnology;

            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {

                netconnType = @"GPRS";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {

                netconnType = @"2.75G EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){

                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){

                netconnType = @"3.5G HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){

                netconnType = @"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){

                netconnType = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){

                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){

                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){

                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){

                netconnType = @"HRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){

                netconnType = @"4G";
            }
        }
            break;

        default:
            break;
    }

    return netconnType;
}

- (NSArray<NSString *> *)getWiFiInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            return @[info[(__bridge NSString *)kCNNetworkInfoKeySSID], info[(__bridge NSString *)kCNNetworkInfoKeyBSSID]];
        }
    }
    return nil;
}
 
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *interface;
    int success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through all the interfaces until we find one that has an IPv4 address.
        for (interface = interfaces; interface; interface = interface->ifa_next) {
            if (interface->ifa_addr->sa_family == AF_INET) { // AF_INET represents IPv4.
                // Check if interface is not lo0 (loopback)
                if ([[NSString stringWithUTF8String:interface->ifa_name] isEqualToString:@"lo0"]) {
                    continue;
                }
                
                // Get human readable IPv4 address
                struct sockaddr_in *addr = (struct sockaddr_in *)interface->ifa_addr;
                address = [NSString stringWithUTF8String:inet_ntoa(addr->sin_addr)];
                break;
            }
        }
        
        freeifaddrs(interfaces);
    }
    return address;
}


@end
