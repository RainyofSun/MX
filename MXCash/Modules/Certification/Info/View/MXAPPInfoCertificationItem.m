//
//  MXAPPInfoCertificationItem.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import "MXAPPInfoCertificationItem.h"
#import "MXCustomTextFiled.h"

@interface MXAPPInfoCertificationItem ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) MXCustomTextFiled *textFiled;

@property (nonatomic, copy, readwrite) NSString *paramsKey;
@property (nonatomic, assign, readwrite) ControlType cType;
@property (nonatomic, strong, readwrite) NSArray<MXAPPQuestionChoiseModel *>*choiseModel;

@end

@implementation MXAPPInfoCertificationItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textFiled.delegate = self;
        
        [self addSubview:self.dotView];
        [self addSubview:self.titleLab];
        [self addSubview:self.textFiled];
        
        [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(PADDING_UNIT * 4);
            make.centerY.mas_equalTo(self.titleLab);
            make.size.mas_equalTo(8);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView.mas_right).offset(PADDING_UNIT * 2);
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 3);
        }];
        
        [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 3);
            make.height.mas_equalTo(54);
            make.bottom.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)reloadInfoViewWithModel:(MXAPPQuestionModel *)model {
    self.paramsKey = model.nekita;
    self.cType = model.cType;
    self.choiseModel = model.fish;
    
    self.titleLab.text = model.coined;
    if (![NSString isEmptyString:model.tartan]) {
        self.textFiled.text = model.tartan;
    }
    
    if (![NSString isEmptyString:model.freedom]) {
        self.textFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:model.freedom attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRGBA:0x33333399], NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    }
    
    if (model.shad) {
        self.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    self.textFiled.rightViewMode = model.cType == Choise ? UITextFieldViewModeAlways : UITextFieldViewModeNever;
}

- (void)reloadInfoViewText:(NSString *)value {
    if ([NSString isEmptyString:value]) {
        return;
    }
    self.textFiled.text = value;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.rightViewMode == UITextFieldViewModeNever) {
        return YES;
    }
    
    [self.itemDelegate clickCertificationInfoView:self itemType:self.cType];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.itemDelegate didEndEditing:self inputValue:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
    }
    
    return _titleLab;
}

- (MXCustomTextFiled *)textFiled {
    if (!_textFiled) {
        _textFiled = [[MXCustomTextFiled alloc] initWithFrame:CGRectZero];
        _textFiled.font = [UIFont systemFontOfSize:14];
        _textFiled.textColor = BLACK_COLOR_333333;
        _textFiled.layer.cornerRadius = 10;
        _textFiled.clipsToBounds = YES;
        _textFiled.backgroundColor = [UIColor whiteColor];
        _textFiled.borderStyle = UITextBorderStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"certification_info_arrow"]];
        _textFiled.rightView = imageView;
    }
    
    return _textFiled;
}

@end
