//
//  MXAPPSingleChoiseView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/14.
//

#import "MXAPPPopBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class MXAPPQuestionChoiseModel;

@interface MXAPPSingleChoiseView : MXAPPPopBaseView

@property (nonatomic, strong, readonly) MXAPPQuestionChoiseModel *selectModel;

- (void)reloadSource:(NSArray<MXAPPQuestionChoiseModel *> *)models;

@end

NS_ASSUME_NONNULL_END
