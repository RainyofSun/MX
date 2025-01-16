//
//  MXHomeApplyCashView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import "MXHomeApplyCashView.h"
#import "MXAPPHomeModel.h"
#import "GCMarqueeView.h"
#import "GCMarqueeModel.h"

@interface MXHomeApplyCashView ()

@property (nonatomic, strong) UIView *bView;
@property (nonatomic, strong) UIView *mView;
@property (nonatomic, strong) UIView *tView;
@property (nonatomic, strong) MXAPPGradientView *gradientView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UILabel *termLab;
@property (nonatomic, strong) UILabel *rateLab;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) MXAPPLoadingButton *applyButton;
@property (nonatomic, strong) GCMarqueeView *marqueeView;

@end

@implementation MXHomeApplyCashView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupUI];
    }
    return self;
}

- (void)reloadCashMarquee:(NSArray<NSString *> *)marquee {
    NSMutableArray<GCMarqueeModel *>* items = [NSMutableArray array];
    for (NSString *str in marquee) {
        GCMarqueeModel *model = [[GCMarqueeModel alloc] init];
        model.title = str;
        model.imgName = @"home_laba";
        [items addObject:model];
    }
    
    self.marqueeView.items = items;
}

- (void)reloadRecommendProductModel:(MXAPPProductModel *)productModel {
    [MXGlobal global].productAmountNumber = productModel.willard;
    [MXGlobal global].productRate = productModel.hale;
    
    self.numberLab.text = productModel.willard;
    self.termLab.attributedText = [NSAttributedString attributeText1:productModel.neill text1Color:BLACK_COLOR_333333 text1Font:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium] text2:productModel.eugene text2Color:BLACK_COLOR_666666 text1Font:[UIFont systemFontOfSize:12] paramDistance:2 paraAlign:NSTextAlignmentCenter];
    self.rateLab.attributedText = [NSAttributedString attributeText1:productModel.hale text1Color:BLACK_COLOR_333333 text1Font:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium] text2:productModel.nathan text2Color:BLACK_COLOR_666666 text1Font:[UIFont systemFontOfSize:12] paramDistance:2 paraAlign:NSTextAlignmentCenter];
    [self.applyButton setTitle:productModel.gibbs forState:UIControlStateNormal];
}

- (void)clickLoanApplyButton:(MXAPPLoadingButton *)sender {
    [self.cashDelegate clickLoanApply:sender];
}

- (void)setupUI {
    
    [self.applyButton addTarget:self action:@selector(clickLoanApplyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.bView];
    [self addSubview:self.mView];
    [self addSubview:self.tView];
    [self.tView addSubview:self.gradientView];
    [self.gradientView addSubview:self.marqueeView];
    [self.tView addSubview:self.titleLab];
    [self.tView addSubview:self.numberLab];
    [self.tView addSubview:self.lineView];
    [self.tView addSubview:self.termLab];
    [self.tView addSubview:self.rateLab];
    [self.tView addSubview:self.applyButton];
    
    [self.bView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 16);
        make.right.mas_equalTo(self).offset(-PADDING_UNIT * 16);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    [self.mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self).offset(-PADDING_UNIT * 10);
        make.top.mas_equalTo(self.bView).offset(PADDING_UNIT * 4);
        make.height.mas_equalTo(40);
    }];
    
    [self.tView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
        make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4);
        make.top.mas_equalTo(self.mView).offset(PADDING_UNIT * 4);
        make.bottom.mas_equalTo(self).offset(-PADDING_UNIT);
    }];
    
    [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tView).offset(PADDING_UNIT * 4);
        make.right.mas_equalTo(self.tView).offset(-PADDING_UNIT * 4);
        make.top.mas_equalTo(self.tView).offset(PADDING_UNIT * 5);
        make.height.mas_equalTo(40);
    }];
    
    [self.marqueeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.gradientView);
        make.left.right.mas_equalTo(self.gradientView);
        make.height.mas_equalTo(35);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gradientView.mas_bottom).offset(PADDING_UNIT * 4);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 3);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberLab.mas_bottom).offset(PADDING_UNIT * 7.5);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(1, 21));
    }];
    
    [self.termLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self.lineView);
        make.right.mas_equalTo(self.lineView.mas_left);
    }];
    
    [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.centerY.mas_equalTo(self.lineView);
        make.left.mas_equalTo(self.lineView.mas_right);
    }];
    
    [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self).offset(-PADDING_UNIT * 10);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(PADDING_UNIT * 7);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(self.tView).offset(-PADDING_UNIT * 4);
    }];
}

- (UIView *)bView {
    if (!_bView) {
        _bView = [[UIView alloc] init];
        _bView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        _bView.layer.cornerRadius = 16;
        _bView.clipsToBounds = YES;
    }
    
    return _bView;
}

- (UIView *)mView {
    if (!_mView) {
        _mView = [[UIView alloc] init];
        _mView.backgroundColor = [UIColor colorWithWhite:1 alpha:.4];
        _mView.layer.cornerRadius = 16;
        _mView.clipsToBounds = YES;
    }
    
    return _mView;
}

- (UIView *)tView {
    if (!_tView) {
        _tView = [[UIView alloc] init];
        _tView.backgroundColor = [UIColor whiteColor];
        _tView.layer.cornerRadius = 16;
        _tView.clipsToBounds = YES;
    }
    
    return _tView;
}

- (MXAPPGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[MXAPPGradientView alloc] init];
        [_gradientView buildGradientWithColors:@[[UIColor colorWithHexString:@"#F7D376"], [UIColor colorWithHexString:@"#F6AB9D"]] gradientStyle:TopToBottom];
        _gradientView.layer.cornerRadius = 20;
        _gradientView.clipsToBounds = YES;
    }
    
    return _gradientView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = [[MXAPPLanguage language] languageValue:@"home_apply_title"];
        _titleLab.textColor = BLACK_COLOR_666666;
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    
    return _titleLab;
}

- (UILabel *)numberLab {
    if (!_numberLab) {
        _numberLab = [[UILabel alloc] init];
        _numberLab.textColor = BLACK_COLOR_333333;
        _numberLab.font = [UIFont boldSystemFontOfSize:48];
        _numberLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _numberLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = BLACK_COLOR_666666;
    }
    
    return _lineView;
}

- (UILabel *)termLab {
    if (!_termLab) {
        _termLab = [[UILabel alloc] init];
        _termLab.numberOfLines = 0;
        _termLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _termLab;
}

- (UILabel *)rateLab {
    if (!_rateLab) {
        _rateLab = [[UILabel alloc] init];
        _rateLab.numberOfLines = 0;
        _rateLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _rateLab;
}

- (MXAPPLoadingButton *)applyButton {
    if (!_applyButton) {
        _applyButton = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"home_apply_btn_title"] radius:16];
    }
    
    return _applyButton;
}

- (GCMarqueeView *)marqueeView {
    if (!_marqueeView) {
        _marqueeView = [[GCMarqueeView alloc] initWithFrame:CGRectMake(0, 0, (ScreenWidth - PADDING_UNIT * 14 - 24), 35) type:GCMarqueeDirectionTypeRTL];
    }
    
    return _marqueeView;
}

@end
