//
//  MXAPPProductInfoView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPProductInfoView.h"
#import "MXAPPHomeModel.h"

@interface MXAPPProductInfoView ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *termLab;
@property (nonatomic, strong) UILabel *rateLab;

@end

@implementation MXAPPProductInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.image = [UIImage imageNamed:@"product_subtract"];
        [self addSubview:self.titleLab];
        [self addSubview:self.amountLab];
        [self addSubview:self.termLab];
        [self addSubview:self.rateLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 5);
        }];
        
        [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 2);
        }];
        
        [self.termLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.amountLab);
            make.top.mas_equalTo(self.amountLab.mas_bottom).offset(PADDING_UNIT * 3);
        }];
        
        [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 3);
            make.centerY.mas_equalTo(self.termLab);
        }];
    }
    return self;
}

- (void)reloadProductInfo:(MXAPPProductModel *)model {
    self.amountLab.text = model.valuable;
    if (model.arguably.quonehtacut != nil && ![model.arguably.quonehtacut isEqual:[NSNull null]]) {
        self.termLab.text = [NSString stringWithFormat:@"%@: %@", model.arguably.quonehtacut.coined, model.arguably.quonehtacut.originated];
    }

    if (model.arguably.lists != nil && ![model.arguably.lists isEqual:[NSNull null]]) {
        self.rateLab.text = [NSString stringWithFormat:@"%@: %@", model.arguably.lists.coined, model.arguably.lists.originated];
    }
    
    self.titleLab.text = model.returning;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.text = [[MXAPPLanguage language] languageValue:@"certification_max_amount"];
    }
    
    return _titleLab;
}

- (UILabel *)amountLab {
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _amountLab.textColor = BLACK_COLOR_333333;
        _amountLab.font = [UIFont boldSystemFontOfSize:32];
    }
    
    return _amountLab;
}

- (UILabel *)termLab {
    if (!_termLab) {
        _termLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _termLab.textColor = BLACK_COLOR_333333;
        _termLab.font = [UIFont systemFontOfSize:14];
    }
    
    return _termLab;
}

- (UILabel *)rateLab {
    if (!_rateLab) {
        _rateLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _rateLab.textColor = BLACK_COLOR_333333;
        _rateLab.font = [UIFont systemFontOfSize:14];
    }
    
    return _rateLab;
}

@end
