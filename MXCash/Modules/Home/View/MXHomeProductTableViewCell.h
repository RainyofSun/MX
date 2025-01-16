//
//  MXHomeProductTableViewCell.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MXAPPProductModel;

@interface MXHomeProductTableViewCell : UITableViewCell

@property (nonatomic, strong) MXAPPLoadingButton *applyBtn;

- (void)reloadProduct:(MXAPPProductModel *)model;

@end

NS_ASSUME_NONNULL_END
