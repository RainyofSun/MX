//
//  MXHomeApplyBigCardView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import "MXHomeApplyBigCardView.h"
#import "MXHomeApplyFuncButton.h"
#import "MXHomeLoadProcessView.h"

@interface MXHomeApplyBigCardView ()

@property (nonatomic, strong) UILabel *titleLab1;
@property (nonatomic, strong) MXHomeApplyFuncButton *planBtn;
@property (nonatomic, strong) MXHomeApplyFuncButton *feedbackBtn;
@property (nonatomic, strong) UILabel *titleLab2;
@property (nonatomic, strong) MXHomeLoadProcessView *processView;

@end

@implementation MXHomeApplyBigCardView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.titleLab1.text = [[MXAPPLanguage language] languageValue:@"home_big_card_title1"];
        self.titleLab2.text = [[MXAPPLanguage language] languageValue:@"home_big_card_title2"];
        
        [self.planBtn setTitle:[[MXAPPLanguage language] languageValue:@"home_plan_btn"] titleColor:[UIColor colorWithHexString:@"#945A00"] andImage:@"home_loan_plan" andColors:@[[UIColor colorWithHexString:@"#FFCF4C"], [UIColor colorWithHexString:@"#FFB869"]]];
        [self.feedbackBtn setTitle:[[MXAPPLanguage language] languageValue:@"home_feedback_btn"] titleColor:[UIColor colorWithHexString:@"#FFFFFF"] andImage:@"home_feedback" andColors:@[[UIColor colorWithHexString:@"#FF9144"], [UIColor colorWithHexString:@"#FA6400"]]];
        
        [self.planBtn addTarget:self action:@selector(clickLoanApplyPlanButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.feedbackBtn addTarget:self action:@selector(clickFeedbackButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.titleLab1];
        [self addSubview:self.planBtn];
        [self addSubview:self.feedbackBtn];
        [self addSubview:self.titleLab2];
        [self addSubview:self.processView];
        
        [self.titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.top.mas_equalTo(self).offset(PADDING_UNIT);
        }];
        
        [self.planBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.top.mas_equalTo(self.titleLab1.mas_bottom).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.feedbackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.planBtn.mas_right).offset(PADDING_UNIT * 4);
            make.width.top.mas_equalTo(self.planBtn);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4);
        }];
        
        [self.titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab1);
            make.top.mas_equalTo(self.planBtn.mas_bottom).offset(PADDING_UNIT * 3.5);
        }];
        
        [self.processView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.planBtn);
            make.right.mas_equalTo(self.feedbackBtn);
            make.top.mas_equalTo(self.titleLab2.mas_bottom).offset(PADDING_UNIT * 2.5);
            make.bottom.mas_equalTo(self).offset(-PADDING_UNIT * 2);
        }];
    }
    return self;
}

- (void)clickLoanApplyPlanButton:(MXHomeApplyFuncButton *)sender {
    [self.bigCardDelegate clickApplyPlan];
}

- (void)clickFeedbackButton:(MXHomeApplyFuncButton *)sender {
    [self.bigCardDelegate clickFeedBack];
}

- (UILabel *)titleLab1 {
    if (!_titleLab1) {
        _titleLab1 = [[UILabel alloc] init];
        _titleLab1.textColor = BLACK_COLOR_333333;
        _titleLab1.font = [UIFont systemFontOfSize:16];
    }
    
    return _titleLab1;
}

- (MXHomeApplyFuncButton *)planBtn {
    if (!_planBtn) {
        _planBtn = [[MXHomeApplyFuncButton alloc] init];
    }
    
    return _planBtn;
}

- (MXHomeApplyFuncButton *)feedbackBtn {
    if (!_feedbackBtn) {
        _feedbackBtn = [[MXHomeApplyFuncButton alloc] init];
    }
    
    return _feedbackBtn;
}

- (UILabel *)titleLab2 {
    if (!_titleLab2) {
        _titleLab2 = [[UILabel alloc] init];
        _titleLab2.textColor = BLACK_COLOR_333333;
        _titleLab2.font = [UIFont systemFontOfSize:16];
    }
    
    return _titleLab2;
}

- (MXHomeLoadProcessView *)processView {
    if (!_processView) {
        _processView = [[MXHomeLoadProcessView alloc] init];
    }
    
    return _processView;
}

@end
