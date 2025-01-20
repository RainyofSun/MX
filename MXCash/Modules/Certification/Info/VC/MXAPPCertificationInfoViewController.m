//
//  MXAPPCertificationInfoViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPCertificationInfoViewController.h"
#import "MXAPPCertificationInfoModel.h"
#import "MXAPPInfoCertificationItem.h"
#import "MXAPPSingleChoiseView.h"
#import "MXAPPCitySelectView.h"

@interface MXAPPCertificationInfoViewController ()<APPInfoCertificationProtocol>

@property (nonatomic, strong) UIScrollView *vScrollView;
@property (nonatomic, strong) MXAPPProcessBar *processBar;
@property (nonatomic, strong) MXAPPLoadingButton *saveBtn;

@property (nonatomic, assign) CGFloat process;
@property (nonatomic, assign) CertificationInfoType requestType;
@property (nonatomic, strong) NSMutableDictionary *saveParams;
@property (nonatomic, copy) NSString *navTitle;
@end

@implementation MXAPPCertificationInfoViewController

- (instancetype)initWithCertificationProcess:(CGFloat)process infoType:(CertificationInfoType)type navigationTitle:(nonnull NSString *)title {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.process = process;
        self.requestType = type;
        self.navTitle = title;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self layoutInfoViews];
}

- (NSString *)requestUrl {
    switch (self.requestType) {
        case PersonalInfo:
            return @"secondary/crandall";
        case WorkingInfo:
            return @"secondary/heroine";
        case BankInfo:
            return @"secondary/seals";
    }
}

- (NSString *)saveRequestUrl {
    switch (self.requestType) {
        case PersonalInfo:
            return @"secondary/prudence";
        case WorkingInfo:
            return @"secondary/hero";
        case BankInfo:
            return @"secondary/sites";
    }
}

- (MXBuryRiskControlType)reportType {
    switch (self.requestType) {
        case PersonalInfo:
            return APP_PersonalInfo;
        case WorkingInfo:
            return APP_WorkingInfo;
        case BankInfo:
            return APP_BindingBankCard;
    }
}

- (void)netRequest {
    if ([NSString isEmptyString:[MXGlobal global].productIDNumber]) {
        return;
    }
    
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:[self requestUrl] params:@{@"tin": [MXGlobal global].productIDNumber} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [weakSelf.vScrollView refresh:NO];
        MXAPPCertificationInfoModel *infoModel = [MXAPPCertificationInfoModel modelWithDictionary:responseObject.jsonDict];
        [weakSelf buildInfoViews:infoModel.mantis];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [weakSelf.vScrollView refresh:NO];
    }];
}

- (void)buildInfoViews:(NSArray <MXAPPQuestionModel *>*)modelSource {
    __block MXAPPInfoCertificationItem *topItem = nil;
    
    WeakSelf;
    [modelSource enumerateObjectsUsingBlock:^(MXAPPQuestionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MXAPPInfoCertificationItem *tempItem = [[MXAPPInfoCertificationItem alloc] initWithFrame:CGRectZero];
        tempItem.itemDelegate = weakSelf;
        [tempItem reloadInfoViewWithModel:obj];
        [weakSelf.vScrollView addSubview:tempItem];
        // 保存参数
        if (![NSString isEmptyString:tempItem.paramsKey] && ![NSString isEmptyString:obj.tartan]) {
            [self.saveParams setValue:obj.tartan forKey:tempItem.paramsKey];
        }
        
        if (topItem != nil) {
            if (idx == modelSource.count - 1) {
                [tempItem mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(topItem.mas_bottom);
                    make.left.width.mas_equalTo(topItem);
                    make.bottom.mas_equalTo(weakSelf.vScrollView).offset(-PADDING_UNIT * 3);
                }];
            } else {
                [tempItem mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(topItem.mas_bottom);
                    make.left.width.mas_equalTo(topItem);
                }];
            }
        } else {
            [tempItem mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.processBar.mas_bottom).offset(PADDING_UNIT);
                make.left.width.mas_equalTo(weakSelf.vScrollView);
            }];
        }
        
        topItem = tempItem;
    }];
}

- (void)clickSaveBtn:(MXAPPLoadingButton *)sender {
    [sender startAnimation];
    [self.saveParams setValue:[MXGlobal global].productIDNumber forKey:@"tin"];
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:[self saveRequestUrl] params:self.saveParams success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [sender stopAnimation];
        // 埋点
        [MXAPPBuryReport riskControlReport:[weakSelf reportType] beginTime:weakSelf.buryBeginTime endTime:[NSDate timeStamp] orderNumber:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [sender stopAnimation];
    }];
}

#pragma mark - APPInfoCertificationProtocol
- (void)clickCertificationInfoView:(MXAPPInfoCertificationItem *)itemView itemType:(ControlType)type {
    [self.view endEditing:YES];
    if (itemView.choiseModel.count == 0) {
        return;
    }
    
    if (itemView.cType == Choise) {
        MXAPPSingleChoiseView *singleView = [[MXAPPSingleChoiseView alloc] initWithFrame:self.view.bounds];
        [singleView reloadSource:itemView.choiseModel];
        [self.view addSubview:singleView];
        [singleView popAnimation];
        WeakSelf;
        singleView.clickConfirmBlock = ^(MXAPPLoadingButton * _Nonnull sender, MXAPPPopBaseView * _Nonnull pView) {
            MXAPPSingleChoiseView *sView = (MXAPPSingleChoiseView *)pView;
            if (![NSString isEmptyString:itemView.paramsKey] && ![NSString isEmptyString:[NSString stringWithFormat:@"%ld", sView.selectModel.sites]]) {
                [weakSelf.saveParams setValue:@(sView.selectModel.sites) forKey:itemView.paramsKey];
            }
            
            [itemView reloadInfoViewText:sView.selectModel.robin];
            [pView dismissAnimation];
        };
    }
    
    if (itemView.cType == CitySelected) {
        MXAPPCitySelectView *singleView = [[MXAPPCitySelectView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:singleView];
        [singleView popAnimation];
        WeakSelf;
        singleView.clickConfirmBlock = ^(MXAPPLoadingButton * _Nonnull sender, MXAPPPopBaseView * _Nonnull pView) {
            MXAPPCitySelectView *sView = (MXAPPCitySelectView *)pView;
            if (![NSString isEmptyString:itemView.paramsKey] && ![NSString isEmptyString: sView.cityStr]) {
                [weakSelf.saveParams setValue:[sView.cityStr stringByReplacingOccurrencesOfString:@" | " withString:@"|"] forKey:itemView.paramsKey];
            }
            
            [itemView reloadInfoViewText:sView.cityStr];
            [pView dismissAnimation];
        };
    }
}

- (void)didEndEditing:(MXAPPInfoCertificationItem *)itemView inputValue:(NSString *)value {
    if ([NSString isEmptyString:itemView.paramsKey]) {
        return;
    }
    
    [self.saveParams setValue:value forKey:itemView.paramsKey];
}

- (void)setupUI {
    
    self.title = self.navTitle;
    
    [self.saveBtn addTarget:self action:@selector(clickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.vScrollView];
    [self.vScrollView addSubview:self.processBar];
    [self.view addSubview:self.saveBtn];
    
    WeakSelf;
    [self.vScrollView addMJRefresh:NO refreshCall:^(BOOL refresh) {
        [weakSelf netRequest];
    }];
    
    [self.vScrollView refresh:YES];
    [self.processBar updateProcess:self.process];
}

- (void)layoutInfoViews {
    [self.vScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight);
        make.bottom.mas_equalTo(self.saveBtn.mas_top).offset(-PADDING_UNIT * 2);
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 10);
        make.height.mas_equalTo(46);
        make.bottom.mas_equalTo(-[UIDevice currentDevice].app_safeDistanceBottom - PADDING_UNIT * 2);
    }];
    
    [self.processBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vScrollView).offset(PADDING_UNIT * 4);
        make.top.mas_equalTo(self.vScrollView).offset(PADDING_UNIT * 2.5);
        make.width.mas_equalTo(ScreenWidth - PADDING_UNIT * 8);
    }];
}

- (UIScrollView *)vScrollView {
    if (!_vScrollView) {
        _vScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _vScrollView.backgroundColor = [UIColor colorWithHexString:@"#FFF5E4"];
    }
    
    return _vScrollView;
}

- (MXAPPProcessBar *)processBar {
    if (!_processBar) {
        _processBar = [[MXAPPProcessBar alloc] initWithFrame:CGRectZero];
    }
    
    return _processBar;
}

- (MXAPPLoadingButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"certification_submit"] radius:12];
    }
    
    return _saveBtn;
}

- (NSMutableDictionary *)saveParams {
    if (!_saveParams) {
        _saveParams = [NSMutableDictionary dictionary];
    }
    
    return _saveParams;
}

@end
