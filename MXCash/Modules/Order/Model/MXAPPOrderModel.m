//
//  MXAPPOrderModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import "MXAPPOrderModel.h"

@implementation MXAPPOrderInfo



@end

@implementation MXAPPOrderItemModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"raleigh": [MXAPPOrderInfo class]};
}

@end

@implementation MXAPPOrderModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"seals": [MXAPPOrderItemModel class]};
}

@end
