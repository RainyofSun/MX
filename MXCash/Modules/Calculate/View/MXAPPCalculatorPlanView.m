//
//  MXAPPCalculatorPlanView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPCalculatorPlanView.h"

@interface MXAPPCalculatorPlanView ()

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) MXAPPGradientView *gradientView;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *timeLab;

@end

@implementation MXAPPCalculatorPlanView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dotView];
        [self addSubview:self.titleLab];
        [self addSubview:self.gradientView];
        [self.gradientView addSubview:self.amountLab];
        [self.gradientView addSubview:self.timeLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.left.mas_equalTo(self.dotView.mas_right).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.size.mas_equalTo(8);
        }];
        
        [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4);
            make.top.mas_equalTo(self.titleLab).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.gradientView).offset(PADDING_UNIT * 4);
            make.bottom.mas_equalTo(self.gradientView).offset(-PADDING_UNIT * 5);
        }];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.gradientView).offset(-PADDING_UNIT * 4);
            make.centerY.mas_equalTo(self.amountLab);
        }];
    }
    return self;
}

- (void)setPlanAmount:(NSString *)amount repaymentTime:(NSString *)time totalCount:(NSInteger)count {
    self.amountLab.attributedText = [NSAttributedString attributeText1:[[MXAPPLanguage language] languageValue:@"calcular_plan_amount"] text1Color:[UIColor colorWithHexString:@"#999999"] text1Font:[UIFont systemFontOfSize:14] text2:amount text2Color:BLACK_COLOR_333333 text1Font:[UIFont boldSystemFontOfSize:24] paramDistance:PADDING_UNIT paraAlign:NSTextAlignmentCenter];
    self.timeLab.attributedText = [NSAttributedString attributeText1:time text1Color:ORANGE_COLOR_FA6603 text1Font:[UIFont systemFontOfSize:16] text2:[NSString stringWithFormat:[[MXAPPLanguage language] languageValue:@"calcular_plan_schedule"], count] text2Color:BLACK_COLOR_666666 text1Font:[UIFont systemFontOfSize:16] paramDistance:PADDING_UNIT paraAlign:NSTextAlignmentCenter];
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
        _titleLab.text = [[MXAPPLanguage language] languageValue:@"calcular_plan"];
    }
    
    return _titleLab;
}

- (MXAPPGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[MXAPPGradientView alloc] initWithFrame:CGRectZero];
        [_gradientView buildGradientWithColors:@[[UIColor colorWithHexString:@"#FFEDD8"], [UIColor colorWithHexString:@"#FFFFFF"]] gradientStyle:LeftToRight];
        _gradientView.layer.cornerRadius = 16;
        _gradientView.clipsToBounds = YES;
    }
    
    return _gradientView;
}

- (UILabel *)amountLab {
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _amountLab.numberOfLines = 0;
        _amountLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _amountLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLab.numberOfLines = 0;
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _timeLab;
}

@end
