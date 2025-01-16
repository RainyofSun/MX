//
//  MXNetRequestConfig.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "MXNetRequestConfig.h"
#import "MXNetRequestURL.h"

@implementation MXNetRequestConfig

+ (instancetype)requestConfig {
    static MXNetRequestConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (config == nil) {
            config = [[MXNetRequestConfig alloc] init];
        }
    });
    
    return config;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaultConfig];
    }
    return self;
}

- (void)setDefaultConfig {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30;
    config.allowsCellularAccess = YES;
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[MXNetRequestURL shared].requestURL sessionConfiguration:config];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/png",@"image/jpeg",@"multipart/form-data", nil];
}

- (void)updateRequestURL {
    [self.manager.requestSerializer willChangeValueForKey:@"baseURL"];
    [self.manager setValue:[MXNetRequestURL shared].requestURL forKey:@"baseURL"];
    [self.manager.requestSerializer didChangeValueForKey:@"baseURL"];
    
//    // 假设你想要修改的新baseURL
//    NSURLSessionConfiguration *configuration = [self.manager.session.configuration copy];
//    // 创建一个新的manager使用修改后的configuration
//    AFHTTPSessionManager *newManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[MXNetRequestURL shared].requestURL sessionConfiguration:configuration];
//     
//    // 配置newManager其他的参数，如headers, timeoutInterval等
//    newManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.manager = newManager;
}

@end
