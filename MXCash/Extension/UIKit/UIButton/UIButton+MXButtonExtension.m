//
//  UIButton+MXButtonExtension.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "UIButton+MXButtonExtension.h"

@implementation UIButton (MXButtonExtension)

+ (MXAPPLoadingButton *)buildNormalStyleButton:(NSString *)title radius:(CGFloat)radius {
    MXAPPLoadingButton *_tryButton = [MXAPPLoadingButton buttonWithType:UIButtonTypeCustom];
    [_tryButton setTitle:title forState:UIControlStateNormal];
    [_tryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _tryButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    _tryButton.layer.cornerRadius = radius;
    _tryButton.clipsToBounds = YES;
    _tryButton.backgroundColor = ORANGE_COLOR_FF8D0E;
    return _tryButton;
}

@end
