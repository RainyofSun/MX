//
//  MXGuideViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "MXGuideViewController.h"
#import "MXAPPGradientView.h"
#import "MXAPPNetObserver.h"
#import "MXAPPGuideModel.h"
#import "MXAPPDomainModel.h"
#import "MXNetRequestURL.h"
#import "MXNetRequestConfig.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface MXGuideViewController ()

@property (nonatomic, strong) MXAPPGradientView *gView;
@property (nonatomic, strong) UIImageView *centerImgView;
@property (nonatomic, strong) UILabel *centerLab;
@property (nonatomic, strong) MXAPPLoadingButton *tryButton;

@end

@implementation MXGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self reloadText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStatusChange:) name:(NSNotificationName)APP_NET_CHANGE_NOTIFICATION object:nil];
    [self guideNetRequest];
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    [self layoutViews];
}

- (void)guideNetRequest {
    WeakSelf;
    NSDictionary *dict = @{@"druckman":[NSLocale currentLocale].languageCode, @"jacob":@"0", @"waller": @"0"};
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/druckman" params:dict success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [weakSelf.tryButton stopAnimation];
        MXAPPGuideModel *guideModel = [MXAPPGuideModel modelWithDictionary:responseObject.jsonDict];
        [MXGlobal global].isAppInitializationSuccess = YES;
        [MXGlobal global].languageCode = guideModel.margaret;
        [MXGlobal global].privateProtocol = guideModel.laureate;
        // 存储语言
        [MXUserDefaultCache cacheLanguageCode:guideModel.margaret];
        // 初始化多语言
        [[MXAPPLanguage language] setLanguageBundleType:[MXUserDefaultCache readLanguageCodeFromCache]];
        [weakSelf reloadText];
#if DEBUG
#else
        // 初始化FaceBook
        [weakSelf initializationFaceBook:guideModel.poet];
#endif
        [weakSelf.delegate guideDidDismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        weakSelf.tryButton.hidden = NO;
        // 切换域名
        [weakSelf switchRequestDomain];
    }];
}

- (void)switchRequestDomain {
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Download reqesutUrl:[NSString stringWithFormat:@"%@%@",Dynamic_Domain_URL, Dynamic_Domain_Path] params:nil success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        NSArray <MXAPPDomainModel*>* domains = [NSArray modelArrayWithClass:[MXAPPDomainModel class] json: responseObject.responseMsg];
        [domains enumerateObjectsUsingBlock:^(MXAPPDomainModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![NSString isEmptyString:obj.ac] && [[MXNetRequestURL shared] setNewRequestDomainURL:obj.ac]) {
                [[MXNetRequestConfig requestConfig] updateRequestURL];
                *stop = YES;
            }
        }];
        [weakSelf guideNetRequest];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

- (void)netStatusChange:(NSNotification *)notification {
    MXNetworkStatus status = (MXNetworkStatus)notification.object;
    if (status != NONet && [MXUserDefaultCache isFirstTimeInstallApp]) {
        [self guideNetRequest];
        [[MXAPPNetObserver Observer] stopNetObserver];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)clickTryButton:(MXAPPLoadingButton *)sender {
    [sender startAnimation];
    [self guideNetRequest];
}

#pragma mark - Private Methods
- (void)setupUI {
    
    [self.tryButton addTarget:self action:@selector(clickTryButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.gView];
    [self.view addSubview:self.centerImgView];
    [self.view addSubview:self.centerLab];
    [self.view addSubview:self.tryButton];
}

- (void)reloadText {
    self.centerLab.attributedText = [NSAttributedString attributeText1:[[MXAPPLanguage language] languageValue:@"guide_title1"] text1Color:[UIColor colorWithHexString:@"#333333"] text1Font:[UIFont boldSystemFontOfSize:24] text2:[[MXAPPLanguage language] languageValue:@"guide_title2"] text2Color:[UIColor colorWithHexString:@"#666666"] text1Font:[UIFont systemFontOfSize:16] paramDistance:-1 paraAlign:NSTextAlignmentCenter];
    [self.tryButton setTitle:[[MXAPPLanguage language] languageValue:@"guide_try_again"] forState:UIControlStateNormal];
}

- (void)initializationFaceBook:(MXAPPFaceBookModel *)fbModel {
    [FBSDKSettings sharedSettings].appID = fbModel.statuary;
    [FBSDKSettings sharedSettings].displayName = fbModel.statues;
    [FBSDKSettings sharedSettings].clientToken = fbModel.ives;
    [FBSDKSettings sharedSettings].appURLSchemeSuffix = fbModel.trumbull;
    [FBSDKSettings sharedSettings].isAutoLogAppEventsEnabled = YES;
    [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
}

- (void)layoutViews {
    [self.gView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.centerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(150 + [UIDevice currentDevice].app_safeDistanceTop);
        make.centerX.mas_equalTo(self.view).offset(25);
    }];
    
    [self.centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 4);
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 4);
        make.top.mas_equalTo(self.centerImgView.mas_bottom).offset(PADDING_UNIT);
    }];
    
    [self.tryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 9);
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 9);
        make.height.mas_equalTo(46);
        make.bottom.mas_equalTo(self.view).offset(-[UIDevice currentDevice].app_tabbarAndSafeAreaHeight - 8);
    }];
}

- (MXAPPGradientView *)gView {
    if (!_gView) {
        _gView = [[MXAPPGradientView alloc] init];
        [_gView buildGradientWithColors:@[ORANGE_COLOR_F7D376,PINK_COLOR_F6AB9D] gradientStyle:LeftTopToRightBottom];
    }
    
    return _gView;
}

- (UIImageView *)centerImgView {
    if (!_centerImgView) {
        _centerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_cash"]];
    }
    
    return _centerImgView;
}

- (UILabel *)centerLab {
    if (!_centerLab) {
        _centerLab = [[UILabel alloc] init];
        _centerLab.numberOfLines = 0;
        _centerLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _centerLab;
}

- (MXAPPLoadingButton *)tryButton {
    if (!_tryButton) {
        _tryButton = [MXAPPLoadingButton buttonWithType:UIButtonTypeCustom];
        [_tryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tryButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _tryButton.layer.cornerRadius = 12;
        _tryButton.clipsToBounds = YES;
        _tryButton.hidden = YES;
        _tryButton.backgroundColor = ORANGE_COLOR_FF8D0E;
    }
    
    return _tryButton;
}

@end
