//
//  MXAPPCalculateViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import "MXAPPCalculateViewController.h"
#import "MXAPPCalculatorItem.h"
#import "MXAPPCalculatorResultView.h"
#import "MXAPPCalculatorPlanView.h"

@interface MXAPPCalculateViewController ()

@property (nonatomic, strong) MXAPPGradientView *gView;
@property (nonatomic, strong) UIScrollView *vScrollView;
@property (nonatomic, strong) MXAPPCalculatorItem *amountItem;
@property (nonatomic, strong) MXAPPCalculatorItem *rateItem;
@property (nonatomic, strong) MXAPPCalculatorItem *termItem;
@property (nonatomic, strong) MXAPPLoadingButton *calculatorBtn;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) MXAPPCalculatorResultView *resultView;
@property (nonatomic, strong) MXAPPCalculatorPlanView *planView;

@end

@implementation MXAPPCalculateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self layoutCalculatorViews];
}

- (void)clickCalcutarButton:(MXAPPLoadingButton *)sender {
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"v4/index/emi" params:@{@"numerous":self.amountItem.value,@"rendered":self.rateItem.value,@"gave":self.termItem.loanTerm, @"customers":self.termItem.value} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        NSLog(@"ssss");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

- (void)clickResetButton:(UIButton *)sender {
    [self.amountItem clearText];
    [self.rateItem clearText];
    [self.termItem clearText];
    [self.resultView removeFromSuperview];
    [self.planView removeFromSuperview];
    
    [self.resetBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.left.mas_equalTo(self.calculatorBtn);
        make.top.mas_equalTo(self.calculatorBtn.mas_bottom).offset(PADDING_UNIT);
        make.bottom.mas_equalTo(self.vScrollView).offset(-PADDING_UNIT * 4);
    }];
}

- (void)setupUI {
    self.title = [[MXAPPLanguage language] languageValue:@"calcular_nav_title"];
    [self hideBackgroundGradientView];
    
    [self.amountItem setItemTitle:@"calcular_title1" placeholder:@"calcular_placeholder1"];
    [self.rateItem setItemTitle:@"calcular_title2" placeholder:@"calcular_placeholder2"];
    [self.termItem setItemTitle:@"calcular_title3" placeholder:@"calcular_placeholder3"];
    [self.amountItem setInputTypeLimit:NO];
    [self.rateItem setInputTypeLimit:YES];
    [self.termItem setInputTypeLimit:NO];
    [self.termItem setLoanRepaymentType];
    
    [self.calculatorBtn addTarget:self action:@selector(clickCalcutarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.resetBtn addTarget:self action:@selector(clickResetButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.gView];
    [self.view addSubview:self.vScrollView];
    [self.vScrollView addSubview:self.amountItem];
    [self.vScrollView addSubview:self.rateItem];
    [self.vScrollView addSubview:self.termItem];
    [self.vScrollView addSubview:self.calculatorBtn];
    [self.vScrollView addSubview:self.resetBtn];
    [self.vScrollView addSubview:self.resultView];
    
}

- (void)layoutCalculatorViews {
    [self.gView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(0.5);
    }];
    
    [self.vScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight);
        make.bottom.mas_equalTo(self.view).offset(-[UIDevice currentDevice].app_safeDistanceBottom);
    }];
    
    [self.amountItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.vScrollView).offset(PADDING_UNIT);
        make.width.left.mas_equalTo(self.vScrollView);
    }];
    
    [self.rateItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.amountItem);
        make.top.mas_equalTo(self.amountItem.mas_bottom);
    }];
    
    [self.termItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.rateItem);
        make.top.mas_equalTo(self.rateItem.mas_bottom);
    }];
    
    [self.calculatorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vScrollView).offset(PADDING_UNIT * 13);
        make.right.mas_equalTo(self.termItem).offset(-PADDING_UNIT * 13);
        make.top.mas_equalTo(self.termItem.mas_bottom).offset(PADDING_UNIT * 5);
        make.height.mas_equalTo(46);
    }];
    
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.mas_equalTo(self.calculatorBtn);
        make.top.mas_equalTo(self.calculatorBtn.mas_bottom).offset(PADDING_UNIT);
    }];
    
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.vScrollView);
        make.top.mas_equalTo(self.resetBtn.mas_bottom).offset(PADDING_UNIT * 1.5);
        make.bottom.mas_equalTo(self.vScrollView).offset(-PADDING_UNIT * 4);
    }];
}

- (MXAPPGradientView *)gView {
    if (!_gView) {
        _gView = [[MXAPPGradientView alloc] initWithFrame:CGRectZero];
        [_gView buildGradientWithColors:@[[UIColor colorWithHexString:@"#FF980A"], [UIColor colorWithRGB:0xFFF5E4 alpha:0]] gradientStyle:TopToBottom];
    }
    
    return _gView;
}

- (UIScrollView *)vScrollView {
    if (!_vScrollView) {
        _vScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _vScrollView.backgroundColor = [UIColor clearColor];
    }
    
    return _vScrollView;
}

- (MXAPPCalculatorItem *)amountItem {
    if (!_amountItem) {
        _amountItem = [[MXAPPCalculatorItem alloc] initWithFrame:CGRectZero];
    }
    
    return _amountItem;
}

- (MXAPPCalculatorItem *)termItem {
    if (!_termItem) {
        _termItem = [[MXAPPCalculatorItem alloc] initWithFrame:CGRectZero];
    }
    
    return _termItem;
}

- (MXAPPCalculatorItem *)rateItem {
    if (!_rateItem) {
        _rateItem = [[MXAPPCalculatorItem alloc] initWithFrame:CGRectZero];
    }
    
    return _rateItem;
}

- (MXAPPLoadingButton *)calculatorBtn {
    if (!_calculatorBtn) {
        _calculatorBtn = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"calcular_btn_title"] radius:16];
    }
    
    return _calculatorBtn;
}

- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setTitle:[[MXAPPLanguage language] languageValue:@"calcular_reset_title"] forState:UIControlStateNormal];
        [_resetBtn setTitleColor:BLACK_COLOR_333333 forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return _resetBtn;
}

- (MXAPPCalculatorResultView *)resultView {
    if (!_resultView) {
        _resultView = [[MXAPPCalculatorResultView alloc] initWithFrame:CGRectZero];
    }
    
    return _resultView;
}

@end
