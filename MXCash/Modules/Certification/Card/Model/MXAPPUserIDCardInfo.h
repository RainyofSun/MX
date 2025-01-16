//
//  MXAPPUserIDCardInfo.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPUserIDCardInfo : NSObject

/// 姓名
@property (nonatomic, copy) NSString *walter;
/// Curp
@property (nonatomic, copy) NSString *alumnus;
/// 性别
@property (nonatomic, copy) NSString *rivalry;
/// 生日
@property (nonatomic, copy) NSString *etymology;
/// 照片地址
@property (nonatomic, copy) NSString *figures;
/// 是否需要弹出修改框  1=是需要确认信息弹窗  =0不需要 直接成功
@property (nonatomic, assign) BOOL biennially;

@end

NS_ASSUME_NONNULL_END
