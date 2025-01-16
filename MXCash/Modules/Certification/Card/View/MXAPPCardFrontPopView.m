//
//  MXAPPCardFrontPopView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import "MXAPPCardFrontPopView.h"
#import "MXHomeLoadProcessItem.h"

@interface MXAPPCardFrontPopView ()

@property (nonatomic, strong) UIImageView *typeImgView;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UILabel *errorLab;
@property (nonatomic, strong) MXHomeLoadProcessItem *errorLeftItem;
@property (nonatomic, strong) MXHomeLoadProcessItem *errorMidItem;
@property (nonatomic, strong) MXHomeLoadProcessItem *errorRightItem;

@end

@implementation MXAPPCardFrontPopView

- (void)setupUI {
    [super setupUI];
    self.topDistance = PADDING_UNIT * 14;
    [self setPopBackgrooundImage:@"pop_card_bg" popTitle:@"pop_card_certification"];
    self.confirmTitle = [[MXAPPLanguage language] languageValue:@"pop_confirm_title"];
    
    [self.errorLeftItem setItemTitle:[[MXAPPLanguage language] languageValue:@"pop_card_certification_error1"] andImage:@"certification_card_left_error"];
    [self.errorMidItem setItemTitle:[[MXAPPLanguage language] languageValue:@"pop_card_certification_error2"] andImage:@"certification_card_mid_error"];
    [self.errorRightItem setItemTitle:[[MXAPPLanguage language] languageValue:@"pop_card_certification_error3"] andImage:@"certification_card_right_error"];
    
    [self.contentView addSubview:self.typeImgView];
    [self.contentView addSubview:self.tipLab];
    [self.contentView addSubview:self.errorLab];
    [self.contentView addSubview:self.errorLeftItem];
    [self.contentView addSubview:self.errorMidItem];
    [self.contentView addSubview:self.errorRightItem];
    [self.contentView addSubview:self.confirmBtn];
}

- (void)layoutPopViews {
    [super layoutPopViews];
    [self.typeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT * 25);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.typeImgView);
        make.top.mas_equalTo(self.typeImgView.mas_bottom).offset(PADDING_UNIT * 3);
        make.width.mas_equalTo(ScreenWidth - 120);
    }];
    
    [self.errorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tipLab);
        make.top.mas_equalTo(self.tipLab.mas_bottom).offset(PADDING_UNIT * 3);
    }];
    
    [self.errorLeftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 2.5);
        make.top.mas_equalTo(self.errorLab.mas_bottom).offset(PADDING_UNIT * 2.5);
    }];
    
    [self.errorMidItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.errorLeftItem.mas_right).offset(PADDING_UNIT * 4);
        make.width.top.mas_equalTo(self.errorLeftItem);
    }];
    
    [self.errorRightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.errorMidItem.mas_right).offset(PADDING_UNIT * 4);
        make.width.top.mas_equalTo(self.errorMidItem);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 2.5);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 10);
        make.top.mas_equalTo(self.errorLeftItem.mas_bottom).offset(PADDING_UNIT * 4);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 5);
    }];
}

- (UIImageView *)typeImgView {
    if (!_typeImgView) {
        _typeImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_certification_card"]];
    }
    
    return _typeImgView;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLab.numberOfLines = 0;
        _tipLab.textColor = [UIColor colorWithHexString:@"#F14857"];
        _tipLab.text = [[MXAPPLanguage language] languageValue:@"pop_card_certification_front_tip"];
        _tipLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _tipLab;
}

- (UILabel *)errorLab {
    if (!_errorLab) {
        _errorLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _errorLab.textColor = [UIColor colorWithHexString:@"#FE6337"];
        _errorLab.font = [UIFont systemFontOfSize:16];
        _errorLab.text = [[MXAPPLanguage language] languageValue:@"pop_card_certification_error0"];
    }
    
    return _errorLab;
}

- (MXHomeLoadProcessItem *)errorLeftItem {
    if (!_errorLeftItem) {
        _errorLeftItem = [[MXHomeLoadProcessItem alloc] initWithFrame:CGRectZero imgViewSize:CGSizeMake(87, 53)];
        [_errorLeftItem setTitleColor:[UIColor colorWithHexString:@"#EC6634"]];
    }
    
    return _errorLeftItem;
}

- (MXHomeLoadProcessItem *)errorMidItem {
    if (!_errorMidItem) {
        _errorMidItem = [[MXHomeLoadProcessItem alloc] initWithFrame:CGRectZero imgViewSize:CGSizeMake(87, 53)];
        [_errorMidItem setTitleColor:[UIColor colorWithHexString:@"#EC6634"]];
    }
    
    return _errorMidItem;
}

- (MXHomeLoadProcessItem *)errorRightItem {
    if (!_errorRightItem) {
        _errorRightItem = [[MXHomeLoadProcessItem alloc] initWithFrame:CGRectZero imgViewSize:CGSizeMake(87, 53)];
        [_errorRightItem setTitleColor:[UIColor colorWithHexString:@"#EC6634"]];
    }
    
    return _errorRightItem;
}

@end
