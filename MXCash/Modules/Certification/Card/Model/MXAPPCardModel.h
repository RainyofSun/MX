//
//  MXAPPCardModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPCardStatusModel : NSObject

/// 状态 0未完成 1已完成
@property (nonatomic, assign) BOOL ssn;
/// 图片地址
@property (nonatomic, copy) NSString *figures;

@end

@interface MXAPPCardModel : NSObject<YYModel>

/// 身份证正面
@property (nonatomic, strong) MXAPPCardStatusModel *surprises;
/// 活体认证
@property (nonatomic, strong) MXAPPCardStatusModel *father;
/// 卡片前文案
@property (nonatomic, copy) NSString *id_front_msg;
/// 活体认证文案
@property (nonatomic, copy) NSString *face_msg;

@end

NS_ASSUME_NONNULL_END
