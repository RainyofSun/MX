//
//  MXAPPOrderMenuView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import "MXAPPOrderMenuView.h"

@interface MXAPPOrderMenuView ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *midBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MXAPPOrderMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.leftBtn addTarget:self action:@selector(clickMenuItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.midBtn addTarget:self action:@selector(clickMenuItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(clickMenuItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.leftBtn];
        [self addSubview:self.midBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.lineView];
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self);
            make.height.mas_equalTo(50);
        }];
        
        [self.midBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.centerY.mas_equalTo(self.leftBtn);
            make.left.mas_equalTo(self.leftBtn.mas_right);
        }];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.centerY.mas_equalTo(self.midBtn);
            make.left.mas_equalTo(self.midBtn.mas_right);
            make.right.mas_equalTo(self);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.leftBtn);
            make.top.mas_equalTo(self.leftBtn.mas_bottom).offset(-PADDING_UNIT * 2);
            make.size.mas_equalTo(CGSizeMake(25, PADDING_UNIT));
            make.bottom.mas_equalTo(self).offset(-PADDING_UNIT);
        }];
    }
    return self;
}

- (NSInteger)selectedTag {
    if (self.leftBtn.isSelected) {
        return self.leftBtn.tag - 100;
    }
    
    if (self.midBtn.isSelected) {
        return self.midBtn.tag - 100;
    }
    
    if (self.rightBtn.isSelected) {
        return self.rightBtn.tag - 100;
    }
    
    return 0;
}

- (void)clickMenuItem:(UIButton *)sender {
    [self resetMenuItemState];
    sender.selected = !sender.selected;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.centerX = sender.centerX;
    }];
    
    [self.menuDelegate didSelectedMenuItem:(sender.tag - 100)];
}

- (void)resetMenuItemState {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            if (btn.isSelected) {
                btn.selected = NO;
                *stop = YES;
            }
        }
    }];
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:[[MXAPPLanguage language] languageValue:@"order_menu_left"] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:BLACK_COLOR_333333 forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _leftBtn.tag = 100;
    }
    
    return _leftBtn;
}

- (UIButton *)midBtn {
    if (!_midBtn) {
        _midBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_midBtn setTitle:[[MXAPPLanguage language] languageValue:@"order_menu_mid"] forState:UIControlStateNormal];
        [_midBtn setTitleColor:BLACK_COLOR_333333 forState:UIControlStateNormal];
        _midBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _midBtn.tag = 101;
    }
    
    return _midBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:[[MXAPPLanguage language] languageValue:@"order_menu_right"] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:BLACK_COLOR_333333 forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _rightBtn.tag = 102;
    }
    
    return _rightBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = ORANGE_COLOR_FF8D0E;
    }
    
    return _lineView;
}

@end
