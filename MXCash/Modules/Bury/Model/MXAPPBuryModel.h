//
//  MXAPPBuryModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPMemoryModel : NSObject<YYModel>

/// 可用存储大小
@property (nonatomic, copy) NSString *races;
/// 总存储大小
@property (nonatomic, copy) NSString *club;
/// 可用内存大小
@property (nonatomic, copy) NSString *scca;
/// 总内存大小
@property (nonatomic, copy) NSString *totoalCache;

@end

@interface MXAPPElectricModel : NSObject

/// 剩余电量
@property (nonatomic, copy) NSString *mile;
/// 是否在充电
@property (nonatomic, copy) NSString *mans;

@end

@interface MXAPPSystemInfoModel : NSObject

/// 系统版本
@property (nonatomic, copy) NSString *rock;
/// 设备名牌
@property (nonatomic, copy) NSString *lime;
/// 原始型号
@property (nonatomic, copy) NSString *now;

@end

@interface MXAPPTimeModel : NSObject

/// 时区
@property (nonatomic, copy) NSString *golf;
/// 通讯商
@property (nonatomic, copy) NSString *tour;
/// IDFV
@property (nonatomic, copy) NSString *modifieds;
/// 网络类型
@property (nonatomic, copy) NSString *pga;
/// IP地址
@property (nonatomic, copy) NSString *events;
/// IDFA
@property (nonatomic, copy) NSString *nascar;

@end

@interface MXAPPWifiModel : NSObject

/// SSID
@property (nonatomic, copy) NSString *athletic;
/// BSSID
@property (nonatomic, copy) NSString *championship;
/// WI-FI Name
@property (nonatomic, copy) NSString *usl;
@property (nonatomic, copy) NSString *robin;

@end

@interface MXAPPHostModel : NSObject

@property (nonatomic, strong) MXAPPWifiModel *hosts;

@end

@interface MXAPPBuryModel : NSObject

/// 内存
@property (nonatomic, strong) MXAPPMemoryModel *thompson;
/// 电量
@property (nonatomic, strong) MXAPPElectricModel *racing;
/// 设备
@property (nonatomic, strong) MXAPPSystemInfoModel *le;
/// 时间
@property (nonatomic, strong) MXAPPTimeModel *tournament;
/// WIFI
@property (nonatomic, strong) MXAPPHostModel *sporting;

@end

NS_ASSUME_NONNULL_END
