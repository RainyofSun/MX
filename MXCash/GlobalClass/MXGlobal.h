//
//  MXGlobal.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import <Foundation/Foundation.h>
#import "MXLoginModel.h"

static NSString * const APP_LOGIN_STATUS = @"isLoginOut";

@interface MXGlobal : NSObject

/// 登录信息
@property (nonatomic, strong) MXLoginModel * loginModel;
/// 语言代码 1 = 印度 2 = 墨西哥
@property (nonatomic, copy) NSString *languageCode;
/// 隐私协议
@property (nonatomic, copy) NSString *privateProtocol;
/// 产品ID
@property (nonatomic, copy) NSString *productIDNumber;
/// 产品金额
@property (nonatomic, copy) NSString *productAmountNumber;
/// 产品利率
@property (nonatomic, copy) NSString *productRate;
/// 订单号
@property (nonatomic, copy) NSString *productOrderNumber;
@property (nonatomic, assign, readonly) BOOL isLoginOut;

+ (instancetype)global;

- (NSString *)cityPath;
- (NSString *)saveImagePath:(NSString *)imageFileName;
- (void)encoderUserLoginInfo;
- (void)decoderUserLoginInfo;
- (void)deleteUserLoginInfo;

@end
