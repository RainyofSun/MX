//
//  MXAPPOrderTableViewCell.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPLoanInfoItem : UIView

- (void)setTitle:(NSString *)title value:(NSString *)value;

@end

@class MXAPPOrderItemModel;

@interface MXAPPOrderTableViewCell : UITableViewCell

- (void)reloadOrderCell:(MXAPPOrderItemModel *)model;

@end

NS_ASSUME_NONNULL_END
