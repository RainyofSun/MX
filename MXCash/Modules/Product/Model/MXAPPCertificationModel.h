//
//  MXAPPCertificationModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    Certification_Question,
    Certification_Card,
    Certification_Personal,
    Certification_Work,
    Certification_Contacts,
    Certification_Bank,
} CertificationType;

@interface MXAPPCertificationModel : NSObject

/// 标题
@property (nonatomic, copy) NSString *coined;
/// 是否完成
@property (nonatomic, assign) BOOL ssn;
/// 类型 【重要】用作判断,根据该字段判断跳转对应页面
@property (nonatomic, copy) NSString *oyster;
@property (nonatomic, assign, readonly) CertificationType type;
/// 图片地址
@property (nonatomic, copy) NSString *dance;
/// 跳转地址 h5绑卡页面  有值时拼接公参跳转h5页面
@property (nonatomic, copy) NSString *figures;
/// 预留字段
@property (nonatomic, copy) NSString *freedom;

@end

NS_ASSUME_NONNULL_END
