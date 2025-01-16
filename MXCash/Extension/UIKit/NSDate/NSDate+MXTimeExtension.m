//
//  NSDate+MXTimeExtension.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/3.
//

#import "NSDate+MXTimeExtension.h"

@implementation NSDate (MXTimeExtension)

+ (NSString *)timeStamp {
    NSString *time = [NSString stringWithFormat:@"%f", [NSDate now].timeIntervalSince1970];
    return time;
}

@end
