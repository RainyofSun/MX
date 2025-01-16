//
//  MXNetRequestManager.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import <Foundation/Foundation.h>
#import "MXNetRequestProtocol.h"

@interface MXNetRequestManager : NSObject

+ (void)AFNReqeustType:(id<MXNetRequestProtocol>)requestAPI success:(SuccessCallBack)success failure:(FailureCallBack)failure;

/**
 * @brief                                       基本数据请求
 * @param   requestType AFNRequestType          数据请求类型
 * @param   url         NSString                请求地址
 * @param   params      NSDictionary            请求参数
 * @param   success     SuccessCallBack         成功返回
 * @param   failure     FailureCallBack         失败返回
 * @return              NSURLSessionDataTask    请求标识
 */
+ (nullable NSURLSessionTask *)AFNReqeustType:(AFNRequestType)requestType reqesutUrl:(NSString*)url params:(NSDictionary<NSString *, NSString *>*)params success:(SuccessCallBack)success failure:(FailureCallBack)failure;

@end
