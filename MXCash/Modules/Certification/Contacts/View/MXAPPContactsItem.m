//
//  MXAPPContactsItem.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/15.
//

#import "MXAPPContactsItem.h"
#import "MXCustomTextFiled.h"
#import "MXAPPContactsModel.h"

@interface MXAPPContactsItem ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *topTitleLab;
@property (nonatomic, strong) UILabel *titleLab1;
@property (nonatomic, strong) MXCustomTextFiled *textFiled1;
@property (nonatomic, strong) UILabel *titleLab2;
@property (nonatomic, strong) MXCustomTextFiled *textFiled2;

@property (nonatomic, strong, readwrite) NSArray<MXAPPQuestionChoiseModel *>* relationModels;

@end

@implementation MXAPPContactsItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textFiled1.delegate = self;
        self.textFiled2.delegate = self;
        
        [self addSubview:self.dotView];
        [self addSubview:self.topTitleLab];
        [self addSubview:self.titleLab1];
        [self addSubview:self.textFiled1];
        [self addSubview:self.titleLab2];
        [self addSubview:self.textFiled2];
        
        [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(PADDING_UNIT * 4);
            make.centerY.mas_equalTo(self.topTitleLab);
            make.size.mas_equalTo(8);
        }];
        
        [self.topTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView.mas_right).offset(PADDING_UNIT * 2);
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 3);
        }];
        
        [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView);
            make.top.mas_equalTo(self.topTitleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.textFiled1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView);
            make.top.mas_equalTo(self.titleLab1.mas_bottom).offset(PADDING_UNIT * 2.5);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 3);
            make.height.mas_equalTo(54);
        }];
        
        [self.titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView);
            make.top.mas_equalTo(self.textFiled1.mas_bottom).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.textFiled2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView);
            make.top.mas_equalTo(self.titleLab2.mas_bottom).offset(PADDING_UNIT * 2.5);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 3);
            make.height.mas_equalTo(54);
            make.bottom.mas_equalTo(self);
        }];
    }
    
    return self;
}

- (void)reloadContactsItemWithModel:(MXAPPContactsPeopleModel *)model {
    self.relationModels = model.fish;
    self.topTitleLab.text = model.coined;
    self.titleLab1.text = model.programs;
    self.titleLab2.text = model.ncaa;
    
    if (![NSString isEmptyString:model.championships]) {
        self.textFiled1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:model.championships attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRGBA:0x33333399], NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    }
    
    if (![NSString isEmptyString:model.uconn]) {
        self.textFiled2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:model.uconn attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRGBA:0x33333399], NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    }
    
    if (![NSString isEmptyString:model.feat]) {
        [model.fish enumerateObjectsUsingBlock:^(MXAPPQuestionChoiseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.sites == model.feat.integerValue) {
                self.textFiled1.text = obj.robin;
                *stop = YES;
            }
        }];
    }
    
    if (![NSString isEmptyString:model.robin] && ![NSString isEmptyString:model.repeated]) {
        self.textFiled2.text = [NSString stringWithFormat:@"%@-%@", model.robin, model.repeated];
    }
}

- (void)reloadInputValue:(NSString *)value relationShip:(NSString *)relation {
    if (![NSString isEmptyString:value]) {
        self.textFiled2.text = value;
    }
    
    if (![NSString isEmptyString:relation]) {
        self.textFiled1.text = relation;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {    
    [self.contactDelegate clickContactsItem:self isRelationShip:(textField == self.textFiled1)];
    return NO;
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

- (UILabel *)topTitleLab {
    if (!_topTitleLab) {
        _topTitleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _topTitleLab.font = [UIFont systemFontOfSize:16];
        _topTitleLab.textColor = BLACK_COLOR_333333;
    }
    
    return _topTitleLab;
}

- (UILabel *)titleLab1 {
    if (!_titleLab1) {
        _titleLab1 = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab1.font = [UIFont systemFontOfSize:16];
        _titleLab1.textColor = BLACK_COLOR_333333;
    }
    
    return _titleLab1;
}

- (MXCustomTextFiled *)textFiled1 {
    if (!_textFiled1) {
        _textFiled1 = [[MXCustomTextFiled alloc] initWithFrame:CGRectZero];
        _textFiled1.font = [UIFont systemFontOfSize:14];
        _textFiled1.textColor = BLACK_COLOR_333333;
        _textFiled1.layer.cornerRadius = 10;
        _textFiled1.clipsToBounds = YES;
        _textFiled1.backgroundColor = [UIColor whiteColor];
        _textFiled1.borderStyle = UITextBorderStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"certification_info_arrow"]];
        _textFiled1.rightView = imageView;
        _textFiled1.rightViewMode = UITextFieldViewModeAlways;
    }
    
    return _textFiled1;
}

- (UILabel *)titleLab2 {
    if (!_titleLab2) {
        _titleLab2 = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab2.font = [UIFont systemFontOfSize:16];
        _titleLab2.textColor = BLACK_COLOR_333333;
    }
    
    return _titleLab2;
}

- (MXCustomTextFiled *)textFiled2 {
    if (!_textFiled2) {
        _textFiled2 = [[MXCustomTextFiled alloc] initWithFrame:CGRectZero];
        _textFiled2.font = [UIFont systemFontOfSize:14];
        _textFiled2.textColor = BLACK_COLOR_333333;
        _textFiled2.layer.cornerRadius = 10;
        _textFiled2.clipsToBounds = YES;
        _textFiled2.backgroundColor = [UIColor whiteColor];
        _textFiled2.borderStyle = UITextBorderStyleNone;
    }
    
    return _textFiled2;
}

@end
