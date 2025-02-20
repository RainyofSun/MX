//
//  MXAPPOrderContentView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPOrderContentView : UIView

@property (nonatomic, copy) void(^GotoHomeBlock)(void);

- (void)refreshOrder;

@end

NS_ASSUME_NONNULL_END
