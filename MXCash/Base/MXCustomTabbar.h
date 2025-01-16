//
//  MXCustomTabbar.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MXCustomTabbar;

@protocol APPCustomTabbarProtocol <NSObject>

/// 是否可以选中当前 Item
- (BOOL)canSelected:(NSInteger)shouldSelectedIndex;
/// 选中当前Item
- (void)didSelectedItem:(MXCustomTabbar *)bar item:(UIButton *)item selectedIndex:(NSInteger)index;

@end

@interface MXCustomTabbar : UITabBar

@property (nonatomic, weak) id<APPCustomTabbarProtocol> barDelegate;

- (void)setTabbarWithTitles:(NSArray<NSString *>*)titles barItemImages:(NSArray <NSString *>*)normalImgs barSelectedImgages:(NSArray <NSString *>*)selectedImages;
- (void)selectedTabbarItem:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
