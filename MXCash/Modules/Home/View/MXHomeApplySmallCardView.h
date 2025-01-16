//
//  MXHomeApplySmallCardView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MXAPPProductModel;

@protocol ApplySmallCardProtocol <NSObject>

- (void)didSelectedProduct:(MXAPPProductModel *)model sender:(MXAPPLoadingButton *)sender;

@end

@interface MXHomeApplySmallCardView : UIView

@property (nonatomic, weak) id<ApplySmallCardProtocol> smallCardDelegate;

- (void)reloadSmallCardProducts:(NSArray<MXAPPProductModel *>*)products;

@end

NS_ASSUME_NONNULL_END
