//
//  MXHomeLoadProcessView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import "MXHomeLoadProcessView.h"
#import "MXHomeLoadProcessItem.h"

@interface MXHomeLoadProcessView ()

@property (nonatomic, strong) UIImageView *lightImgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) MXHomeLoadProcessItem *leftItem;
@property (nonatomic, strong) MXHomeLoadProcessItem *midItem;
@property (nonatomic, strong) MXHomeLoadProcessItem *rightItem;

@end

@implementation MXHomeLoadProcessView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFD39E"];
        self.layer.cornerRadius = 16;
        self.clipsToBounds = YES;
        
        self.titleLab.text = [[MXAPPLanguage language] languageValue:@"home_process_title0"];
        [self.leftItem setItemTitle:[[MXAPPLanguage language] languageValue:@"home_process_title1"] andImage:@"home_apply"];
        [self.midItem setItemTitle:[[MXAPPLanguage language] languageValue:@"home_process_title2"] andImage:@"home_submit"];
        [self.rightItem setItemTitle:[[MXAPPLanguage language] languageValue:@"home_process_title3"] andImage:@"home_complete"];
        
        [self addSubview:self.lightImgView];
        [self addSubview:self.titleLab];
        [self addSubview:self.whiteView];
        [self.whiteView addSubview:self.leftItem];
        [self.whiteView addSubview:self.midItem];
        [self.whiteView addSubview:self.rightItem];
        
        [self.lightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(self);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 3.5);
        }];
        
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.right.bottom.mas_equalTo(self).offset(-PADDING_UNIT * 3);
        }];
        
        [self.leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.whiteView);
            make.top.mas_equalTo(self.whiteView).offset(PADDING_UNIT * 5);
            make.bottom.mas_equalTo(self.whiteView).offset(-PADDING_UNIT * 5);
        }];
        
        [self.midItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftItem.mas_right);
            make.size.top.mas_equalTo(self.leftItem);
        }];
        
        [self.rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.midItem.mas_right);
            make.right.mas_equalTo(self.whiteView);
            make.size.top.mas_equalTo(self.midItem);
        }];
    }
    return self;
}

- (UIImageView *)lightImgView {
    if (!_lightImgView) {
        _lightImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_mask"]];
    }
    
    return _lightImgView;
}

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.layer.cornerRadius = 12;
        _whiteView.clipsToBounds = YES;
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    
    return _whiteView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    
    return _titleLab;
}

- (MXHomeLoadProcessItem *)leftItem {
    if (!_leftItem) {
        _leftItem = [[MXHomeLoadProcessItem alloc] initWithFrame:CGRectZero imgViewSize:CGSizeMake(44, 44)];
    }
    
    return _leftItem;
}

- (MXHomeLoadProcessItem *)midItem {
    if (!_midItem) {
        _midItem = [[MXHomeLoadProcessItem alloc] initWithFrame:CGRectZero imgViewSize:CGSizeMake(44, 44)];
    }
    
    return _midItem;
}

- (MXHomeLoadProcessItem *)rightItem {
    if (!_rightItem) {
        _rightItem = [[MXHomeLoadProcessItem alloc] initWithFrame:CGRectZero imgViewSize:CGSizeMake(44, 44)];
    }
    
    return _rightItem;
}

@end
