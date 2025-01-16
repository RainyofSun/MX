//
//  MXGlobal.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import "MXGlobal.h"
#import "MXUserDefaultCache.h"

@implementation MXGlobal

+ (instancetype)global {
    static MXGlobal *gl;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (gl == nil) {
            gl = [[MXGlobal alloc] init];
        }
    });
    
    return gl;
}

- (BOOL)isLoginOut {
    return self.loginModel == nil || [self.loginModel isEqual:[NSNull null]];
}

- (NSString *)cityPath {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    documentPath = [documentPath stringByAppendingPathComponent:@"/city.json"];
    return documentPath;
}

- (NSString *)saveImagePath:(NSString *)imageFileName {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    documentPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",imageFileName]];
    return documentPath;
}

- (void)encoderUserLoginInfo {
    NSString *jsonStr = self.loginModel.modelToJSONString;
    if (jsonStr.length != 0) {
        [MXUserDefaultCache cacheLoginInfo:jsonStr];
    }
}

- (void)decoderUserLoginInfo {
    NSString *jsonStr = [MXUserDefaultCache readLoginInfoFormCache];
    if (jsonStr.length == 0) {
        return;
    }
    
    self.loginModel = [MXLoginModel modelWithJSON:jsonStr];
}

- (void)deleteUserLoginInfo {
    self.productIDNumber = nil;
    self.loginModel = nil;
    [MXUserDefaultCache deleteLoginInfoCache];
}

@end
