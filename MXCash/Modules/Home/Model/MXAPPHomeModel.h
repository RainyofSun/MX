//
//  MXAPPHomeModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPCustomerModel : NSObject

/// 客服小手机
@property (nonatomic, copy) NSString *corsair;
/// 客服H5连接
@property (nonatomic, copy) NSString *noted;

@end

@interface MXBannerLoopModel : NSObject

/// 广告图跳转地址
@property (nonatomic, copy) NSString *figures;
/// 图片地址
@property (nonatomic, copy) NSString *duck;

@end

@interface MXAPPProductRateModel : NSObject

@property (nonatomic, copy) NSString *coined;
@property (nonatomic, copy) NSString *originated;

@end

@interface MXAPPProductLoanModel : NSObject<YYModel>

@property (nonatomic, strong) MXAPPProductRateModel *quonehtacut;
@property (nonatomic, strong) MXAPPProductRateModel *lists;

@end

@interface MXAPPProductModel : NSObject<YYModel>

/// 产品ID
@property (nonatomic, copy) NSString *broadbill;
/// 产品名称
@property (nonatomic, copy) NSString *decoy;
/// 产品logo
@property (nonatomic, copy) NSString *docked;
/// 申请按钮文案
@property (nonatomic, copy) NSString *gibbs;
/// 申请按钮颜色
@property (nonatomic, copy) NSString *sometimes;
/// 产品金额
@property (nonatomic, copy) NSString *willard;
@property (nonatomic, copy) NSString *valuable;
/// 产品金额文案
@property (nonatomic, copy) NSString *josiah;
@property (nonatomic, copy) NSString *returning;
/// 产品期限
@property (nonatomic, copy) NSString *neill;
/// 产品期限文案
@property (nonatomic, copy) NSString *eugene;
@property (nonatomic, copy) NSString *sailors;
/// 产品利率
@property (nonatomic, copy) NSString *hale;
@property (nonatomic, copy) NSString *linguist;
/// 产品利率文案
@property (nonatomic, copy) NSString *nathan;
/// 期限logo
@property (nonatomic, copy) NSString *themes;
/// 利率logo
@property (nonatomic, copy) NSString *stamps;
/// 产品Tag
@property (nonatomic, copy) NSArray<NSString *> *commemorative;
/// 产品描述
@property (nonatomic, copy) NSString *postal;
/// 最大额度
@property (nonatomic, copy) NSString *print;
/// 订单号
@property (nonatomic, copy) NSString *unknown;
/// 订单ID
@property (nonatomic, copy) NSString *unofficially;
@property (nonatomic, strong) MXAPPProductLoanModel* arguably;

@end

@interface MXAPPHomeModel : NSObject

/// 客服
@property (nonatomic, strong) MXAPPCustomerModel *hero;
/// 跑马灯
@property (nonatomic, strong) NSArray<NSString *>*scrollMsg;
/// 首页数据
@property (nonatomic, strong) NSArray<NSDictionary *>* seals;
/// 贷款协议
@property (nonatomic, strong) NSString *laureate;
/// Banner
@property (nonatomic, strong) NSArray<MXBannerLoopModel *> *banner;
/// 大卡位
@property (nonatomic, strong) MXAPPProductModel *bigCardModel;
/// 小卡位
@property (nonatomic, strong) MXAPPProductModel *smallCardModel;
/// 产品列表
@property (nonatomic, strong) NSArray<MXAPPProductModel *> *productModels;

- (MXAPPHomeModel *)homeDataFilter;

@end

@interface MXAPPProductAuthModel : NSObject

/// 页面跳转地址
@property (nonatomic, copy) NSString *figures;

@end
NS_ASSUME_NONNULL_END
