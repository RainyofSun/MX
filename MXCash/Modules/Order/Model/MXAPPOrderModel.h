//
//  MXAPPOrderModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPOrderInfo : NSObject

/// 标题
@property (nonatomic, copy) NSString *coined;
/// 值
@property (nonatomic, copy) NSString *departed;

@end

@interface MXAPPOrderItemModel : NSObject<YYModel>

/// 订单ID
@property (nonatomic, copy) NSString *unofficially;
/// 产品名称
@property (nonatomic, copy) NSString *decoy;
/// 产品logo
@property (nonatomic, copy) NSString *docked;
/// 订单状态
@property (nonatomic, copy) NSString *ac;
/// 状态名称
@property (nonatomic, copy) NSString *gibbs;
/// 订单描述
@property (nonatomic, copy) NSString *sport;
/// 借款金额
@property (nonatomic, copy) NSString *teamtennis;
/// 跳转地址
@property (nonatomic, copy) NSString *foxforce;
/// 日期文案
@property (nonatomic, copy) NSString *football;
/// 额度文案
@property (nonatomic, copy) NSString *franchise;
/// 展期日期
@property (nonatomic, copy) NSString *disbanded;
/// 逾期天数
@property (nonatomic, assign) NSInteger brooklyn;
/// 是否放款
@property (nonatomic, assign) BOOL blues;
/// 借款时间
@property (nonatomic, copy) NSString *hartfords;
/// 应还时间
@property (nonatomic, copy) NSString *carolina;
/// 借款期限
@property (nonatomic, copy) NSString *coin;
/// 订单列表显示数据
@property (nonatomic, strong) NSArray<MXAPPOrderInfo *>* raleigh;
/// 借款协议展示文案
@property (nonatomic, copy) NSString *civic;
/// 协议地址
@property (nonatomic, copy) NSString *whalers;

@end

@interface MXAPPOrderModel : NSObject<YYModel>

@property (nonatomic, strong) NSArray<MXAPPOrderItemModel *>* seals;

@end

NS_ASSUME_NONNULL_END
