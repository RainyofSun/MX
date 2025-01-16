//
//  MXAPPOrderMenuView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OrderMenuProtocol <NSObject>

- (void)didSelectedMenuItem:(NSInteger)tag;

@end

@interface MXAPPOrderMenuView : UIView

@property (nonatomic, readonly) NSInteger selectedTag;

@property (nonatomic, weak) id<OrderMenuProtocol> menuDelegate;

@end

NS_ASSUME_NONNULL_END
