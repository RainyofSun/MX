//
//  MXLoginModel.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import "MXLoginModel.h"

@implementation MXLoginModel

- (id)copyWithZone:(NSZone *)zone {
    MXLoginModel *model = [[[self class] allocWithZone:zone] init];
    model.composer = [self.composer copyWithZone:zone];
    model.winsted = [self.winsted copyWithZone:zone];
    
    return model;
}

@end
