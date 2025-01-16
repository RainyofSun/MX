//
//  MXBaseViewController.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXBaseViewController : UIViewController

@property (nonatomic, copy) NSString *buryBeginTime;
@property (nonatomic, strong, readonly) MXAPPGradientView *gradientView;

- (void)topImage:(NSString *)imageName;
- (void)updateLocation;
- (void)hideBackgroundGradientView;
- (void)resetGradientColors:(NSArray<UIColor *>*)colors;

@end

NS_ASSUME_NONNULL_END
