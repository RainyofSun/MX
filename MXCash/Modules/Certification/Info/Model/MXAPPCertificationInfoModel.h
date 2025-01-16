//
//  MXAPPCertificationInfoModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/14.
//

#import <Foundation/Foundation.h>
#import "MXAPPQuestionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPCertificationInfoModel : NSObject<YYModel>

@property (nonatomic, strong) NSArray<MXAPPQuestionModel *>* mantis;

@end

NS_ASSUME_NONNULL_END
