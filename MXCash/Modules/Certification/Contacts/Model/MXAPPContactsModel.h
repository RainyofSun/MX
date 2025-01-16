//
//  MXAPPContactsModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/15.
//

#import <Foundation/Foundation.h>
#import "MXAPPQuestionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPReportAllContactsModel : NSObject

/// 手机号
@property (nonatomic, copy) NSString *edward;
/// 更新时间
@property (nonatomic, copy) NSString *soccer;
/// 创建时间
@property (nonatomic, copy) NSString *wnba;
/// 生日 etymology
@property (nonatomic, copy) NSString *etymology;
/// 邮箱
@property (nonatomic, copy) NSString *currently;
/// 姓名
@property (nonatomic, copy) NSString *robin;
/// 备注
@property (nonatomic, copy) NSString *uncasville;

@end

@interface MXAPPEmergencyPersonModel : NSObject

/// 联系人姓名
@property (nonatomic, copy) NSString *robin;
/// 联系人关系
@property (nonatomic, copy) NSString *feat;
/// 联系人电话
@property (nonatomic, copy) NSString *repeated;
/// 标记
@property (nonatomic, assign) NSInteger personTag;

@end

@interface MXAPPContactsPeopleModel : NSObject<YYModel>

/// 联系人是否填写 空表示未填写
@property (nonatomic, copy) NSString *feat;
/// 联系人名字
@property (nonatomic, copy) NSString *robin;
/// 联系人电话
@property (nonatomic, copy) NSString *repeated;
/// 一级标题
@property (nonatomic, copy) NSString *coined;
/// 二级关系标题
@property (nonatomic, copy) NSString *programs;
/// 预留文案
@property (nonatomic, copy) NSString *championships;
/// 二级手机号码和联系人标题
@property (nonatomic, copy) NSString *ncaa;
/// 预留字文案
@property (nonatomic, copy) NSString *uconn;
/// 关系
@property (nonatomic, strong) NSArray<MXAPPQuestionChoiseModel *> *fish;

@end

@interface MXAPPContactsModel : NSObject<YYModel>

@property (nonatomic, strong) NSArray<MXAPPContactsPeopleModel *>* titles;

@end

NS_ASSUME_NONNULL_END
