//
//  MXAPPQuestionModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import "MXAPPQuestionModel.h"

@implementation MXAPPQuestionChoiseModel



@end

@implementation MXAPPQuestionModel

- (ControlType)cType {
    if ([self.insect isEqualToString:@"hia"]) {
        return Input;
    } else if ([self.insect isEqualToString:@"hib"]) {
        return Choise;
    } else if ([self.insect isEqualToString:@"hic"]) {
        return DataSelected;
    } else if ([self.insect isEqualToString:@"hid"]) {
        return Tip;
    } else if ([self.insect isEqualToString:@"hie"]) {
        return CitySelected;
    }
    
    return Input;
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"fish":[MXAPPQuestionChoiseModel class]};
}

@end
