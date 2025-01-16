//
//  MXAPPPopBaseView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/10.
//

#import "MXAPPPopBaseView.h"

@interface MXAPPPopBaseView ()

@property (nonatomic, strong) UIImageView *popBgLightImgView;

@end

@implementation MXAPPPopBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self layoutPopViews];
    }
    return self;
}

- (void)dealloc {
    DDLogDebug(@"%s -- %@", __func__, NSStringFromClass(self.class));
}

- (void)setupUI {
    self.topDistance = 0;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self.closeBtn addTarget:self action:@selector(dismissAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.popBgLightImgView];
    [self addSubview:self.contentView];
    [self addSubview:self.popBgImgView];
    [self addSubview:self.popTitleLab];
    [self addSubview:self.closeBtn];
}

- (void)layoutPopViews {
    
    [self.popBgLightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.popBgLightImgView).offset(PADDING_UNIT * 3);
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 8);
        make.right.mas_equalTo(self).offset(-PADDING_UNIT * 8);
    }];
    
    [self.popBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        if (self.topDistance == 0) {
            make.top.mas_equalTo(self.contentView).mas_equalTo(-PADDING_UNIT * 20);
        } else {
            make.top.mas_equalTo(self.contentView).mas_equalTo(-self.topDistance);
        }
    }];
    
    [self.popTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 14);
        make.top.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 5);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(PADDING_UNIT * 5);
        make.centerX.mas_equalTo(self.contentView);
        make.size.mas_equalTo(25);
    }];
}

- (void)setConfirmTitle:(NSString *)confirmTitle {
    _confirmTitle = confirmTitle;
    if (!_confirmBtn) {
        _confirmBtn = [MXAPPLoadingButton buildNormalStyleButton:confirmTitle radius:10];
        [_confirmBtn addTarget:self action:@selector(clickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setPopBackgrooundImage:(NSString *)img popTitle:(nonnull NSString *)title {
    self.popBgImgView.image = [UIImage imageNamed:img];
    self.popTitleLab.text = [[MXAPPLanguage language] languageValue:title];
}

- (void)popAnimation {
    self.closeBtn.transform = CGAffineTransformMakeScale(0.9, 0.9);
    self.popBgImgView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    self.contentView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.25 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.closeBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.popBgImgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished){
        
    }];
}

- (void)dismissAnimation {
    [UIView transitionWithView:self duration:.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.clickCloseBlock != nil) {
            self.clickCloseBlock(self);
        }
        [self removeFromSuperview];
    }];
}

- (void)clickConfirmButton:(MXAPPLoadingButton *)sender {
    if ([self respondsToSelector:@selector(clickConfirm)]) {
        [self clickConfirm];
    }
    self.clickConfirmBlock(sender, self);
}

- (UIImageView *)popBgLightImgView {
    if (!_popBgLightImgView) {
        _popBgLightImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_light"]];
    }
    
    return _popBgLightImgView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 16;
        _contentView.clipsToBounds = YES;
    }
    
    return _contentView;
}

- (UILabel *)popTitleLab {
    if (!_popTitleLab) {
        _popTitleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _popTitleLab.textColor = [UIColor whiteColor];
        _popTitleLab.font = [UIFont systemFontOfSize:18];
    }
    
    return _popTitleLab;
}

- (UIImageView *)popBgImgView {
    if (!_popBgImgView) {
        _popBgImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _popBgImgView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"pod_close"] forState:UIControlStateNormal];
    }
    
    return _closeBtn;
}

- (void)clickConfirm {
}

@end
