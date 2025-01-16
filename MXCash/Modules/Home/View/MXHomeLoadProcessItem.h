//
//  MXHomeLoadProcessItem.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXHomeLoadProcessItem : UIControl

- (instancetype)initWithFrame:(CGRect)frame imgViewSize:(CGSize)size;
- (void)setItemTitle:(NSString *)title andImage:(NSString *)image;
- (void)setTitleColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
