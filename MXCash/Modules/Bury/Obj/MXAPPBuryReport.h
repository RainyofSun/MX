//
//  MXAPPBuryReport.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    APP_Register = 1,
    APP_Questionnaire = 2,
    APP_TakingCardPhoto = 3,
    APP_Face = 6,
    APP_PersonalInfo = 7,
    APP_WorkingInfo = 8,
    APP_Contacts = 9,
    APP_BindingBankCard = 10,
    APP_BeginLoanApply = 11,
    APP_EndLoanApply = 12
} MXBuryRiskControlType;

@interface MXAPPBuryReport : NSObject

+ (void)appLocationReport;
+ (void)IDFAAndIDFVReport;
+ (void)riskControlReport:(MXBuryRiskControlType)type beginTime:(NSString *)time1 endTime:(NSString *)time2 orderNumber:(nullable NSString *)order;
+ (void)currentDeviceInfoReport;

@end

NS_ASSUME_NONNULL_END
