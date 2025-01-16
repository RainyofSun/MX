//
//  MXUserDefaultCache.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXUserDefaultCache : NSObject

+ (BOOL)isFirstTimeInstallApp;
+ (void)cacheLoginInfo:(NSString *)info;
+ (NSString *)readLoginInfoFormCache;
+ (void)deleteLoginInfoCache;
+ (void)cacheLanguageCode:(NSString *)code;
+ (LanguageBundleType)readLanguageCodeFromCache;

@end

NS_ASSUME_NONNULL_END
