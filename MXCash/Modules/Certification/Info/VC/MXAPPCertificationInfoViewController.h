//
//  MXAPPCertificationInfoViewController.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PersonalInfo,
    WorkingInfo,
    BankInfo,
} CertificationInfoType;

@interface MXAPPCertificationInfoViewController : MXBaseViewController

- (instancetype)initWithCertificationProcess:(CGFloat)process infoType:(CertificationInfoType)type;

@end

NS_ASSUME_NONNULL_END
