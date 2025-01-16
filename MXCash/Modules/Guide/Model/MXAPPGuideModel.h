//
//  MXAPPGuideModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPFaceBookModel : NSObject

/// CFBundleURLScheme
@property (nonatomic, copy) NSString *trumbull;
/// FacebookAppID
@property (nonatomic, copy) NSString *statuary;
/// FacebookDisplayName
@property (nonatomic, copy) NSString *statues;
/// FacebookClientToke
@property (nonatomic, copy) NSString *ives;

@end

@interface MXAPPGuideModel : NSObject

/// 1=印度（审核面）   2=墨西哥(用户面)
@property (nonatomic, copy) NSString *margaret;
/// 隐私协议
@property (nonatomic, copy) NSString *laureate;
@property (nonatomic, strong) MXAPPFaceBookModel *poet;

@end

NS_ASSUME_NONNULL_END
