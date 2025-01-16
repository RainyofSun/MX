//
//  MXAPPGradientView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/3.
//

#import "MXAPPGradientView.h"

@implementation MXAPPGradientView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (void)buildGradientWithColors:(NSArray<UIColor *> *)colors gradientStyle:(GradientDirectionStyle)style {
    if (![self.layer isKindOfClass:[CAGradientLayer class]]) {
        return;
    }
    
    CAGradientLayer *tempLayer = (CAGradientLayer *)self.layer;
    
    NSMutableArray *cgColor = [NSMutableArray array];
    [colors enumerateObjectsUsingBlock:^(UIColor *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [cgColor addObject:(__bridge id)obj.CGColor];
    }];
    
    tempLayer.colors = cgColor;
    
    CGPoint startPoint = CGPointMake(0.5, 0);
    CGPoint endPoint = CGPointMake(0.5, 1.0);
    
    switch (style) {
        case TopToBottom:
            startPoint = CGPointMake(0.5, 0);
            endPoint = CGPointMake(0.5, 1.0);
            break;
        case LeftToRight:
            startPoint = CGPointMake(0, 0.5);
            endPoint = CGPointMake(1.0, 0.5);
            break;
        case LeftBottomToRightTop:
            startPoint = CGPointMake(0, 1.0);
            endPoint = CGPointMake(1.0, 0);
            break;
        case LeftTopToRightBottom:
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(1.0, 1.0);
            break;
        default:
            break;
    }
    
    tempLayer.startPoint = startPoint;
    tempLayer.endPoint = endPoint;
}

@end
