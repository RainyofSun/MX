//
//  MXGuideViewController.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "MXBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GuideProtocol <NSObject>

- (void)guideDidDismiss;

@end

@interface MXGuideViewController : MXBaseViewController

@property (nonatomic, weak) id<GuideProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
