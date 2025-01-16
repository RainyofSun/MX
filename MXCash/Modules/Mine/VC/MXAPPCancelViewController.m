//
//  MXAPPCancelViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/10.
//

#import "MXAPPCancelViewController.h"
#import "MXAPPCancelItem.h"

@interface MXAPPCancelViewController ()

@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) MXAPPCancelItem *firstItem;
@property (nonatomic, strong) MXAPPCancelItem *secondItem;
@property (nonatomic, strong) MXAPPCancelItem *thirtItem;
@property (nonatomic, strong) UILabel *warningLab;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UILabel *protocolLab;
@property (nonatomic, strong) MXAPPLoadingButton *cancelBtn;

@end

@implementation MXAPPCancelViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self setupUI];
}

- (void)setupUI {
    self.title = [[MXAPPLanguage language] languageValue:@"cancel_nav_title"];
    
    self.titleLab.attributedText = [NSAttributedString attributeText1:[[MXAPPLanguage language] languageValue:@"cancel_title1"] text1Color:BLACK_COLOR_333333 text1Font:[UIFont boldSystemFontOfSize:18] text2:[[MXAPPLanguage language] languageValue:@"cancel_title2"] text2Color:BLACK_COLOR_333333 text1Font:[UIFont boldSystemFontOfSize:18] paramDistance:PADDING_UNIT * 0.5 paraAlign:NSTextAlignmentLeft];
    [self.firstItem setContentText:[[MXAPPLanguage language] languageValue:@"cancel_title3"]];
    [self.secondItem setContentText:[[MXAPPLanguage language] languageValue:@"cancel_title4"]];
    [self.thirtItem setContentText:[[MXAPPLanguage language] languageValue:@"cancel_title5"]];
    self.warningLab.attributedText = [NSAttributedString attachmentImage:@"cancel_warning" afterText:NO imagePosition:-5 attributeString:[[MXAPPLanguage language] languageValue:@"cancel_title6"] textColor:[UIColor colorWithHexString:@"#F2442D"] textFont:[UIFont systemFontOfSize:16]];
    
    [self.agreeBtn addTarget:self action:@selector(clickAgreeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.topImgView];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.firstItem];
    [self.bgView addSubview:self.secondItem];
    [self.bgView addSubview:self.thirtItem];
    [self.bgView addSubview:self.warningLab];
    [self.view addSubview:self.agreeBtn];
    [self.view addSubview:self.protocolLab];
    [self.view addSubview:self.cancelBtn];
    
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight + PADDING_UNIT * 5);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 4);
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 4);
        make.top.mas_equalTo(self.topImgView.mas_bottom).offset(PADDING_UNIT * 4.5);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.bgView).offset(PADDING_UNIT * 4);
        make.right.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 4);
    }];
    
    [self.firstItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
    }];
    
    [self.secondItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.firstItem);
        make.top.mas_equalTo(self.firstItem.mas_bottom).offset(PADDING_UNIT * 5);
    }];
    
    [self.thirtItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.secondItem);
        make.top.mas_equalTo(self.secondItem.mas_bottom).offset(PADDING_UNIT * 5);
    }];
    
    [self.warningLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(PADDING_UNIT * 4);
        make.top.mas_equalTo(self.thirtItem.mas_bottom).offset(PADDING_UNIT * 4);
        make.bottom.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 7);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 10);
        make.bottom.mas_equalTo(-[UIDevice currentDevice].app_safeDistanceBottom - PADDING_UNIT * 2);
        make.height.mas_equalTo(46);
    }];
    
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cancelBtn).offset(PADDING_UNIT * 5);
        make.bottom.mas_equalTo(self.cancelBtn.mas_top).offset(-PADDING_UNIT * 3);
        make.size.mas_equalTo(24);
    }];
    
    [self.protocolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.agreeBtn.mas_right).offset(PADDING_UNIT);
        make.centerY.mas_equalTo(self.agreeBtn);
    }];
}

- (void)clickAgreeButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)clickCancelButton:(MXAPPLoadingButton *)sender {
    [sender startAnimation];
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/troubadour" params:nil success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [sender stopAnimation];
        // 删除本地消息
        [[MXGlobal global] deleteUserLoginInfo];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [sender stopAnimation];
    }];
}

- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cancel_top_img"]];
    }
    
    return _topImgView;
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

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.numberOfLines = 0;
    }
    
    return _titleLab;;
}

- (MXAPPCancelItem *)firstItem {
    if (!_firstItem) {
        _firstItem = [[MXAPPCancelItem alloc] initWithFrame:CGRectZero];
    }
    
    return _firstItem;
}

- (MXAPPCancelItem *)secondItem {
    if (!_secondItem) {
        _secondItem = [[MXAPPCancelItem alloc] initWithFrame:CGRectZero];
    }
    
    return _secondItem;
}

- (MXAPPCancelItem *)thirtItem {
    if (!_thirtItem) {
        _thirtItem = [[MXAPPCancelItem alloc] initWithFrame:CGRectZero];
    }
    
    return _thirtItem;
}

- (UILabel *)warningLab {
    if (!_warningLab) {
        _warningLab = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    return _warningLab;
}

- (UIButton *)agreeBtn {
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setImage:[UIImage imageNamed:@"login_protocol_normal"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"login_protocol_sel"] forState:UIControlStateSelected];
        _agreeBtn.selected = YES;
    }
    
    return _agreeBtn;
}

- (UILabel *)protocolLab {
    if (!_protocolLab) {
        _protocolLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _protocolLab.textColor = BLACK_COLOR_333333;
        _protocolLab.font = [UIFont systemFontOfSize:14];
        _protocolLab.text = [[MXAPPLanguage language] languageValue:@"cancel_title7"];
    }
    
    return _protocolLab;
}

- (MXAPPLoadingButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"cancel_title8"] radius:12];
        _cancelBtn.backgroundColor = [UIColor colorWithHexString:@"#F2442D"];
    }
    
    return _cancelBtn;
}

@end
