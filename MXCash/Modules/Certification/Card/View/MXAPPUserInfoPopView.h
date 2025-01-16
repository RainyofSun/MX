//
//  MXAPPUserInfoPopView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/13.
//

#import "MXAPPPopBaseView.h"
#import "MXCustomTextFiled.h"

NS_ASSUME_NONNULL_BEGIN

@class MXAPPUserIDCardInfo;

@interface MXAPPUserInfoPopItem : UIView

@property (nonatomic, strong) MXCustomTextFiled *textFiled;

- (void)setItemTitle:(NSString *)title value:(NSString *)value;

@end

@interface MXAPPUserInfoPopView : MXAPPPopBaseView

@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *idNumber;
@property (nonatomic, copy, readonly) NSString *birthday;

- (void)reloadUserinfoPop:(MXAPPUserIDCardInfo *)userModel;

@end

NS_ASSUME_NONNULL_END
