//
//  MXAPPLanguage.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    English,
    Mexico,
} LanguageBundleType;

@interface MXAPPLanguage : NSObject

+ (instancetype)language;

- (NSString *)languageValue:(NSString *)languageKey;
- (void)setLanguageBundleType: (LanguageBundleType)type;

@end

NS_ASSUME_NONNULL_END
