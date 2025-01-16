//
//  MXAPPHomeViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/2.
//

#import "MXAPPHomeViewController.h"
#import "MXHomeTopCashView.h"
#import "MXHomeApplyCashView.h"
#import "MXHomeApplyBigCardView.h"
#import "MXHomeApplySmallCardView.h"
#import "MXAPPHomeModel.h"
#import "MXAPPCityModel.h"
#import "MXAPPCalculateViewController.h"
#import "MXAPPProductViewController.h"

@interface MXAPPHomeViewController ()<MXHideNavigationBarProtocol, ApplyBigCardProtocol, HomeApplyCashProtocol, ApplySmallCardProtocol>

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) MXHomeTopCashView *cashView;
@property (nonatomic, strong) MXHomeApplyCashView *applyView;
@property (nonatomic, strong) MXHomeApplyBigCardView *bigCardView;
@property (nonatomic, strong) MXHomeApplySmallCardView *smallCardView;

@property (nonatomic, strong) MXAPPProductModel *recommendProduct;
@property (nonatomic, strong) MXAPPCustomerModel *customerModel;

@end

@implementation MXAPPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self layoutHomeViews];
    [self downloadCityList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.contentView refresh:YES];
    // 位置上报
    [self updateLocation];
    [MXAPPBuryReport appLocationReport];
    // IDFA&IDFV 上报
    if ([MXAuthorizationTool authorization].ATTTrackingStatus == Authorized) {
        [MXAPPBuryReport IDFAAndIDFVReport];
    }
    // 设备信息上报
    [MXAPPBuryReport currentDeviceInfoReport];
}

- (void)loadRequest {
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/laureate" params:nil success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [weakSelf.contentView refresh:NO];
        MXAPPHomeModel *homeModel = [[MXAPPHomeModel modelWithDictionary:responseObject.jsonDict] homeDataFilter];
        weakSelf.customerModel = homeModel.hero;
        if (homeModel.bigCardModel != nil) {
            // 更新大卡位
            [weakSelf.applyView reloadRecommendProductModel:homeModel.bigCardModel];
            [weakSelf updateHomeCardLayout:YES];
            weakSelf.recommendProduct = homeModel.bigCardModel;
        }
        
        if (homeModel.smallCardModel != nil) {
            // 更新小卡位
            [weakSelf.applyView reloadRecommendProductModel:homeModel.smallCardModel];
            [weakSelf updateHomeCardLayout:NO];
            if (homeModel.productModels.count != 0) {
                [weakSelf.smallCardView reloadSmallCardProducts:homeModel.productModels];
            }
            weakSelf.recommendProduct = homeModel.smallCardModel;
        }
        
        if (homeModel.scrollMsg.count != 0) {
            [weakSelf.applyView reloadCashMarquee:homeModel.scrollMsg];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [weakSelf.contentView refresh:NO];
    }];
}

- (void)downloadCityList {
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"v3/certify/city-init" params:nil success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [MXAPPCityModel writeCityJsonToFile:responseObject.jsonArray.modelToJSONString];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

- (void)gotoProductDetail:(NSString *)productId sender:(MXAPPLoadingButton *)sender {
    [sender startAnimation];
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/poet" params:@{@"tin": productId} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        MXAPPProductAuthModel *authModel = [MXAPPProductAuthModel modelWithDictionary:responseObject.jsonDict];
        [[MXAPPRouting shared] pageRouter:authModel.figures backToRoot:YES targetVC:[[MXAPPProductViewController alloc] initWithProductIDNumber:weakSelf.recommendProduct.broadbill]];
        [sender stopAnimation];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [sender stopAnimation];
    }];
}

#pragma mark ApplyBigCardProtocol
- (void)clickApplyPlan {
    if ([MXGlobal global].isLoginOut) {
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSNotificationName)APP_LOGIN_EXPIRED_NOTIFICATION object:nil];
        return;
    }
    
    if ([NSString isEmptyString:self.customerModel.corsair]) {
        return;
    }
    
    [[MXAPPRouting shared] pageRouter:self.customerModel.corsair backToRoot:YES targetVC:nil];
}

- (void)clickFeedBack {
    if ([MXGlobal global].isLoginOut) {
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSNotificationName)APP_LOGIN_EXPIRED_NOTIFICATION object:nil];
        return;
    }

    if ([NSString isEmptyString:self.customerModel.noted]) {
        return;
    }
    
    [[MXAPPRouting shared] pageRouter:self.customerModel.noted backToRoot:YES targetVC:nil];
}

#pragma mark - ApplySmallCardProtocol
- (void)didSelectedProduct:(MXAPPProductModel *)model sender:(nonnull MXAPPLoadingButton *)sender {
    [self gotoProductDetail:model.broadbill sender:sender];
}

#pragma mark HomeApplyCashProtocol
- (void)clickLoanApply:(MXAPPLoadingButton *)sender {
    if ([NSString isEmptyString:self.recommendProduct.broadbill]) {
        return;
    }
    [self gotoProductDetail:self.recommendProduct.broadbill sender:sender];
}

- (void)setupUI {
    
    [self topImage:@"home_top_bg"];
    
    WeakSelf;
    [self.contentView addMJRefresh:NO refreshCall:^(BOOL refresh) {
        [weakSelf loadRequest];
    }];
    
    self.bigCardView.bigCardDelegate = self;
    self.smallCardView.smallCardDelegate = self;
    self.applyView.cashDelegate = self;
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.cashView];
    [self.contentView addSubview:self.applyView];
}

- (void)layoutHomeViews {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-[UIDevice currentDevice].app_tabbarAndSafeAreaHeight);
    }];
    
    [self.cashView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.view);
    }];
    
    [self.applyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.cashView);
        make.top.mas_equalTo(self.cashView.mas_bottom);
    }];
}

- (void)updateHomeCardLayout:(BOOL)isBigCard {
    self.bigCardView.hidden = !isBigCard;
    self.smallCardView.hidden = isBigCard;
    
    if (isBigCard) {
        [self.smallCardView removeFromSuperview];
        [self.contentView addSubview:self.bigCardView];
        
        [self.bigCardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.mas_equalTo(self.cashView);
            make.top.mas_equalTo(self.applyView.mas_bottom).offset(PADDING_UNIT * 3.5);
            make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 2.5);
        }];
    } else {
        [self.bigCardView removeFromSuperview];
        [self.contentView addSubview:self.smallCardView];
        
        [self.smallCardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.mas_equalTo(self.cashView);
            make.top.mas_equalTo(self.applyView.mas_bottom).offset(PADDING_UNIT * 3.5);
            make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 2.5);
        }];
    }
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _contentView;
}

- (MXHomeTopCashView *)cashView {
    if (!_cashView) {
        _cashView = [[MXHomeTopCashView alloc] init];
    }
    return _cashView;
}

- (MXHomeApplyCashView *)applyView {
    if (!_applyView) {
        _applyView = [[MXHomeApplyCashView alloc] init];
    }
    
    return _applyView;
}

- (MXHomeApplyBigCardView *)bigCardView {
    if (!_bigCardView) {
        _bigCardView = [[MXHomeApplyBigCardView alloc] init];
    }
    
    return _bigCardView;
}

- (MXHomeApplySmallCardView *)smallCardView {
    if (!_smallCardView) {
        _smallCardView = [[MXHomeApplySmallCardView alloc] init];
    }
    
    return _smallCardView;
}

@end
