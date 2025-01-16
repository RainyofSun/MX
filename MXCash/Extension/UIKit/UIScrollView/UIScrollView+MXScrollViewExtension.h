//
//  UIScrollView+MXScrollViewExtension.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MXScrollViewExtension)

- (void)addMJRefresh:(BOOL)userFooter refreshCall:(void(^)(BOOL refresh))callBlock;
- (void)reload:(BOOL)isEmpty;
- (void)refresh:(BOOL)begin;
- (void)loadMore:(BOOL)begin;

@end

NS_ASSUME_NONNULL_END
