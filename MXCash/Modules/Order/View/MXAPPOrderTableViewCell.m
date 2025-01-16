//
//  MXAPPOrderTableViewCell.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import "MXAPPOrderTableViewCell.h"
#import "MXAPPOrderModel.h"

@interface MXAPPLoanInfoItem ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *valueLab;

@end

@implementation MXAPPLoanInfoItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.valueLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.top.mas_equalTo(self).offset(3);
            make.bottom.mas_equalTo(self).offset(-3);
        }];
        
        [self.valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 3);
            make.centerY.mas_equalTo(self.titleLab);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title value:(NSString *)value {
    self.titleLab.text = title;
    self.valueLab.text = value;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = BLACK_COLOR_666666;
    }
    
    return _titleLab;
}

- (UILabel *)valueLab {
    if (!_valueLab) {
        _valueLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _valueLab.textColor = BLACK_COLOR_333333;
        _valueLab.font = [UIFont systemFontOfSize:14];
    }
    
    return _valueLab;
}
@end

@interface MXAPPOrderTableViewCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *productImgView;
@property (nonatomic, strong) UILabel *productLab;
@property (nonatomic, strong) MXAPPLoadingButton *checkBtn;
@property (nonatomic, strong) MXAPPGradientView *gradientView;
@property (nonatomic, strong) UILabel *protocolLab;

@property (nonatomic, copy) NSString *linkUrl;
@end

@implementation MXAPPOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.protocolLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickProtocolButton)]];
        
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.productImgView];
        [self.bgView addSubview:self.productLab];
        [self.bgView addSubview:self.checkBtn];
        [self.bgView addSubview:self.gradientView];
        [self.bgView addSubview:self.protocolLab];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 4);
            make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 4);
            make.top.mas_equalTo(self.contentView).offset(5);
            make.bottom.mas_equalTo(self.contentView).offset(-5);
        }];
        
        [self.productImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgView).offset(PADDING_UNIT * 2.5);
            make.top.mas_equalTo(self.bgView).offset(PADDING_UNIT * 3.5);
            make.size.mas_equalTo(CGSizeMake(32, 32));
        }];
        
        [self.productLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.productImgView);
            make.left.mas_equalTo(self.productImgView.mas_right).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 2.5);
            make.centerY.mas_equalTo(self.productImgView);
            make.size.mas_equalTo(CGSizeMake(105, 38));
        }];
        
        [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.checkBtn.mas_bottom).offset(PADDING_UNIT * 2.5);
            make.left.mas_equalTo(self.bgView).offset(PADDING_UNIT * 4);
            make.right.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 4);
        }];
        
        [self.protocolLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.bgView);
            make.top.mas_equalTo(self.gradientView.mas_bottom).offset(PADDING_UNIT * 3);
            make.bottom.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 3);
        }];
    }
    
    return self;
}

- (void)reloadOrderCell:(MXAPPOrderItemModel *)model {
    self.linkUrl = model.whalers;
    
    if (![NSString isEmptyString:model.docked]) {
        [self.productImgView setImageWithURL:[NSURL URLWithString:model.docked] options:YYWebImageOptionProgressiveBlur];
    }
    self.productLab.text = model.decoy;
    [self buildOrderItem:model.raleigh];
    if (![NSString isEmptyString:model.whalers]) {
        self.protocolLab.attributedText = [[NSAttributedString alloc] initWithString:model.whalers attributes:@{NSForegroundColorAttributeName: ORANGE_COLOR_FA6603, NSFontAttributeName: [UIFont systemFontOfSize:15 weight:UIFontWeightMedium], NSUnderlineColorAttributeName: ORANGE_COLOR_FA6603, NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
    }
}

- (void)buildOrderItem:(NSArray <MXAPPOrderInfo*>*)itemsModel {
    MXAPPLoanInfoItem *temp_item = nil;
    for (int i = 0; i < itemsModel.count; i ++) {
        MXAPPOrderInfo *infoModel = itemsModel[i];
        MXAPPLoanInfoItem *item = [[MXAPPLoanInfoItem alloc] initWithFrame:CGRectZero];
        [item setTitle:infoModel.coined value:infoModel.departed];
        [self.gradientView addSubview:item];
        
        if (temp_item != nil) {
            if (i == itemsModel.count - 1) {
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.width.mas_equalTo(temp_item);
                    make.top.mas_equalTo(temp_item.mas_bottom);
                    make.bottom.mas_equalTo(self.gradientView).offset(-3);
                }];
            } else {
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.width.mas_equalTo(temp_item);
                    make.top.mas_equalTo(temp_item.mas_bottom);
                }];
            }
        } else {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.gradientView);
                make.top.mas_equalTo(self.gradientView).offset(3);
            }];
        }
        
        temp_item = item;
    }
}

- (void)clickProtocolButton {
    if ([NSString isEmptyString:self.linkUrl]) {
        return;
    }
    
    [[MXAPPRouting shared] pageRouter:self.linkUrl backToRoot:YES targetVC:nil];
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

- (UIImageView *)productImgView {
    if (!_productImgView) {
        _productImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _productImgView.layer.cornerRadius = 6;
        _productImgView.clipsToBounds = YES;
    }
    
    return _productImgView;
}

- (UILabel *)productLab {
    if (!_productLab) {
        _productLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _productLab.textColor = BLACK_COLOR_333333;
        _productLab.font = [UIFont boldSystemFontOfSize:16];
    }
    
    return _productLab;
}

- (MXAPPLoadingButton *)checkBtn {
    if (!_checkBtn) {
        _checkBtn = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"order_check"] radius:12];
        _checkBtn.enabled = NO;
    }
    
    return _checkBtn;
}

- (MXAPPGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[MXAPPGradientView alloc] initWithFrame:CGRectZero];
        [_gradientView buildGradientWithColors:@[[UIColor colorWithHexString:@"#FFF4D8"], [UIColor colorWithHexString:@"#FFE0DA"]] gradientStyle:LeftToRight];
        _gradientView.layer.cornerRadius = 14;
        _gradientView.clipsToBounds = YES;
    }
    
    return _gradientView;
}

- (UILabel *)protocolLab {
    if (!_protocolLab) {
        _protocolLab = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    return _protocolLab;
}

@end
