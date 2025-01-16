//
//  MXCustomTextFiled.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXCustomTextFiled.h"

@implementation MXCustomTextFiled

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds: bounds];
    rect.origin.x += 5;
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super rightViewRectForBounds: bounds];
    rect.origin.x -= 5;
    return rect;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 8, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 8, 0);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:)) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end
