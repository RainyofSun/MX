//
//  MXAPPUserInfoPopView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/13.
//

#import "MXAPPUserInfoPopView.h"
#import "MXAPPUserIDCardInfo.h"
#import "MXAPPUserTimePopView.h"

@interface MXAPPUserInfoPopItem ()

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation MXAPPUserInfoPopItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.textFiled];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.top.mas_equalTo(self).offset(PADDING_UNIT);
        }];
        
        [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 3);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
            make.height.mas_equalTo(54);
            make.bottom.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)setItemTitle:(NSString *)title value:(NSString *)value {
    self.titleLab.text = title;
    self.textFiled.text = value;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:16];
    }
    
    return _titleLab;
}

- (MXCustomTextFiled *)textFiled {
    if (!_textFiled) {
        _textFiled = [[MXCustomTextFiled alloc] initWithFrame:CGRectZero];
        _textFiled.backgroundColor = [UIColor colorWithHexString:@"#FFF5E4"];
        _textFiled.layer.cornerRadius = 10;
        _textFiled.clipsToBounds = YES;
        _textFiled.borderStyle = UITextBorderStyleNone;
    }
    
    return _textFiled;
}

@end

@interface MXAPPUserInfoPopView ()<UITextFieldDelegate>

@property (nonatomic, strong) MXAPPUserInfoPopItem *nameItem;
@property (nonatomic, strong) MXAPPUserInfoPopItem *idNumberItem;
@property (nonatomic, strong) MXAPPUserInfoPopItem *birthdayItem;
@property (nonatomic, strong) UILabel *tipLab;

@end

@implementation MXAPPUserInfoPopView

- (void)setupUI {
    [super setupUI];
    
    self.topDistance = PADDING_UNIT * 14;
    
    [self setPopBackgrooundImage:@"pop_user_info" popTitle:@"pop_card_certification1"];
    self.confirmTitle = [[MXAPPLanguage language] languageValue:@"pop_confirm_title"];
    
    self.birthdayItem.textFiled.delegate = self;
    
    [self.contentView addSubview:self.nameItem];
    [self.contentView addSubview:self.idNumberItem];
    [self.contentView addSubview:self.birthdayItem];
    [self.contentView addSubview:self.tipLab];
    [self.contentView addSubview:self.confirmBtn];
}

- (void)layoutPopViews {
    [super layoutPopViews];
    
    [self.nameItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT * 14);
    }];
    
    [self.idNumberItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.nameItem.mas_bottom).offset(PADDING_UNIT * 3);
    }];
    
    [self.birthdayItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.idNumberItem.mas_bottom).offset(PADDING_UNIT * 3);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 3);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 3);
        make.top.mas_equalTo(self.birthdayItem.mas_bottom).offset(PADDING_UNIT * 3);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 10);
        make.top.mas_equalTo(self.tipLab.mas_bottom).offset(PADDING_UNIT * 4);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 5);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
    
    if (self.superview != nil) {
        MXAPPUserTimePopView *popView = [[MXAPPUserTimePopView alloc] initWithFrame:self.superview.bounds];
        [self.superview addSubview:popView];
        [popView popAnimation];
        WeakSelf;
        popView.clickConfirmBlock = ^(MXAPPLoadingButton * _Nonnull sender, MXAPPPopBaseView * _Nonnull pView) {
            MXAPPUserTimePopView *pV = (MXAPPUserTimePopView *)pView;
            if (![NSString isEmptyString:pV.time]) {
                [weakSelf.birthdayItem setItemTitle:@"" value:pV.time];
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                pView.alpha = 0;
                weakSelf.alpha = 1;
            } completion:^(BOOL finished) {
                [pView removeFromSuperview];
            }];
        };
        
        popView.clickCloseBlock = ^(MXAPPPopBaseView * _Nonnull pView) {
            [UIView animateWithDuration:0.3 animations:^{
                pView.alpha = 0;
                weakSelf.alpha = 1;
            } completion:^(BOOL finished) {
                [pView removeFromSuperview];
            }];
        };
    }
    return NO;
}

- (NSString *)userName {
    return self.nameItem.textFiled.text;
}

- (NSString *)idNumber {
    return self.idNumberItem.textFiled.text;
}

- (NSString *)birthday {
    return self.birthdayItem.textFiled.text;
}

- (void)reloadUserinfoPop:(MXAPPUserIDCardInfo *)userModel {
    [self.nameItem setItemTitle:[[MXAPPLanguage language] languageValue:@"pop_personal_info_name"] value:userModel.walter];
    [self.idNumberItem setItemTitle:[[MXAPPLanguage language] languageValue:@"pop_personal_info_id"] value:userModel.alumnus];
    [self.birthdayItem setItemTitle:[[MXAPPLanguage language] languageValue:@"pop_personal_info_birthday"] value:userModel.etymology];
}

- (MXAPPUserInfoPopItem *)nameItem {
    if (!_nameItem) {
        _nameItem = [[MXAPPUserInfoPopItem alloc] initWithFrame:CGRectZero];
    }
    
    return _nameItem;
}

- (MXAPPUserInfoPopItem *)idNumberItem {
    if (!_idNumberItem) {
        _idNumberItem = [[MXAPPUserInfoPopItem alloc] initWithFrame:CGRectZero];
    }
    
    return _idNumberItem;
}

- (MXAPPUserInfoPopItem *)birthdayItem {
    if (!_birthdayItem) {
        _birthdayItem = [[MXAPPUserInfoPopItem alloc] initWithFrame:CGRectZero];
    }
    
    return _birthdayItem;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLab.textColor = [UIColor colorWithHexString:@"#F14857"];
        _tipLab.font = [UIFont systemFontOfSize:13];
        _tipLab.numberOfLines = 0;
        _tipLab.text = [[MXAPPLanguage language] languageValue:@"pop_card_certification_tip"];
    }
    
    return _tipLab;
}

@end
