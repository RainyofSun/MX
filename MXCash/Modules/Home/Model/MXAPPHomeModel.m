//
//  MXAPPHomeModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/7.
//

#import "MXAPPHomeModel.h"

@implementation MXAPPCustomerModel



@end

@implementation MXBannerLoopModel



@end

@implementation MXAPPProductModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"arguably": [MXAPPProductLoanModel class]};
}

@end

@implementation MXAPPProductRateModel



@end

@implementation MXAPPProductLoanModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"quonehtacut": [MXAPPProductRateModel class],
             @"lists":[MXAPPProductRateModel class]};
}

@end

@implementation MXAPPHomeModel

- (MXAPPHomeModel *)homeDataFilter {
    if (self.seals.count == 0) {
        return self;
    }
    
    [self.seals enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *data_type = obj[@"sites"];
        // Banner
        if ([data_type isEqualToString:@"conventiona"] && [obj[@"source"] isKindOfClass:[NSArray class]]) {
            self.banner = [NSArray modelArrayWithClass:[MXBannerLoopModel class] json:obj[@"source"]];
        }
        // 大卡位
        else if ([data_type isEqualToString:@"conventionb"] && [obj[@"source"] isKindOfClass:[NSArray class]]) {
            self.bigCardModel = [NSArray modelArrayWithClass:[MXAPPProductModel class] json:obj[@"source"]].firstObject;
        }
        // 小卡位
        else if ([data_type isEqualToString:@"conventionc"] && [obj[@"source"] isKindOfClass:[NSArray class]]) {
            self.smallCardModel = [NSArray modelArrayWithClass:[MXAPPProductModel class] json:obj[@"source"]].firstObject;
        }
        // 产品列表
        else if ([data_type isEqualToString:@"conventiond"] && [obj[@"source"] isKindOfClass:[NSArray class]]) {
            self.productModels = [NSArray modelArrayWithClass:[MXAPPProductModel class] json:obj[@"source"]];
        }
    }];
    
    return self;
}

@end

@implementation MXAPPProductAuthModel



@end
