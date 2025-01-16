//
//  MXNetRequestConfig.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXNetRequestConfig : NSObject

/** 网络请求管理 */
@property (nonatomic,strong) AFHTTPSessionManager* manager;

+ (instancetype)requestConfig;
- (void)updateRequestURL;

@end

NS_ASSUME_NONNULL_END
