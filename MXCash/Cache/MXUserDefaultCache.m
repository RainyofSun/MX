//
//  MXUserDefaultCache.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import "MXUserDefaultCache.h"
#import "MXCacheKeyHeader.h"

@implementation MXUserDefaultCache

+ (BOOL)isFirstTimeInstallApp {
    NSString *value = [[self MXGetCacheValueForKey:cache_login_info_key] stringValue];
    if (value.length != 0) {
        return NO;
    }
    
#if DEBUG
#else
    [self MXCacheValue:cache_login_info_key forKey:cache_login_info_key];
#endif
    return YES;
}

+ (void)cacheLoginInfo:(NSString *)info {
    [self MXCacheValue:info forKey:cache_login_info_key];
}

+ (NSString *)readLoginInfoFormCache {
    return [[self MXGetCacheValueForKey:cache_login_info_key] stringValue];
}

+ (void)deleteLoginInfoCache {
    [self MXRemoveValueForKey:cache_login_info_key];
}

+ (void)cacheLanguageCode:(NSString *)code {
    [self MXCacheValue:code forKey:language_code_key];
}

+ (LanguageBundleType)readLanguageCodeFromCache {
    NSString *code = [self MXGetCacheValueForKey:language_code_key];
    if ([code isEqualToString:@"en"]) {
        return English;
    } else if ([code isEqualToString:@"es"]) {
        return Mexico;
    } else {
        return English;
    }
}

+ (void)MXCacheValue:(id)value forKey:(NSString *)key {
    if (value && key.length) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"存储数据不合法");
    }
}

+ (id)MXGetCacheValueForKey:(NSString *)key {
    if (key.length) {
        id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        return value;
    } else {
        NSLog(@"key 不合法");
        return nil;
    }
}

+ (BOOL)MXRemoveValueForKey:(NSString *)key {
    BOOL remove = NO;
    if (key.length) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        remove = YES;
    } else {
        NSLog(@"key 不合法");
    }
    return remove;
}

@end
