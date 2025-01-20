//
//  MXAPPLoanModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import <Foundation/Foundation.h>
#import "MXAPPCertificationModel.h"
#import "MXAPPHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPProtocolModel : NSObject

/// 标题
@property (nonatomic, copy) NSString *coined;
/// 跳转
@property (nonatomic, copy) NSString *sperm;

@end

@interface MXAPPWaitCertificationModel : NSObject

@property (nonatomic, copy) NSString *oyster;
@property (nonatomic, assign, readonly) CertificationType type;
/// 跳转地址 h5绑卡页面  有值时拼接公参跳转h5页面
@property (nonatomic, copy) NSString *figures;
@property (nonatomic, copy) NSString *coined;

@end

@interface MXAPPLoanModel : NSObject<YYModel>

@property (nonatomic, strong) MXAPPProductModel *centuries;
@property (nonatomic, strong) NSArray<MXAPPCertificationModel *>* schooner;
@property (nonatomic, strong) MXAPPProtocolModel *whale;
@property (nonatomic, strong) MXAPPWaitCertificationModel *inanimate;

@end

@interface MXAPPApplyModel : NSObject

@property (nonatomic, copy) NSString *figures;

@end
NS_ASSUME_NONNULL_END
