//
//  NSString+MXNSStringExtension.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MXNSStringExtension)

+ (BOOL)isEmptyString:(NSString *)str;
- (NSString *)maskPhoneNumber;

@end

NS_ASSUME_NONNULL_END
