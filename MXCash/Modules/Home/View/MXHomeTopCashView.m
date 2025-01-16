//
//  MXHomeTopCashView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import "MXHomeTopCashView.h"

@interface MXHomeTopCashView ()

@property (nonatomic, strong) UILabel *welcomeLab;
@property (nonatomic, strong) UIView *tipView;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UIImageView *cashImgView;

@end

@implementation MXHomeTopCashView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.welcomeLab];
    [self addSubview:self.tipView];
    [self.tipView addSubview:self.tipLab];
    [self addSubview:self.cashImgView];
    
    [self.welcomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
        make.top.mas_equalTo(self).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight);
    }];
    
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.welcomeLab);
        make.top.mas_equalTo(self.welcomeLab.mas_bottom).offset(PADDING_UNIT * 3.5);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tipView).offset(PADDING_UNIT * 3);
        make.top.mas_equalTo(self.tipView).offset(PADDING_UNIT * 3.5);
        make.bottom.mas_equalTo(self.tipView).offset(-PADDING_UNIT * 3.5);
        make.right.mas_equalTo(self.tipView).offset(-PADDING_UNIT * 5);
        make.width.mas_equalTo(ScreenWidth * 0.73);
    }];
    
    [self.cashImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-PADDING_UNIT);
        make.top.mas_equalTo(self.welcomeLab).offset(-3);
        make.bottom.mas_equalTo(self).offset(-PADDING_UNIT * 5);
    }];
}

- (UILabel *)welcomeLab {
    if (!_welcomeLab) {
        _welcomeLab = [[UILabel alloc] init];
        _welcomeLab.text = [[MXAPPLanguage language] languageValue:@"home_title"];
        _welcomeLab.textColor = [UIColor whiteColor];
        _welcomeLab.font = [UIFont boldSystemFontOfSize:20];
        _welcomeLab.numberOfLines = 0;
    }
    
    return _welcomeLab;
}

- (UIView *)tipView {
    if (!_tipView) {
        _tipView = [[UIView alloc] init];
        _tipView.backgroundColor = [UIColor colorWithHexString:@"#FEBB34"];
        _tipView.layer.cornerRadius = 11;
        _tipView.clipsToBounds = YES;
    }
    
    return _tipView;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] init];
        _tipLab.text = [[MXAPPLanguage language] languageValue:@"home_tip"];
        _tipLab.numberOfLines = 0;
        _tipLab.textColor = BLACK_COLOR_333333;
    }
    
    return _tipLab;
}

- (UIImageView *)cashImgView {
    if (!_cashImgView) {
        _cashImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_top_cash"]];
    }
    
    return _cashImgView;
}

@end
