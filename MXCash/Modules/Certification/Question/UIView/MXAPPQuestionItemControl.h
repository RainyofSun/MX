//
//  MXAPPQuestionItemControl.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPQuestionItemControl : UIControl

@property (nonatomic, strong) NSMutableDictionary *value;
@property (nonatomic, strong) NSNumber *selectTag;

- (void)setControlTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
