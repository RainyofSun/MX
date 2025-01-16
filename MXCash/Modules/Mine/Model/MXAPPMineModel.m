//
//  MXAPPMineModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/9.
//

#import "MXAPPMineModel.h"

@implementation MXAPPMineItem



@end

@implementation MXAPPMineModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"seals": [MXAPPMineItem class]};
}

@end
