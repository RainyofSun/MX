//
//  MXAPPCardModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import "MXAPPCardModel.h"

@implementation MXAPPCardStatusModel



@end

@implementation MXAPPCardModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"father": [MXAPPCardStatusModel class], @"surprises": [MXAPPCardStatusModel class]};
}

@end
