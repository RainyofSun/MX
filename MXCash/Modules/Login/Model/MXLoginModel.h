//
//  MXLoginModel.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXLoginModel : NSObject

/// 登录手机号
@property (nonatomic, copy) NSString *composer;
/// 登录态
@property (nonatomic, copy) NSString *winsted;

@end

NS_ASSUME_NONNULL_END
