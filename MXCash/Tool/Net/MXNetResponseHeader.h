//
//  MXNetResponseHeader.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#ifndef MXNetResponseHeader_h
#define MXNetResponseHeader_h

struct SuccessResponse {
    /// 字典模型
    NSDictionary * _Nullable jsonDict;
    /// 数组模型
    NSArray * _Nullable jsonArray;
    /// 请求的消息 --> 服务器返回的消息
    NSString * _Nullable responseMsg;
};

/**
 * 网络请求类型
 */
typedef NS_ENUM(NSInteger,AFNRequestType) {
    AFNRequestType_Get,             /// get请求
    AFNRequestType_Post,            /// post请求
    AFNRequestType_Upload,          /// 上传图片
    AFNRequestType_Download,        /// 文件下载
};

/*
    block 回调
 */
typedef void(^ _Nonnull SuccessCallBack)(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject);
typedef void(^ _Nullable FailureCallBack)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error);

#endif /* MXNetResponseHeader_h */
