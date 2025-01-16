//
//  MXAPPLoginViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "MXAPPLoginViewController.h"
#import "MXAPPLoginInputView.h"
#import "MXLoginModel.h"

@interface MXAPPLoginViewController ()<MXHideNavigationBarProtocol, APPLoginInputProtocol>

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *helloLab;
@property (nonatomic, strong) UIImageView *cashImgView;
@property (nonatomic, strong) MXAPPGradientView *gView;
@property (nonatomic, strong) MXAPPLoginInputView *loginInputView;

@end

@implementation MXAPPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self layoutLoginViews];
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    [self.loginInputView phoneShowKeyboard];
}

- (void)clickBackButton:(UIButton *)sender {
    [self.loginInputView stopTimer];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - APPLoginInputProtocol
- (void)requestSMSCode:(MXAPPTimerButton *)sender phoneNumber:(NSString *)phone {
    if ([NSString isEmptyString:phone]) {
        [self.view makeToast:[[MXAPPLanguage language] languageValue:@"login_toast1"]];
        return;
    }
    sender.enabled = NO;
    [sender startTimer];
    self.buryBeginTime = [NSDate timeStamp];
    
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/jacob" params:@{@"edward": phone} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [weakSelf.view makeToast:responseObject.responseMsg];
        [weakSelf.loginInputView codeShowKeyboard];
        sender.enabled = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

- (void)requestVoiceCode:(UIButton *)sender phoneNumber:(NSString *)phone {
    if ([NSString isEmptyString:phone]) {
        [self.view makeToast:[[MXAPPLanguage language] languageValue:@"login_toast1"]];
        return;
    }
    
    sender.enabled = NO;
    self.buryBeginTime = [NSDate timeStamp];
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/waller" params:@{@"edward": phone} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [weakSelf.view makeToast:responseObject.responseMsg];
        [weakSelf.loginInputView codeShowKeyboard];
        sender.enabled = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

- (void)requestLogin:(MXAPPLoadingButton *)sender phoneNumber:(NSString *)phone smsCode:(NSString *)code {
    if ([NSString isEmptyString:phone]) {
        [self.view makeToast:[[MXAPPLanguage language] languageValue:@"login_toast1"]];
        return;
    }
    
    if ([NSString isEmptyString:code]) {
        [self.view makeToast:[[MXAPPLanguage language] languageValue:@"login_toast2"]];
        return;
    }
    
    [sender startAnimation];
    
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/nekita" params:@{@"composer": phone, @"crandall":code} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [sender stopAnimation];
        MXLoginModel *loginModel = [MXLoginModel modelWithDictionary:responseObject.jsonDict];
        // 记录登录态
        [MXGlobal global].loginModel = loginModel;
        [[MXGlobal global] encoderUserLoginInfo];
        // 埋点
        [MXAPPBuryReport riskControlReport:APP_Register beginTime:weakSelf.buryBeginTime endTime:[NSDate timeStamp] orderNumber:nil];
        [weakSelf clickBackButton:weakSelf.backBtn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [sender stopAnimation];
        [weakSelf.loginInputView clearCodeText];
    }];
}

#pragma mark - Private Methods
- (void)setupUI {
    
    [self.gView buildGradientWithColors:@[[UIColor colorWithHexString:@"#FF980A"],[UIColor colorWithRGBA:0xFFF5E400]] gradientStyle:TopToBottom];
    self.helloLab.attributedText = [NSAttributedString attributeText1:[[MXAPPLanguage language] languageValue:@"login_title1"] text1Color:BLACK_COLOR_333333 text1Font:[UIFont boldSystemFontOfSize:30] text2:[[MXAPPLanguage language] languageValue:@"login_title2"] text2Color:BLACK_COLOR_666666 text1Font:[UIFont systemFontOfSize:16] paramDistance:PADDING_UNIT paraAlign:NSTextAlignmentLeft];
    
    [self.backBtn addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginInputView.loginDelegate = self;
    
    [self.view addSubview:self.gView];
    [self.gView addSubview:self.backBtn];
    [self.gView addSubview:self.helloLab];
    [self.gView addSubview:self.cashImgView];
    [self.view addSubview:self.loginInputView];
}

- (void)layoutLoginViews {
    
    [self.gView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(0.5);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gView).offset(20);
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_statusBarAndSafeAreaHeight + 20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.helloLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gView).offset(PADDING_UNIT * 4);
        make.top.mas_equalTo(self.backBtn.mas_bottom).offset(PADDING_UNIT * 10);
        make.width.mas_equalTo(self.view).multipliedBy(0.55);
    }];
    
    [self.cashImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-PADDING_UNIT * 4);
        make.top.mas_equalTo(self.backBtn.mas_bottom);
    }];
    
    [self.loginInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 4);
        make.right.mas_equalTo(self.view).offset(- PADDING_UNIT * 4);
        make.top.mas_equalTo(self.helloLab.mas_bottom).offset(PADDING_UNIT * 7);
    }];
}

- (UILabel *)helloLab {
    if (!_helloLab) {
        _helloLab = [[UILabel alloc] init];
        _helloLab.numberOfLines = 0;
    }
    
    return _helloLab;
}

- (UIImageView *)cashImgView {
    if (!_cashImgView) {
        _cashImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_cash"]];
    }
    
    return _cashImgView;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[[UIImage systemImageNamed:@"chevron.backward"] imageWithTintColor:BLACK_COLOR_333333 renderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    
    return _backBtn;
}

- (MXAPPGradientView *)gView {
    if (!_gView) {
        _gView = [[MXAPPGradientView alloc] init];
    }
    return _gView;
}

- (MXAPPLoginInputView *)loginInputView {
    if (!_loginInputView) {
        _loginInputView = [[MXAPPLoginInputView alloc] init];
    }
    
    return _loginInputView;
}

@end
