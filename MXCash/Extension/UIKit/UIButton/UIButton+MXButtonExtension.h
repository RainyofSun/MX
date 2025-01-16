//
//  UIButton+MXButtonExtension.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (MXButtonExtension)

+ (MXAPPLoadingButton *)buildNormalStyleButton:(NSString *)title radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
