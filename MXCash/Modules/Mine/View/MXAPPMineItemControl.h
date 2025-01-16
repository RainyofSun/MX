//
//  MXAPPMineItemControl.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPMineItemControl : UIControl

@property (nonatomic, copy) NSString *jumpURL;

- (void)setItemTitle:(NSString *)title andImage:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
