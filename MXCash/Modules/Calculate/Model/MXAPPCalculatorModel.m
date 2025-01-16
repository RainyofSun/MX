//
//  MXAPPCalculatorModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPCalculatorModel.h"

@implementation MXAPPCalculatorPlanModel



@end

@implementation MXAPPCalculatorModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"knobs": [MXAPPCalculatorPlanModel class]};
}

@end
