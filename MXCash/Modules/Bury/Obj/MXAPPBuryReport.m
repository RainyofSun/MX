//
//  MXAPPBuryReport.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/3.
//

#import "MXAPPBuryReport.h"
#import "MXAPPLocationTool.h"
#import <AdSupport/AdSupport.h>
#import "MXAPPBuryModel.h"
#import "MXAuthorizationTool.h"

@implementation MXAPPBuryReport

+ (void)appLocationReport {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 国家Code
    if (![NSString isEmptyString:[MXAPPLocationTool location].placeMark.ISOcountryCode]) {
        [params setValue:[MXAPPLocationTool location].placeMark.locality forKey:@"mma"];
    }
    
    // 国家
    if (![NSString isEmptyString:[MXAPPLocationTool location].placeMark.country]) {
        [params setValue:[MXAPPLocationTool location].placeMark.locality forKey:@"bellator"];
    }
    
    // 省
    if (![NSString isEmptyString:[MXAPPLocationTool location].placeMark.locality]) {
        [params setValue:[MXAPPLocationTool location].placeMark.locality forKey:@"ultimate"];
    }
    
    // 直辖市
    if (![NSString isEmptyString:[MXAPPLocationTool location].placeMark.administrativeArea]) {
        [params setValue:[MXAPPLocationTool location].placeMark.administrativeArea forKey:@"whelen"];
    }
    
    // 街道
    if (![NSString isEmptyString:[MXAPPLocationTool location].placeMark.thoroughfare]) {
        [params setValue:[MXAPPLocationTool location].placeMark.locality forKey:@"martial"];
    }
    
    // 区/县
    if (![NSString isEmptyString:[MXAPPLocationTool location].placeMark.subLocality]) {
        [params setValue:[MXAPPLocationTool location].placeMark.locality forKey:@"classes"];
    }
    
    // 经纬度
    if ([MXAPPLocationTool location].location != nil) {
        [params setValue:[NSString stringWithFormat:@"%f", [MXAPPLocationTool location].location.coordinate.latitude] forKey:@"mixed"];
        [params setValue:[NSString stringWithFormat:@"%f", [MXAPPLocationTool location].location.coordinate.longitude] forKey:@"modified"];
    }
    
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/decoy" params:params success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

+ (void)IDFAAndIDFVReport {
    NSDictionary *params = @{@"modifieds": [UIDevice currentDevice].readIDFVFormKeyChain, @"nascar": [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString};
    
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/gibbs" params:params success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

+ (void)riskControlReport:(MXBuryRiskControlType)type beginTime:(NSString *)time1 endTime:(NSString *)time2 orderNumber:(NSString *)order {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (![NSString isEmptyString:time1]) {
        [params setValue:time1 forKey:@"speedbowl"];
    }
    
    if (![NSString isEmptyString:time2]) {
        [params setValue:time2 forKey:@"speedway"];
    }
    
    [params setValue:[NSString stringWithFormat:@"%lu", (unsigned long)type] forKey:@"tracks"];
    
    if (![NSString isEmptyString:order]) {
        [params setValue:order forKey:@"unknown"];
    }
    
    if (![NSString isEmptyString:[UIDevice currentDevice].readIDFVFormKeyChain]) {
        [params setValue:[UIDevice currentDevice].readIDFVFormKeyChain forKey:@"oval"];
    }
    
    if ([MXAPPLocationTool location].location != nil) {
        [params setValue:[NSString stringWithFormat:@"%f", [MXAPPLocationTool location].location.coordinate.latitude] forKey:@"mixed"];
        [params setValue:[NSString stringWithFormat:@"%f", [MXAPPLocationTool location].location.coordinate.longitude] forKey:@"modified"];
    }
    
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/broadbill" params:params success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

+ (void)currentDeviceInfoReport {
    MXAPPBuryModel *buryModel = [[MXAPPBuryModel alloc] init];
    
    // 内存信息
    MXAPPMemoryModel *memoryModel = [[MXAPPMemoryModel alloc] init];
    memoryModel.races = [NSString stringWithFormat:@"%lld", [UIDevice currentDevice].diskSpaceFree];
    memoryModel.club = [NSString stringWithFormat:@"%lld", [UIDevice currentDevice].diskSpace];
    memoryModel.totoalCache = [NSString stringWithFormat:@"%lld", [UIDevice currentDevice].memoryTotal];
    memoryModel.scca = [NSString stringWithFormat:@"%lld", [UIDevice currentDevice].memoryFree];
    
    DDLogDebug(@" ----- 埋点内存 -------\n 总容量 = %@ \n 可用容量 = %@ \n 总内存 = %@ \n 可用内存 = %@ \n", memoryModel.club, memoryModel.races, memoryModel.totoalCache, memoryModel.scca);
    buryModel.thompson = memoryModel;
    
    // 电量信息
    MXAPPElectricModel *electricModel = [[MXAPPElectricModel alloc] init];
    NSArray<NSString *>* batteryInfo = [[UIDevice currentDevice] appBattery];
    if (batteryInfo.count != 0) {
        electricModel.mile = batteryInfo.firstObject;
        electricModel.mans = batteryInfo.lastObject;
    }
    
    DDLogDebug(@" ----- 埋点电量 -------\n 电池电量 = %@ \n 电池状态 = %@ \n", electricModel.mile, electricModel.mans);
    buryModel.racing = electricModel;
    
    // 版本
    MXAPPSystemInfoModel *systemModel = [[MXAPPSystemInfoModel alloc] init];
    systemModel.rock = [NSString stringWithFormat:@"%f", [UIDevice systemVersion]];
    systemModel.lime = [UIDevice currentDevice].machineModelName;
    systemModel.now = [UIDevice currentDevice].machineModel;
    
    DDLogDebug(@" ----- 埋点版本 -------\n 系统版本 = %@ \n 设备名称 = %@ \n 设备原始版本 = %@ \n", systemModel.rock, systemModel.lime, systemModel.now);
    
    buryModel.le = systemModel;

    // 时区
    MXAPPTimeModel *timeModel = [[MXAPPTimeModel alloc] init];
    timeModel.golf = [NSTimeZone localTimeZone].name;
    timeModel.tour = [UIDevice currentDevice].getSIMCardInfo;
    timeModel.modifieds = [UIDevice currentDevice].readIDFVFormKeyChain;
    timeModel.pga = [UIDevice currentDevice].getNetconnType;
    if ([MXAuthorizationTool authorization].ATTTrackingStatus == Authorized) {
        timeModel.nascar = ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
    }
    
    timeModel.events = [UIDevice currentDevice].getIPAddress;
    
    DDLogDebug(@" ----- 埋点版本 -------\n 系统时区 = %@ \n 设备运营商SIM = %@ \n 设备IDFV = %@ \n 设备网络类型 = %@ \n 设备IDFA = %@ \n 设备IP地址 = %@ \n", timeModel.golf, timeModel.tour, timeModel.modifieds, timeModel.pga, timeModel.nascar, timeModel.events);
    buryModel.tournament = timeModel;
    
    // WIFI
    MXAPPWifiModel *wifiModel = [[MXAPPWifiModel alloc] init];
    NSArray <NSString *>*wifiInfo = [UIDevice currentDevice].getWiFiInfo;
    wifiModel.athletic = wifiInfo.firstObject;
    wifiModel.championship = wifiInfo.lastObject;
    wifiModel.usl = wifiInfo.firstObject;
    wifiModel.robin = wifiInfo.firstObject;
    
    DDLogDebug(@" ----- 埋点版本 -------\n WIFI SSID = %@ \n WIFI BSSID = %@ \n", wifiModel.athletic, wifiModel.championship);
    
    MXAPPHostModel *hostModel = [[MXAPPHostModel alloc] init];
    hostModel.hosts = wifiModel;
    buryModel.sporting = hostModel;
    
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/docked" params:@{@"gibson": [buryModel modelToJSONString]} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

@end
