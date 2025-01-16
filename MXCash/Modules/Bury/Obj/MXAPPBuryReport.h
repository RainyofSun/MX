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
    APP_Questionnaire,
    APP_TakingCardPhoto,
    APP_Face,
    APP_PersonalInfo,
    APP_WorkingInfo,
    APP_Contacts,
    APP_BindingBankCard,
    APP_BeginLoanApply,
    APP_EndLoanApply
} MXBuryRiskControlType;

@interface MXAPPBuryReport : NSObject

+ (void)appLocationReport;
+ (void)IDFAAndIDFVReport;
+ (void)riskControlReport:(MXBuryRiskControlType)type beginTime:(NSString *)time1 endTime:(NSString *)time2 orderNumber:(nullable NSString *)order;
+ (void)currentDeviceInfoReport;

@end

NS_ASSUME_NONNULL_END
