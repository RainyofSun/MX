//
//  MXNetRequestManager.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "MXNetRequestManager.h"
#import <AFNetworking/AFNetworking.h>
#import "MXNetRequestConfig.h"
#import "MXCommonParams.h"
#import "MXNetResponseModel.h"

@implementation MXNetRequestManager

+ (void)AFNReqeustType:(id<MXNetRequestProtocol>)requestAPI success:(SuccessCallBack)success failure:(FailureCallBack)failure {
    NSDictionary *params;
    AFNRequestType type = AFNRequestType_Post;
    NSString *urlPath;
    if ([requestAPI respondsToSelector:@selector(requestParams)]) {
        params = [requestAPI requestParams];
    }
    
    if ([requestAPI respondsToSelector:@selector(requestType)]) {
        type = [requestAPI requestType];
    }
    
    if ([requestAPI respondsToSelector:@selector(requestURLPath)]) {
        urlPath = [requestAPI requestURLPath];
    }
    
    if (params == nil || [NSString isEmptyString:urlPath]) {
        return;
    }
    
    [self AFNReqeustType:type reqesutUrl:urlPath params:params success:success failure:failure];
}

+ (NSURLSessionTask *)AFNReqeustType:(AFNRequestType)requestType reqesutUrl:(NSString *)url params:(NSDictionary<NSString *,NSString *> *)params success:(SuccessCallBack)success failure:(FailureCallBack)failure {
    NSString *requestUrl = [MXCommonParams splicingCommonArgus:url];
# if DEBUG
    NSLog(@"RequestURL = \n %@ \n Params = \n %@ \n End ---------", requestUrl, params);
#endif
    if (requestType == AFNRequestType_Get) {
        return [[MXNetRequestConfig requestConfig].manager GET:requestUrl parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            MXNetResponseModel *responseModel = [self jsonToModel:responseObject requestTask:task];
            if (responseModel.reqeustError) {
                failure(nil, responseModel.reqeustError);
            } else {
                struct SuccessResponse response;
                response.responseMsg = responseModel.troubadour;
                if ([responseModel.gibson isKindOfClass:[NSDictionary class]]) {
                    response.jsonDict = (NSDictionary *)responseModel.gibson;
                }
                
                if ([responseModel.gibson isKindOfClass:[NSArray class]]) {
                    response.jsonArray = (NSArray *)responseModel.gibson;
                }
                success(task, response);
            }
        } failure: failure];
    } else if (requestType == AFNRequestType_Post) {
        return [[MXNetRequestConfig requestConfig].manager POST:requestUrl parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            MXNetResponseModel *responseModel = [self jsonToModel:responseObject requestTask:task];
            if (responseModel.reqeustError) {
                failure(nil, responseModel.reqeustError);
            } else {
                struct SuccessResponse response;
                response.responseMsg = responseModel.troubadour;
                if ([responseModel.gibson isKindOfClass:[NSDictionary class]]) {
                    response.jsonDict = (NSDictionary *)responseModel.gibson;
                }
                
                if ([responseModel.gibson isKindOfClass:[NSArray class]]) {
                    response.jsonArray = (NSArray *)responseModel.gibson;
                }
                success(task, response);
            }
        } failure: failure];
    } else if (requestType == AFNRequestType_Upload) {
        return [[MXNetRequestConfig requestConfig].manager POST:requestUrl parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
                if ([obj hasPrefix:@"File"]) {
                    NSArray<NSString *>* strArray = [obj componentsSeparatedByString:@"$"];
                    NSData *data = [NSData dataWithContentsOfFile:strArray.lastObject];
                    [formData appendPartWithFileData:data name:key fileName:key mimeType:@"image/png"];
                    *stop = YES;
                }
            }];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            MXNetResponseModel *responseModel = [self jsonToModel:responseObject requestTask:task];
            if (responseModel.reqeustError) {
                failure(nil, responseModel.reqeustError);
            } else {
                struct SuccessResponse response;
                response.responseMsg = responseModel.troubadour;
                if ([responseModel.gibson isKindOfClass:[NSDictionary class]]) {
                    response.jsonDict = (NSDictionary *)responseModel.gibson;
                }
                
                if ([responseModel.gibson isKindOfClass:[NSArray class]]) {
                    response.jsonArray = (NSArray *)responseModel.gibson;
                }
                success(task, response);
            }
        } failure: failure];
    } else {
        NSURLSessionDownloadTask *downloadTask = [[MXNetRequestConfig requestConfig].manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
            return [documentsDirectoryPath URLByAppendingPathComponent:[response.suggestedFilename lastPathComponent]];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            NSString *fileContent = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:filePath] encoding:NSUTF8StringEncoding];
            struct SuccessResponse res;
            res.responseMsg = fileContent;
            success(nil, res);
        }];
        
        [downloadTask resume];
        
        return downloadTask;
    }
}

+ (nullable MXNetResponseModel *)jsonToModel:(id)responseObject requestTask:(NSURLSessionTask *)task {
    NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
#if DEBUG
    NSLog(@"RequestURL = \n %@ \n Response = \n %@ \nEnd -------", task.currentRequest.URL.absoluteString, jsonStr);
#endif
    if ([NSString isEmptyString:jsonStr]) {
        return nil;
    }
    
    MXNetResponseModel *responseModel = [MXNetResponseModel modelWithJSON:jsonStr];
    if (responseModel.nekita == -2) {
        responseModel.reqeustError = [[NSError alloc] initWithDomain:@"request.error" code:responseModel.nekita userInfo:@{NSLocalizedFailureReasonErrorKey: responseModel.troubadour}];
        // 登录失效.重新登录
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSNotificationName)APP_LOGIN_EXPIRED_NOTIFICATION object:nil];
        return responseModel;
    }
    
    if (responseModel.nekita != 0) {
        responseModel.reqeustError = [[NSError alloc] initWithDomain:@"request.error" code:responseModel.nekita userInfo:@{NSLocalizedFailureReasonErrorKey: responseModel.troubadour}];
        [[UIDevice currentDevice].keyWindow makeToast: responseModel.troubadour];
        return responseModel;
    }
    
    return responseModel;
}

@end
