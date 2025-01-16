//
//  MXHomeApplyBigCardView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ApplyBigCardProtocol <NSObject>

- (void)clickApplyPlan;
- (void)clickFeedBack;

@end

@interface MXHomeApplyBigCardView : UIView

@property (nonatomic, weak) id<ApplyBigCardProtocol> bigCardDelegate;

@end

NS_ASSUME_NONNULL_END
