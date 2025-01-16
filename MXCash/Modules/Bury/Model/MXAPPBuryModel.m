//
//  MXAPPBuryModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXAPPBuryModel.h"

@implementation MXAPPMemoryModel

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    dic[@"auto"] = self.totoalCache;
    return YES;
}

@end

@implementation MXAPPElectricModel

@end

@implementation MXAPPSystemInfoModel

@end

@implementation MXAPPTimeModel

@end

@implementation MXAPPWifiModel

@end

@implementation MXAPPHostModel

@end

@implementation MXAPPBuryModel

@end
