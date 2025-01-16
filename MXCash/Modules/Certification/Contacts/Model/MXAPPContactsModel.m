//
//  MXAPPContactsModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/15.
//

#import "MXAPPContactsModel.h"


@implementation MXAPPReportAllContactsModel



@end

@implementation MXAPPEmergencyPersonModel



@end

@implementation MXAPPContactsPeopleModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"fish": [MXAPPQuestionChoiseModel class]};
}

@end

@implementation MXAPPContactsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"titles": [MXAPPContactsPeopleModel class]};
}

@end
