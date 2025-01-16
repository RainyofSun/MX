//
//  MXAPPCardItem.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPCardItem : UIControl

- (instancetype)initWithFrame:(CGRect)frame isFront:(BOOL)front;
- (void)updateCardItemTitle:(NSString  * _Nullable)title cardImg:(NSString *)imgUrl;

@end

NS_ASSUME_NONNULL_END
