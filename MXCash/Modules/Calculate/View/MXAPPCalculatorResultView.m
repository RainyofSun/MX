//
//  MXAPPCalculatorResultView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPCalculatorResultView.h"

@interface MXAPPCalculatorResultView ()

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) MXAPPGradientView *gradientView;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *interestLab;
@property (nonatomic, strong) UILabel *addLab;
@property (nonatomic, strong) UILabel *princialLab;
@property (nonatomic, strong) UILabel *equalLab;
@property (nonatomic, strong) UILabel *resultLab;

@end

@implementation MXAPPCalculatorResultView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dotView];
        [self addSubview:self.titleLab];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.gradientView];
        [self.gradientView addSubview:self.amountLab];
        [self.bgView addSubview:self.interestLab];
        [self.bgView addSubview:self.addLab];
        [self.bgView addSubview:self.princialLab];
        [self.bgView addSubview:self.equalLab];
        [self.bgView addSubview:self.resultLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.left.mas_equalTo(self.dotView.mas_right).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.size.mas_equalTo(8);
        }];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgView).offset(PADDING_UNIT * 3);
            make.right.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 3);
            make.top.mas_equalTo(self.bgView).offset(PADDING_UNIT * 4);
        }];
        
        [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.gradientView);
            make.top.mas_equalTo(self.gradientView).offset(PADDING_UNIT * 3);
            make.bottom.mas_equalTo(self.gradientView).offset(-PADDING_UNIT * 3);
        }];
        
        [self.interestLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.gradientView).offset(PADDING_UNIT * 3.5);
            make.left.mas_equalTo(self.gradientView);
            make.bottom.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 4);
        }];
        
        [self.addLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.interestLab);
            make.left.mas_equalTo(self.interestLab.mas_right).offset(PADDING_UNIT * 2);
            make.size.mas_equalTo(CGSizeMake(15, 34));
        }];
        
        [self.princialLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.mas_equalTo(self.interestLab);
            make.left.mas_equalTo(self.addLab.mas_right).offset(PADDING_UNIT * 2);
        }];
        
        [self.equalLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.centerY.mas_equalTo(self.addLab);
            make.left.mas_equalTo(self.princialLab.mas_right).offset(PADDING_UNIT * 2);
        }];
        
        [self.resultLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.top.mas_equalTo(self.princialLab);
            make.left.mas_equalTo(self.equalLab.mas_right).offset(PADDING_UNIT * 2);
            make.right.mas_equalTo(self.gradientView.mas_right);
        }];
    }
    return self;
}

- (UIView *)dotView {
    if (!_dotView) {
        _dotView = [[UIView alloc] initWithFrame:CGRectZero];
        _dotView.backgroundColor = ORANGE_COLOR_FA6603;
        _dotView.layer.cornerRadius = 4;
        _dotView.clipsToBounds = YES;
    }
    
    return _dotView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.text = [[MXAPPLanguage language] languageValue:@"calcular_result"];
    }
    
    return _titleLab;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 16;
        _bgView.clipsToBounds = YES;
    }
    
    return _bgView;
}

- (MXAPPGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[MXAPPGradientView alloc] initWithFrame:CGRectZero];
        [_gradientView buildGradientWithColors:@[[UIColor colorWithHexString:@"#F7D376"], [UIColor colorWithHexString:@"#F6AB9D"]] gradientStyle:LeftTopToRightBottom];
        _gradientView.layer.cornerRadius = 10;
        _gradientView.clipsToBounds = YES;
    }
    
    return _gradientView;
}

- (UILabel *)amountLab {
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _amountLab.textColor = BLACK_COLOR_333333;
        _amountLab.font = [UIFont boldSystemFontOfSize:26];
    }
    
    return _amountLab;
}

- (UILabel *)interestLab {
    if (!_interestLab) {
        _interestLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _interestLab.numberOfLines = 0;
        _interestLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _interestLab;
}

- (UILabel *)addLab {
    if (!_addLab) {
        _addLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _addLab.textColor = BLACK_COLOR_333333;
        _addLab.font = [UIFont boldSystemFontOfSize:24];
        _addLab.textAlignment = NSTextAlignmentCenter;
        _addLab.text = @"+";
    }
    
    return _addLab;
}

- (UILabel *)princialLab {
    if (!_princialLab) {
        _princialLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _princialLab.numberOfLines = 0;
        _princialLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _princialLab;
}

- (UILabel *)equalLab {
    if (!_equalLab) {
        _equalLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _equalLab.textColor = BLACK_COLOR_333333;
        _equalLab.font = [UIFont boldSystemFontOfSize:24];
        _equalLab.textAlignment = NSTextAlignmentCenter;
        _equalLab.text = @"=";
    }
    
    return _equalLab;
}

- (UILabel *)resultLab {
    if (!_resultLab) {
        _resultLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _resultLab.numberOfLines = 0;
        _resultLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _resultLab;
}

@end
