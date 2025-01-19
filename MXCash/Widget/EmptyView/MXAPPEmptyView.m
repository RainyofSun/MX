//
//  MXAPPEmptyView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import "MXAPPEmptyView.h"

@interface MXAPPEmptyView ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *tryBtn;

@end

@implementation MXAPPEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        [self.tryBtn addTarget:self action:@selector(clickTryButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.imgView];
        [self addSubview:self.titleLab];
        [self addSubview:self.tryBtn];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).offset(-PADDING_UNIT * 10);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.imgView.mas_bottom).offset(PADDING_UNIT * 4);
            make.width.mas_equalTo(self).multipliedBy(0.7);
        }];
        
        [self.tryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 4.5);
            make.size.mas_equalTo(CGSizeMake(135, 40));
        }];
    }
    
    return self;
}

- (void)clickTryButton:(UIButton *)sender {
    self.tryBlcok();
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_empty"]];
    }
    
    return _imgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.numberOfLines = 0;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.text = [[MXAPPLanguage language] languageValue:@"order_empty_title"];
    }
    
    return _titleLab;
}

- (UIButton *)tryBtn {
    if (!_tryBtn) {
        _tryBtn = [UIButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"order_empty_try_title"] radius:10];
    }

    return _tryBtn;
}

@end
