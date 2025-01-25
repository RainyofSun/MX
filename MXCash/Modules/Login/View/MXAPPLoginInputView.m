//
//  MXAPPLoginInputView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXAPPLoginInputView.h"
#import "MXCustomTextFiled.h"
#import "MXCustomTextView.h"
#import "UIView+MXViewAnimation.h"

@interface MXAPPLoginInputView ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *phoneTitleLab;
@property (nonatomic, strong) MXCustomTextFiled *phoneTextFiled;
@property (nonatomic, strong) UILabel *codeTitleLab;
@property (nonatomic, strong) MXCustomTextFiled *codeTextFiled;
@property (nonatomic, strong) UIButton *voiceCodeBtn;
@property (nonatomic, strong) MXAPPLoadingButton *loginBtn;
@property (nonatomic, strong) UIButton *protocolBtn;
@property (nonatomic, strong) MXCustomTextView *protocolTextView;
@property (nonatomic, strong) MXAPPTimerButton *timerBtn;

@end

@implementation MXAPPLoginInputView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
        [self layoutInputViews];
    }
    return self;
}

- (void)phoneShowKeyboard {
    if ([self.phoneTextFiled isFirstResponder]) {
        return;
    }
    
    if ([self.phoneTextFiled canBecomeFirstResponder]) {
        [self.phoneTextFiled becomeFirstResponder];
    }
}

- (void)codeShowKeyboard {
    if ([self.codeTextFiled isFirstResponder]) {
        return;
    }
    
    if ([self.codeTextFiled canBecomeFirstResponder]) {
        [self.codeTextFiled becomeFirstResponder];
    }
}

- (void)clearCodeText {
    [self.codeTextFiled shakeAnimation:horizontal repeatCount:5 anmationTime:0.1 offset:3 completion:^{
        self.codeTextFiled.text = @"";
        [self codeShowKeyboard];
    }];
}

- (void)stopTimer {
    [self.timerBtn stopTimer];
    self.timerBtn = nil;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 16;
    self.clipsToBounds = YES;
    
    
    self.protocolTextView.delegate = self;
    [self.voiceCodeBtn addTarget:self action:@selector(clickVoiceCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.protocolBtn addTarget:self action:@selector(clickProtocolButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.phoneTitleLab.attributedText = [NSAttributedString attachmentImage:@"login_phone" afterText:NO imagePosition:-5 attributeString:[[MXAPPLanguage language] languageValue:@"login_phone"] textColor:BLACK_COLOR_333333 textFont:[UIFont systemFontOfSize:16]];
    self.codeTitleLab.attributedText = [NSAttributedString attachmentImage:@"login_code" afterText:NO imagePosition:-5 attributeString:[[MXAPPLanguage language] languageValue:@"login_code"] textColor:BLACK_COLOR_333333 textFont:[UIFont systemFontOfSize:16]];
    
    [self addSubview:self.phoneTitleLab];
    [self addSubview:self.phoneTextFiled];
    [self addSubview:self.codeTitleLab];
    [self addSubview:self.codeTextFiled];
    [self addSubview:self.voiceCodeBtn];
    [self addSubview:self.loginBtn];
    [self addSubview:self.protocolBtn];
    [self addSubview:self.protocolTextView];
}

- (void)layoutInputViews {
    [self.phoneTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
        make.top.mas_equalTo(self).offset(PADDING_UNIT * 8);
        make.right.equalTo(self).offset(-PADDING_UNIT * 4);
    }];
    
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.phoneTitleLab);
        make.top.mas_equalTo(self.phoneTitleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
        make.height.mas_equalTo(54);
    }];
    
    [self.codeTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.phoneTitleLab);
        make.top.mas_equalTo(self.phoneTextFiled.mas_bottom).offset(PADDING_UNIT * 4);
    }];
    
    [self.codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.codeTitleLab);
        make.top.mas_equalTo(self.codeTitleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
        make.height.mas_equalTo(self.phoneTextFiled);
    }];
    
    [self.voiceCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.codeTextFiled);
        make.top.mas_equalTo(self.codeTextFiled.mas_bottom).offset(PADDING_UNIT * 6);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 12);
        make.right.mas_equalTo(self).offset(-PADDING_UNIT * 12);
        make.top.mas_equalTo(self.voiceCodeBtn.mas_bottom).offset(PADDING_UNIT * 8);
        make.height.mas_equalTo(48);
    }];
    
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.codeTextFiled);
        make.centerY.mas_equalTo(self.protocolTextView);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.protocolTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.protocolBtn.mas_right).offset(PADDING_UNIT * 1.5);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(PADDING_UNIT);
        make.right.mas_equalTo(self).offset(-PADDING_UNIT);
        make.bottom.mas_equalTo(self).offset(-PADDING_UNIT * 7);
    }];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    if ([URL.absoluteString isEqualToString:[MXGlobal global].privateProtocol]) {
        [[MXAPPRouting shared] pageRouter:URL.absoluteString backToRoot:YES targetVC:nil];
        return NO;
    }
    
    return YES;
}

#pragma mark - Target
- (void)clickProtocolButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)clickLoginButton:(MXAPPLoadingButton *)sender {
    if (!self.protocolBtn.isSelected) {
        [[UIDevice currentDevice].keyWindow makeToast:[[MXAPPLanguage language] languageValue:@"login_agree_cancel_protocol"]];
        return;
    }
    
    [self.loginDelegate requestLogin:sender phoneNumber:self.phoneTextFiled.text smsCode:self.codeTextFiled.text];
}

- (void)clickCodeButton:(MXAPPTimerButton *)sender {
    [self.loginDelegate requestSMSCode:sender phoneNumber:self.phoneTextFiled.text];
}

- (void)clickVoiceCodeButton:(UIButton *)sender {
    [self.loginDelegate requestVoiceCode:sender phoneNumber:self.phoneTextFiled.text];
}

#pragma mark - Setter
- (UILabel *)phoneTitleLab {
    if (!_phoneTitleLab) {
        _phoneTitleLab = [[UILabel alloc] init];
    }
    
    return _phoneTitleLab;
}

- (MXCustomTextFiled *)phoneTextFiled {
    if (!_phoneTextFiled) {
        _phoneTextFiled = [[MXCustomTextFiled alloc] init];
        _phoneTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[[MXAPPLanguage language] languageValue:@"login_phone_placeholder"] attributes:@{NSForegroundColorAttributeName: BLACK_COLOR_666666, NSFontAttributeName: [UIFont systemFontOfSize:14]}];
        _phoneTextFiled.font = [UIFont systemFontOfSize:14];
        _phoneTextFiled.textColor = BLACK_COLOR_333333;
        _phoneTextFiled.layer.cornerRadius = 10;
        _phoneTextFiled.clipsToBounds = YES;
        _phoneTextFiled.borderStyle = UITextBorderStyleNone;
        _phoneTextFiled.backgroundColor = [UIColor colorWithHexString:@"#FFF5E4"];
        _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _phoneTextFiled;
}

- (UILabel *)codeTitleLab {
    if (!_codeTitleLab) {
        _codeTitleLab = [[UILabel alloc] init];
    }
    
    return _codeTitleLab;
}

- (MXCustomTextFiled *)codeTextFiled {
    if (!_codeTextFiled) {
        _codeTextFiled = [[MXCustomTextFiled alloc] init];
        _codeTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[[MXAPPLanguage language] languageValue:@"login_code_placeholder"] attributes:@{NSForegroundColorAttributeName: BLACK_COLOR_666666, NSFontAttributeName: [UIFont systemFontOfSize:14]}];
        _codeTextFiled.font = [UIFont systemFontOfSize:14];
        _codeTextFiled.textColor = BLACK_COLOR_333333;
        _codeTextFiled.layer.cornerRadius = 10;
        _codeTextFiled.clipsToBounds = YES;
        _codeTextFiled.borderStyle = UITextBorderStyleNone;
        _codeTextFiled.backgroundColor = [UIColor colorWithHexString:@"#FFF5E4"];
        
        MXAPPTimerButton *timer = [[MXAPPTimerButton alloc] init];
        [timer addTarget:self action:@selector(clickCodeButton:) forControlEvents:UIControlEventTouchUpInside];
        self.timerBtn = timer;
        _codeTextFiled.rightView = timer;
        _codeTextFiled.rightViewMode = UITextFieldViewModeAlways;
        _codeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _codeTextFiled;
}

- (UIButton *)voiceCodeBtn {
    if (!_voiceCodeBtn) {
        _voiceCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *attriStr = [NSAttributedString attachmentImageWithUnderLine:@"login_voice_code" afterText:NO imagePosition:-5 attributeString:[[MXAPPLanguage language] languageValue:@"login_voice_code_btn"] textColor:ORANGE_COLOR_FA6603 textFont:[UIFont systemFontOfSize:14]];
        
        [_voiceCodeBtn setAttributedTitle:attriStr forState:UIControlStateNormal];
    }
    
    return _voiceCodeBtn;
}

- (MXAPPLoadingButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"login_btn_title"] radius:12];
    }
    
    return _loginBtn;
}

- (UIButton *)protocolBtn {
    if (!_protocolBtn) {
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocolBtn setImage:[UIImage imageNamed:@"login_protocol_normal"] forState:UIControlStateNormal];
        [_protocolBtn setImage:[UIImage imageNamed:@"login_protocol_sel"] forState:UIControlStateSelected];
        _protocolBtn.selected = YES;
    }
    
    return _protocolBtn;
}

- (MXCustomTextView *)protocolTextView {
    if (!_protocolTextView) {
        _protocolTextView = [[MXCustomTextView alloc] init];
        NSString *totalStr = [NSString stringWithFormat:@"%@%@", [[MXAPPLanguage language] languageValue:@"login_protocol1"], [[MXAPPLanguage language] languageValue:@"login_protocol2"]];
        NSMutableAttributedString *contentStr1 = [[NSMutableAttributedString alloc] initWithString:[[MXAPPLanguage language] languageValue:@"login_protocol1"] attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#898989"], NSFontAttributeName: [UIFont systemFontOfSize:14]}];
        NSAttributedString *contenStr2 = [[NSAttributedString alloc] initWithString:[[MXAPPLanguage language] languageValue:@"login_protocol2"] attributes:@{NSForegroundColorAttributeName: ORANGE_COLOR_FA6603, NSFontAttributeName: [UIFont systemFontOfSize:14]}];
        [contentStr1 appendAttributedString:contenStr2];
        
        NSRange range = [totalStr rangeOfString:[[MXAPPLanguage language] languageValue:@"login_protocol2"] options:NSRegularExpressionSearch range:NSMakeRange(0, totalStr.length)];
        [contentStr1 addAttributes:@{NSLinkAttributeName: [NSURL URLWithString:[MXGlobal global].privateProtocol]} range:range];
        
        _protocolTextView.attributedText = contentStr1;
        _protocolTextView.editable = NO;
        _protocolTextView.scrollEnabled = NO;
    }
    
    return _protocolTextView;
}
@end
