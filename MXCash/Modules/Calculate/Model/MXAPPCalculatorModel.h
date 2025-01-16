//
//  MXAPPCalculatorModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPCalculatorPlanModel : NSObject

/// 还款日
@property (nonatomic, copy) NSString *carved;
/// 序号
@property (nonatomic, assign) NSInteger sell;
/// 本金
@property (nonatomic, copy) NSString *facetiously;
/// 利息
@property (nonatomic, copy) NSString *peddlers;
/// 剩余本金
@property (nonatomic, copy) NSString *grinders;

@end

@interface MXAPPCalculatorModel : NSObject<YYModel>

/// 每月还款金额
@property (nonatomic, copy) NSString *unsuspecting;
/// 本金
@property (nonatomic, copy) NSString *numerous;
/// 总利息
@property (nonatomic, copy) NSString *shaped;
/// 总金额
@property (nonatomic, copy) NSString *wood;
/// 还款计划
@property (nonatomic, copy) NSArray<MXAPPCalculatorPlanModel *> *knobs;

@end

NS_ASSUME_NONNULL_END
