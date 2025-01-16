//
//  MXHomeProductTableViewCell.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/7.
//

#import "MXHomeProductTableViewCell.h"
#import "MXAPPHomeModel.h"

@interface MXHomeProductTableViewCell ()

@property (nonatomic, strong) UIView *whiteBgView;
@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UILabel *productNameLab;
@property (nonatomic, strong) UIButton *jumpBtn;
@property (nonatomic, strong) UIView *subContentView;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *rateLab;

@end

@implementation MXHomeProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.whiteBgView];
    [self.whiteBgView addSubview:self.logoImgView];
    [self.whiteBgView addSubview:self.productNameLab];
    [self.whiteBgView addSubview:self.jumpBtn];
    [self.whiteBgView addSubview:self.subContentView];
    [self.subContentView addSubview:self.amountLab];
    [self.subContentView addSubview:self.applyBtn];
    [self.whiteBgView addSubview:self.rateLab];
    
    [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 4);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 4);
        make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT * 1.5);
        make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 1.5);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.whiteBgView).offset(PADDING_UNIT * 3);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.productNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.logoImgView);
        make.left.mas_equalTo(self.logoImgView.mas_right).offset(PADDING_UNIT * 2.5);
    }];
    
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.logoImgView);
        make.right.mas_equalTo(self.whiteBgView).offset(-PADDING_UNIT * 3);
    }];
    
    [self.subContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImgView);
        make.right.mas_equalTo(self.jumpBtn);
        make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(PADDING_UNIT * 2.5);
    }];
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.subContentView.mas_right).offset(-PADDING_UNIT * 3);
        make.size.mas_equalTo(CGSizeMake(85, 30));
        make.top.mas_equalTo(self.subContentView).offset(PADDING_UNIT * 5);
        make.bottom.mas_equalTo(self.subContentView).offset(-PADDING_UNIT * 5);
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.subContentView).offset(PADDING_UNIT * 3);
        make.centerY.mas_equalTo(self.applyBtn);
    }];
    
    [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.subContentView);
        make.top.mas_equalTo(self.subContentView.mas_bottom).offset(PADDING_UNIT * 3);
        make.bottom.mas_equalTo(self.whiteBgView).offset(-PADDING_UNIT * 3.5);
    }];
    
    return self;
}

- (void)reloadProduct:(MXAPPProductModel *)model {
    if (![NSString isEmptyString:model.docked]) {
        [self.logoImgView setImageWithURL:[NSURL URLWithString:model.docked] options:YYWebImageOptionProgressiveBlur];
    }
    
    self.productNameLab.text = model.decoy;
    self.amountLab.attributedText = [NSAttributedString attributeText1:model.josiah text1Color:[UIColor colorWithHexString:@"#999999"] text1Font:[UIFont systemFontOfSize:14] text2:model.willard text2Color:BLACK_COLOR_333333 text1Font:[UIFont systemFontOfSize:16] paramDistance:PADDING_UNIT * 2 paraAlign:NSTextAlignmentLeft];
    [self.applyBtn setTitle:model.gibbs forState:UIControlStateNormal];
    if (![NSString isEmptyString:model.nathan] && ![NSString isEmptyString:model.linguist]) {
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: ", model.nathan] attributes:@{NSForegroundColorAttributeName: BLACK_COLOR_333333, NSFontAttributeName: [UIFont systemFontOfSize:14]}];
        NSAttributedString *tempStr = [[NSAttributedString alloc] initWithString:model.linguist attributes:@{NSForegroundColorAttributeName: BLACK_COLOR_333333, NSFontAttributeName: [UIFont boldSystemFontOfSize:16]}];
        [attributeStr appendAttributedString:tempStr];
        self.rateLab.attributedText = attributeStr;
    }
}

- (UIView *)whiteBgView {
    if (!_whiteBgView) {
        _whiteBgView = [[UIView alloc] initWithFrame:CGRectZero];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
        _whiteBgView.layer.cornerRadius = 16;
        _whiteBgView.clipsToBounds = YES;
    }
    
    return _whiteBgView;
}

- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _logoImgView.layer.cornerRadius = 6;
        _logoImgView.clipsToBounds = YES;
    }
    
    return _logoImgView;
}

- (UILabel *)productNameLab {
    if (!_productNameLab) {
        _productNameLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _productNameLab.textColor = BLACK_COLOR_333333;
        _productNameLab.font = [UIFont boldSystemFontOfSize:16];
    }
    
    return _productNameLab;
}

- (UIButton *)jumpBtn {
    if (!_jumpBtn) {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSAttributedString *attriteStr = [NSAttributedString attachmentImage:@"home_arrow" afterText:YES imagePosition:-1 attributeString:[[MXAPPLanguage language] languageValue:@"home_product_see"] textColor:BLACK_COLOR_333333 textFont:[UIFont systemFontOfSize:12]];
        [_jumpBtn setAttributedTitle:attriteStr forState:UIControlStateNormal];
    }
    
    return _jumpBtn;
}

- (UIView *)subContentView {
    if (!_subContentView) {
        _subContentView = [[UIView alloc] initWithFrame:CGRectZero];
        _subContentView.backgroundColor = [UIColor colorWithHexString:@"#FFF5E4"];
        _subContentView.layer.cornerRadius = 10;
        _subContentView.clipsToBounds = YES;
    }
    
    return _subContentView;
}

- (UILabel *)amountLab {
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _amountLab.numberOfLines = 0;
    }
    
    return _amountLab;
}

- (MXAPPLoadingButton *)applyBtn {
    if (!_applyBtn) {
        _applyBtn = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"home_product_apply"] radius:15];
        _applyBtn.enabled = NO;
    }
    
    return _applyBtn;
}

- (UILabel *)rateLab {
    if (!_rateLab) {
        _rateLab = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    return _rateLab;
}

@end
