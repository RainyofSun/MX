//
//  MXAPPSettingViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXAPPSettingViewController.h"
#import "MXAPPMineSettingItem.h"
#import "MXAPPCancelViewController.h"
#import "MXAPPSignoutPopView.h"

@interface MXAPPSettingViewController ()

@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) MXAPPMineSettingItem *versionItem;
@property (nonatomic, strong) UIImageView *lineView1;
@property (nonatomic, strong) MXAPPMineSettingItem *cancelItem;
@property (nonatomic, strong) UIImageView *lineView2;
@property (nonatomic, strong) MXAPPMineSettingItem *signoutItem;

@end

@implementation MXAPPSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    self.title = [[MXAPPLanguage language] languageValue:@"setting_nav_title"];
    
    [self.cancelItem addTarget:self action:@selector(clickCancelItemButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.signoutItem addTarget:self action:@selector(clickSignoutItemButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tipLab];
    [self.view addSubview:self.topImgView];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.versionItem];
    [self.bgView addSubview:self.lineView1];
    [self.bgView addSubview:self.cancelItem];
    [self.bgView addSubview:self.lineView2];
    [self.bgView addSubview:self.signoutItem];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 4);
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight + PADDING_UNIT * 4);
        make.width.mas_equalTo(self.view).multipliedBy(0.6);
    }];
    
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight);
        make.right.mas_equalTo(self.view);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 4);
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 4);
        make.top.mas_equalTo(self.topImgView.mas_bottom);
    }];
    
    [self.versionItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.bgView);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.versionItem);
        make.top.mas_equalTo(self.versionItem.mas_bottom);
    }];
    
    [self.cancelItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.versionItem);
        make.top.mas_equalTo(self.lineView1.mas_bottom);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.cancelItem);
        make.top.mas_equalTo(self.cancelItem.mas_bottom);
    }];
    
    [self.signoutItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.cancelItem);
        make.top.mas_equalTo(self.lineView2.mas_bottom);
        make.bottom.mas_equalTo(self.bgView);
    }];
}

- (void)clickCancelItemButton:(MXAPPMineSettingItem *)sender {
    [self.navigationController pushViewController:[[MXAPPCancelViewController alloc] init] animated:YES];
}

- (void)clickSignoutItemButton:(MXAPPMineSettingItem *)sender {
    MXAPPSignoutPopView *popView = [[MXAPPSignoutPopView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:popView];
    [popView popAnimation];
    WeakSelf;
    popView.clickConfirmBlock = ^(MXAPPLoadingButton * _Nonnull sender, MXAPPPopBaseView * _Nonnull popView) {
        [sender startAnimation];
        [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/troubadour" params:nil success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
            [sender stopAnimation];
            [popView dismissAnimation];
            // 删除本地消息
            [[MXGlobal global] deleteUserLoginInfo];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
            [sender stopAnimation];
        }];
    };
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLab.text = [[MXAPPLanguage language] languageValue:@"setting_tip"];
        _tipLab.textColor = [UIColor whiteColor];
        _tipLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _tipLab.numberOfLines = 0;
    }
    
    return _tipLab;
}

- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_top_img"]];
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

- (MXAPPMineSettingItem *)versionItem {
    if (!_versionItem) {
        _versionItem = [[MXAPPMineSettingItem alloc] initWithFrame:CGRectZero];
        [_versionItem setSettingItemTitle:[[MXAPPLanguage language] languageValue:@"setting_version"] titleImage:@"setting_diamond_img" hideArrow:YES];
    }
    
    return _versionItem;
}

- (UIImageView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_line_img"]];
    }
    
    return _lineView1;
}

- (UIImageView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_line_img"]];
    }
    
    return _lineView2;
}

- (MXAPPMineSettingItem *)cancelItem {
    if (!_cancelItem) {
        _cancelItem = [[MXAPPMineSettingItem alloc] initWithFrame:CGRectZero];
        [_cancelItem setSettingItemTitle:[[MXAPPLanguage language] languageValue:@"setting_cancel"] titleImage:@"setting_user_cancel_img" hideArrow:NO];
    }
    
    return _cancelItem;
}

- (MXAPPMineSettingItem *)signoutItem {
    if (!_signoutItem) {
        _signoutItem = [[MXAPPMineSettingItem alloc] initWithFrame:CGRectZero];
        [_signoutItem setSettingItemTitle:[[MXAPPLanguage language] languageValue:@"setting_sign"] titleImage:@"setting_user_signout_img" hideArrow:NO];
    }
    
    return _signoutItem;
}

@end
