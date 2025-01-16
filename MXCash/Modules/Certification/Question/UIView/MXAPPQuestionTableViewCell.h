//
//  MXAPPQuestionTableViewCell.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QuestionCellProtocol <NSObject>

- (void)didSelectedChoise:(NSDictionary *)value cellIndex:(NSIndexPath *)index;

@end

@class MXAPPQuestionModel;
@interface MXAPPQuestionTableViewCell : UITableViewCell

@property (nonatomic, weak) id<QuestionCellProtocol> cellDelegate;

- (void)reloadQuestionCell:(MXAPPQuestionModel *)cellModel indexPath:(NSIndexPath *)cellIndex;

@end

NS_ASSUME_NONNULL_END
