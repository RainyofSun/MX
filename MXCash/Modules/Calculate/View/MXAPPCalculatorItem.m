//
//  MXAPPCalculatorItem.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPCalculatorItem.h"
#import "MXCustomTextFiled.h"

@interface MXAPPCalculatorItem ()

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) MXCustomTextFiled *inputTextView;

@end

@implementation MXAPPCalculatorItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dotView];
        [self addSubview:self.titleLab];
        [self addSubview:self.inputTextView];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.left.mas_equalTo(self.dotView.mas_right).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.size.mas_equalTo(8);
        }];
        
        [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
            make.height.mas_equalTo(54);
            make.bottom.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)setItemTitle:(NSString *)title placeholder:(NSString *)placeHolder {
    self.titleLab.text = [[MXAPPLanguage language] languageValue:title];
    _inputTextView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[[MXAPPLanguage language] languageValue:placeHolder] attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRGBA:0x33333399], NSFontAttributeName: [UIFont systemFontOfSize:14]}];
}

- (void)setInputTypeLimit:(BOOL)canInputFloat {
    self.inputTextView.keyboardType = canInputFloat ? UIKeyboardTypeDecimalPad : UIKeyboardTypeNumberPad;
}

- (void)setLoanRepaymentType {
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[[[MXAPPLanguage language] languageValue:@"calcular_day"],[[MXAPPLanguage language] languageValue:@"calcular_month"]]];
    [control setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
    [control setTitleTextAttributes:@{NSForegroundColorAttributeName: BLACK_COLOR_666666, NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    control.selectedSegmentIndex = 0;
    control.selectedSegmentTintColor = ORANGE_COLOR_FF8D0E;
    self.inputTextView.rightView = control;
    self.inputTextView.rightViewMode = UITextFieldViewModeAlways;
}

- (void)clearText {
    self.inputTextView.text = @"";
    if (self.inputTextView.rightView != nil) {
        UISegmentedControl *control = (UISegmentedControl *)self.inputTextView.rightView;
        control.selectedSegmentIndex = 0;
    }
}

- (NSString *)value {
    return self.inputTextView.text;
}

- (NSString *)loanTerm {
    if (self.inputTextView.rightView != nil) {
        UISegmentedControl *control = (UISegmentedControl *)self.inputTextView.rightView;
        return [NSString stringWithFormat:@"%ld", control.selectedSegmentIndex];
    }
    
    return @"1";
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
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:16];
    }
    
    return _titleLab;
}

- (MXCustomTextFiled *)inputTextView {
    if (!_inputTextView) {
        _inputTextView = [[MXCustomTextFiled alloc] initWithFrame:CGRectZero];
        _inputTextView.borderStyle = UITextBorderStyleNone;
        _inputTextView.layer.cornerRadius = 10;
        _inputTextView.clipsToBounds = YES;
        _inputTextView.backgroundColor = [UIColor whiteColor];
    }
    
    return _inputTextView;
}

@end
