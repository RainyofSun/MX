//
//  MXGuideViewController.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "MXBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXGuideViewController : MXBaseViewController

@property (nonatomic, copy) void (^dismissBlock) (void);

@end

NS_ASSUME_NONNULL_END
