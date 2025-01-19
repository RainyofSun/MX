//
//  MXAPPProductViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXAPPProductViewController.h"
#import "MXAPPProductInfoView.h"
#import "MXAPPLoanModel.h"
#import "MXAPPProcessBar.h"
#import "MXAPPLoanCertficationView.h"
#import "MXAPPQuestionViewController.h"
#import "MXAPPCardViewController.h"
#import "MXAPPCertificationInfoViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "MXAPPContactsViewController.h"

@interface MXAPPProductViewController ()

@property (nonatomic, strong) UIScrollView *vScrollView;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) MXAPPProductInfoView *infoView;
@property (nonatomic, strong) MXAPPProcessBar *processBar;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UIButton *protocolBtn;
@property (nonatomic, strong) MXAPPLoadingButton *applyBtn;

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *protocolUrl;
@property (nonatomic, strong) MXAPPProductModel *productModel;
@property (nonatomic, strong) MXAPPWaitCertificationModel *waitCertificationModel;
@property (nonatomic, assign) CGFloat certificationProcess;

@end

@implementation MXAPPProductViewController

- (instancetype)initWithProductIDNumber:(NSString *)number {
    self = [super initWithNibName:nil bundle:nil];
    
    self.productId = number;
    self.certificationProcess = 0;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self layoutLoanViews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.gradientView cutViewRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight radius:16];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.vScrollView refresh:YES];
}

- (void)netRequest {
    if ([NSString isEmptyString:self.productId]) {
        return;
    }
    
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/trumbull" params:@{@"tin": self.productId} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [weakSelf.vScrollView refresh:NO];
        MXAPPLoanModel *loanModel = [MXAPPLoanModel modelWithJSON:responseObject.jsonDict];
        [weakSelf.infoView reloadProductInfo:loanModel.centuries];
        if (![NSString isEmptyString: loanModel.whale.coined]) {
            weakSelf.agreeBtn.hidden = NO;
            weakSelf.protocolBtn.hidden = NO;
            NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:[[MXAPPLanguage language] languageValue:@"certification_protocol"] attributes:@{NSForegroundColorAttributeName: BLACK_COLOR_333333, NSFontAttributeName: [UIFont systemFontOfSize:14]}];
            [titleStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"<%@>", loanModel.whale.coined] attributes:@{NSForegroundColorAttributeName: ORANGE_COLOR_FA6603, NSFontAttributeName: [UIFont systemFontOfSize:14]}]];
            [weakSelf.protocolBtn setAttributedTitle:titleStr forState:UIControlStateNormal];
            weakSelf.protocolUrl = loanModel.whale.sperm;
        }
        [weakSelf buildAllCertificationView:loanModel.schooner];
        // 记录产品ID
        [MXGlobal global].productIDNumber = loanModel.centuries.broadbill;
        // 记录产品订单号
        [MXGlobal global].productOrderNumber = loanModel.centuries.unknown;
        weakSelf.productModel = loanModel.centuries;
        weakSelf.waitCertificationModel = loanModel.inanimate;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [weakSelf.vScrollView refresh:NO];
    }];
}

- (void)clickProtocolButton:(UIButton *)sender {
    if (![NSString isEmptyString:self.protocolUrl]) {
        [[MXAPPRouting shared] pageRouter:self.protocolUrl backToRoot:YES targetVC:nil];
    }
}

- (void)clickCertificationButton:(MXAPPLoanCertficationView *)sender {
    // 页面刷新时不可以进入认证
    if (self.vScrollView.mj_header.isRefreshing) {
        return;
    }
    
    // 如果有待认证项,优先跳转到待认证
    CertificationType type = sender.type;
    NSString *jump_url = sender.jumpUrl;
    
    if (self.waitCertificationModel != nil && ![self.waitCertificationModel isEqual:[NSNull null]]) {
        type = self.waitCertificationModel.type;
        jump_url = self.waitCertificationModel.figures;
    }
    
    [self gotoCertification:type webUrl:jump_url];
}

- (void)clickLoanButton:(MXAPPLoadingButton *)sender {
    // 页面刷新时不可以进入认证
    if (self.vScrollView.mj_header.isRefreshing) {
        return;
    }
    
    // 如果有待认证项,优先跳转到待认证
    if (self.waitCertificationModel != nil && ![self.waitCertificationModel isEqual:[NSNull null]]) {
        [self gotoCertification:self.waitCertificationModel.type webUrl:self.waitCertificationModel.figures];
        return;
    }
    [sender startAnimation];
    self.buryBeginTime = [NSDate timeStamp];
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/source" params:@{@"valuable": self.productModel.valuable, @"mammal":self.productModel.unknown} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [sender stopAnimation];
        MXAPPApplyModel *applyModel = [MXAPPApplyModel modelWithDictionary:responseObject.jsonDict];
        if (![NSString isEmptyString:applyModel.figures]) {
            [[MXAPPRouting shared] pageRouter:applyModel.figures backToRoot:YES targetVC:nil];
        }
        // 埋点
        [MXAPPBuryReport riskControlReport:APP_BeginLoanApply beginTime:weakSelf.buryBeginTime endTime:weakSelf.buryBeginTime orderNumber:weakSelf.productModel.unknown];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [sender stopAnimation];
    }];
}

- (void)gotoCertification:(CertificationType)type webUrl:(NSString *)url {
    if (![NSString isEmptyString:url]) {
        [[MXAPPRouting shared] pageRouter:url backToRoot:YES targetVC:nil];
    } else {
        switch (type) {
            case Certification_Question:
                [self.navigationController pushViewController:[[MXAPPQuestionViewController alloc] initWithCertificationProcess:self.certificationProcess] animated:YES];
                break;
            case Certification_Card:
                [self.navigationController pushViewController:[[MXAPPCardViewController alloc] initWithCertificationProcess:self.certificationProcess] animated:YES];
                break;
            case Certification_Personal:
                [self.navigationController pushViewController:[[MXAPPCertificationInfoViewController alloc] initWithCertificationProcess:self.certificationProcess infoType:PersonalInfo] animated:YES];
                break;
            case Certification_Work:
                [self.navigationController pushViewController:[[MXAPPCertificationInfoViewController alloc] initWithCertificationProcess:self.certificationProcess infoType:WorkingInfo] animated:YES];
                break;
            case Certification_Contacts:
                [self.navigationController pushViewController:[[MXAPPContactsViewController alloc] initWithCertificationProcess:self.certificationProcess] animated:YES];
                break;
            case Certification_Bank:
                [self.navigationController pushViewController:[[MXAPPCertificationInfoViewController alloc] initWithCertificationProcess:self.certificationProcess infoType:BankInfo] animated:YES];
                break;
            default:
                break;
        }
    }
}

- (void)clickAgreeButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)setupUI {
    WeakSelf;
    [self.vScrollView addMJRefresh:NO refreshCall:^(BOOL refresh) {
        [weakSelf netRequest];
    }];
    
    self.title = [[MXAPPLanguage language] languageValue:@"certification_nav_title"];
    [self.protocolBtn addTarget:self action:@selector(clickProtocolButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.agreeBtn addTarget:self action:@selector(clickAgreeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.applyBtn addTarget:self action:@selector(clickLoanButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.vScrollView];
    [self.vScrollView addSubview:self.tipLab];
    [self.vScrollView addSubview:self.topImgView];
    [self.vScrollView addSubview:self.infoView];
    [self.vScrollView addSubview:self.processBar];
    [self.vScrollView addSubview:self.contentView];
    [self.vScrollView addSubview:self.agreeBtn];
    [self.vScrollView addSubview:self.protocolBtn];
    [self.view addSubview:self.applyBtn];
}

- (void)layoutLoanViews {
    [self.vScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.applyBtn.mas_top).offset(-PADDING_UNIT);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.vScrollView).offset(PADDING_UNIT * 8);
        make.width.mas_equalTo(self.view).multipliedBy(0.6);
    }];
    
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 3.5);
        make.top.mas_equalTo(self.vScrollView);
    }];
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipLab.mas_bottom).offset(PADDING_UNIT * 8);
        make.left.mas_equalTo(self.vScrollView).offset(PADDING_UNIT * 4);
        make.right.mas_equalTo(self.topImgView);
    }];
    
    [self.processBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.mas_equalTo(self.infoView);
        make.top.mas_equalTo(self.infoView.mas_bottom).offset(PADDING_UNIT * 4);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.processBar);
        make.top.mas_equalTo(self.processBar.mas_bottom).offset(PADDING_UNIT * 3.5);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(PADDING_UNIT * 3.5);
        make.size.mas_equalTo(24);
        make.bottom.mas_equalTo(self.vScrollView).offset(-PADDING_UNIT * 2);
    }];
    
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.agreeBtn.mas_right).offset(PADDING_UNIT);
        make.centerY.mas_equalTo(self.agreeBtn);
    }];
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 10);
        make.bottom.mas_equalTo(self.view).offset(-PADDING_UNIT * 2 - [UIDevice currentDevice].app_safeDistanceBottom);
        make.height.mas_equalTo(46);
    }];
}

- (void)buildAllCertificationView:(NSArray <MXAPPCertificationModel *>*)models {
    NSInteger completeCount = 0;
    for (MXAPPCertificationModel *item in models) {
        if (item.ssn) {
            completeCount += 1;
        }
    }
    self.certificationProcess = (CGFloat)completeCount/models.count;
    [self.processBar updateProcess:self.certificationProcess];
    [self.contentView removeAllSubviews];
    
    if (models.count <= 3) {
        UIView *firstView = [self buildCertificationView:models];
        [self.contentView addSubview:firstView];
        [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.contentView);
        }];
    } else {
        NSArray *tempArray1 = [models subarrayWithRange:NSMakeRange(0, 3)];
        UIView *firstView = [self buildCertificationView:tempArray1];
        [self.contentView addSubview:firstView];
        [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.contentView);
        }];
        
        NSArray *tempArray2 = [models subarrayWithRange:NSMakeRange(3, models.count - 3)];
        UIView *secView = [self buildCertificationView:tempArray2];
        [self.contentView addSubview:secView];
        [secView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(firstView);
            make.top.mas_equalTo(firstView.mas_bottom).offset(PADDING_UNIT * 3);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
}

- (UIView *)buildCertificationView:(NSArray <MXAPPCertificationModel*>*)models {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 16;
    contentView.clipsToBounds = YES;
    
    __block MXAPPLoanCertficationView *tempItem = nil;
    [models enumerateObjectsUsingBlock:^(MXAPPCertificationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MXAPPLoanCertficationView *tempView = [[MXAPPLoanCertficationView alloc] initWithFrame:CGRectZero];
        [tempView addTarget:self action:@selector(clickCertificationButton:) forControlEvents:UIControlEventTouchUpInside];
        [tempView reloadCertificationView:obj showLine:(idx != (models.count - 1))];
        [contentView addSubview:tempView];
        
        if (tempItem != nil) {
            if (idx == models.count - 1) {
                [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.mas_equalTo(tempItem);
                    make.top.mas_equalTo(tempItem.mas_bottom);
                    make.bottom.mas_equalTo(contentView);
                }];
            } else {
                [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.mas_equalTo(tempItem);
                    make.top.mas_equalTo(tempItem.mas_bottom);
                }];
            }
        } else {
            if (idx == models.count - 1) {
                [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(contentView);
                }];
            } else {
                [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.mas_equalTo(contentView);
                }];
            }
        }
        
        tempItem = tempView;
    }];
    
    return contentView;
}

- (UIScrollView *)vScrollView {
    if (!_vScrollView) {
        _vScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _vScrollView.contentInsetAdjustmentBehavior =  UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _vScrollView;
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLab.textColor = [UIColor whiteColor];
        _tipLab.font = [UIFont boldSystemFontOfSize:18];
        _tipLab.numberOfLines = 0;
        _tipLab.text = [[MXAPPLanguage language] languageValue:@"certification_tip"];
    }
    
    return _tipLab;
}

- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_top_img"]];
    }
    
    return _topImgView;
}

- (MXAPPProductInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[MXAPPProductInfoView alloc] initWithFrame:CGRectZero];
    }
    
    return _infoView;
}

- (MXAPPProcessBar *)processBar {
    if (!_processBar) {
        _processBar = [[MXAPPProcessBar alloc] initWithFrame:CGRectZero];
    }
    
    return _processBar;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _contentView;
}

- (UIButton *)agreeBtn {
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setImage:[UIImage imageNamed:@"login_protocol_normal"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"login_protocol_sel"] forState:UIControlStateSelected];
        _agreeBtn.selected = YES;
        _agreeBtn.hidden = YES;
    }
    
    return _agreeBtn;
}

- (UIButton *)protocolBtn {
    if (!_protocolBtn) {
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _protocolBtn.hidden = YES;
    }
    
    return _protocolBtn;
}

- (MXAPPLoadingButton *)applyBtn {
    if (!_applyBtn) {
        _applyBtn = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"certification_loan"] radius:12];
    }
    
    return _applyBtn;
}

@end
