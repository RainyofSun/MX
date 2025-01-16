//
//  MXAPPPopBaseView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPPopBaseView : UIView

@property (nonatomic, strong) UIImageView *popBgImgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *popTitleLab;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, copy) NSString *confirmTitle;
@property (nonatomic, strong, readonly) MXAPPLoadingButton *confirmBtn;
@property (nonatomic, copy) void(^clickConfirmBlock)(MXAPPLoadingButton *, MXAPPPopBaseView *);
@property (nonatomic, copy) void(^clickCloseBlock)(MXAPPPopBaseView *);
@property (nonatomic, assign) CGFloat topDistance;

- (void)setupUI;
- (void)layoutPopViews;

- (void)setPopBackgrooundImage:(NSString *)img popTitle:(NSString *)title;
- (void)popAnimation;
- (void)dismissAnimation;
- (void)clickConfirmButton:(MXAPPLoadingButton *)sender;
- (void)clickConfirm;

@end

NS_ASSUME_NONNULL_END
