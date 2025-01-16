//
//  MXAPPGradientView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TopToBottom,
    LeftToRight,
    LeftTopToRightBottom,
    LeftBottomToRightTop
} GradientDirectionStyle;

@interface MXAPPGradientView : UIView

- (void)buildGradientWithColors:(NSArray<UIColor *>*)colors gradientStyle:(GradientDirectionStyle)style;

@end

NS_ASSUME_NONNULL_END
