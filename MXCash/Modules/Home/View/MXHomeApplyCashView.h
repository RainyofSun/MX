//
//  MXHomeApplyCashView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MXAPPProductModel, MXAPPLoadingButton;

@protocol HomeApplyCashProtocol <NSObject>

- (void)clickLoanApply:(MXAPPLoadingButton *)sender;

@end

@interface MXHomeApplyCashView : UIImageView

@property (nonatomic, weak) id<HomeApplyCashProtocol> cashDelegate;

- (void)reloadCashMarquee:(NSArray <NSString *>*)marquee;
- (void)reloadRecommendProductModel:(MXAPPProductModel *)productModel;

@end

NS_ASSUME_NONNULL_END
