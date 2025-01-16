//
//  MXAPPSignoutPopView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/10.
//

#import "MXAPPSignoutPopView.h"

@interface MXAPPSignoutPopView ()

@property (nonatomic, strong) UILabel *signTitleLab;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *rateLab;

@end

@implementation MXAPPSignoutPopView

- (void)setupUI {
    [super setupUI];
    self.topDistance = PADDING_UNIT * 14;
    [self setPopBackgrooundImage:@"pop_sign_out" popTitle:@"pop_signout"];
    self.confirmTitle = [[MXAPPLanguage language] languageValue:@"pop_confirm_title"];
    self.signTitleLab.text = [[MXAPPLanguage language] languageValue:@"pop_signout_title"];
    self.amountLab.text = [MXGlobal global].productAmountNumber;
    self.rateLab.text = [NSString stringWithFormat:[[MXAPPLanguage language] languageValue:@"pop_signout_rate"], [MXGlobal global].productRate];
    
    [self.contentView addSubview:self.signTitleLab];
    [self.contentView addSubview:self.amountLab];
    [self.contentView addSubview:self.rateLab];
    [self.contentView addSubview:self.confirmBtn];
}

- (void)layoutPopViews {
    [super layoutPopViews];
    
    [self.signTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 14);
        make.right.mas_equalTo(self).offset(-PADDING_UNIT * 14);
        make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT * 20);
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.popBgImgView);
        make.top.mas_equalTo(self.signTitleLab.mas_bottom).offset(PADDING_UNIT);
    }];
    
    [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.amountLab);
        make.top.mas_equalTo(self.amountLab.mas_bottom).offset(PADDING_UNIT);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 10);
        make.top.mas_equalTo(self.rateLab.mas_bottom).offset(PADDING_UNIT * 4);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 5);
    }];
}

- (UILabel *)signTitleLab {
    if (!_signTitleLab) {
        _signTitleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _signTitleLab.text = [[MXAPPLanguage language] languageValue:@"pop_signout_title"];
        _signTitleLab.textColor = BLACK_COLOR_333333;
        _signTitleLab.font = [UIFont systemFontOfSize:18];
        _signTitleLab.numberOfLines = 0;
        _signTitleLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _signTitleLab;
}

- (UILabel *)amountLab {
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _amountLab.text = [MXGlobal global].productAmountNumber;
        _amountLab.textColor = ORANGE_COLOR_FA6603;
        _amountLab.font = [UIFont boldSystemFontOfSize:42];
    }
    
    return _amountLab;
}

- (UILabel *)rateLab {
    if (!_rateLab) {
        _rateLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _rateLab.textColor = BLACK_COLOR_333333;
        _rateLab.font = [UIFont systemFontOfSize:18];
    }
    
    return _rateLab;
}

@end
