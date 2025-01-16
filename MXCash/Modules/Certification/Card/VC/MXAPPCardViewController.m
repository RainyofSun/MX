//
//  MXAPPCardViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPCardViewController.h"
#import "MXAPPCardTopView.h"
#import "MXAPPCardItem.h"
#import "MXAPPCardModel.h"
#import "MXAPPCardFrontPopView.h"
#import "MXAPPCardFacePopView.h"
#import "MXAPPUserIDCardInfo.h"
#import "MXAPPUserInfoPopView.h"

@interface MXAPPCardViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIScrollView *vScrollView;
@property (nonatomic, strong) MXAPPCardTopView *topView;
@property (nonatomic, strong) MXAPPLoadingButton *saveBtn;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) MXAPPCardItem *frontItem;
@property (nonatomic, strong) MXAPPCardItem *backItem;

@property (nonatomic, assign) CGFloat process;
@property (nonatomic, assign) BOOL isFace;
@property (nonatomic, strong) MXAPPCardModel *cardModel;

@end

@implementation MXAPPCardViewController

- (instancetype)initWithCertificationProcess:(CGFloat)process {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.process = process;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self layoutCardViews];
    [self netRequest];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.contentView cutViewRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:20];
}

- (void)netRequest {
    if ([NSString isEmptyString:[MXGlobal global].productIDNumber]) {
        return;
    }
    
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/ives" params:@{@"tin":[MXGlobal global].productIDNumber} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        MXAPPCardModel *cardModel = [MXAPPCardModel modelWithDictionary:responseObject.jsonDict];
        weakSelf.cardModel = cardModel;
        [weakSelf.frontItem updateCardItemTitle:cardModel.id_front_msg cardImg:cardModel.surprises.figures];
        [weakSelf.backItem updateCardItemTitle:cardModel.face_msg cardImg:cardModel.father.figures];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

- (void)imageUploadRequest:(NSString *)filePath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        DDLogError(@"ERROR = 本地没有图片 -------------");
        return;
    }
    [self.view makeToastActivity:CSToastPositionCenter];
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Upload reqesutUrl:@"secondary/edward" params:@{@"sites": (self.isFace ? @"10" : @"11"), @"prestigiousStates": [NSString stringWithFormat:@"File$%@",filePath]} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [weakSelf.view hideToastActivity];
        if (weakSelf.isFace) {
            // 埋点
            [MXAPPBuryReport riskControlReport:APP_Face beginTime:weakSelf.buryBeginTime endTime:[NSDate timeStamp] orderNumber:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            MXAPPUserIDCardInfo *cardInfoModel = [MXAPPUserIDCardInfo modelWithDictionary:responseObject.jsonDict];
            if (cardInfoModel.biennially) {
                MXAPPUserInfoPopView *popView = [[MXAPPUserInfoPopView alloc] initWithFrame:weakSelf.view.bounds];
                [popView reloadUserinfoPop:cardInfoModel];
                [weakSelf.view addSubview:popView];
                [popView popAnimation];
                popView.clickConfirmBlock = ^(MXAPPLoadingButton * _Nonnull sender, MXAPPPopBaseView * _Nonnull pView) {
                    MXAPPUserInfoPopView *infoView = (MXAPPUserInfoPopView *)pView;
                    [sender startAnimation];
                    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/composer" params:@{@"robin": infoView.userName, @"sites": @"11", @"coat": infoView.idNumber, @"etymology": infoView.birthday} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
                        [sender stopAnimation];
                        [pView dismissAnimation];
                        // 埋点
                        [MXAPPBuryReport riskControlReport:APP_TakingCardPhoto beginTime:weakSelf.buryBeginTime endTime:[NSDate timeStamp] orderNumber:nil];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
                        [sender stopAnimation];
                    }];
                };
            } else {
                // 埋点
                [MXAPPBuryReport riskControlReport:APP_TakingCardPhoto beginTime:weakSelf.buryBeginTime endTime:[NSDate timeStamp] orderNumber:nil];
            }
            
            [weakSelf.frontItem updateCardItemTitle:nil cardImg:cardInfoModel.figures];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [weakSelf.view hideToastActivity];
    }];
}

- (void)clickCardItem:(MXAPPCardItem *)sender {
//    NSDictionary *dict = @{@"walter":@"CONTRERAS ROJAS MARICELA",@"alumnus":@"CORM770627MDFNJR01",@"rivalry":@"M",@"etymology":@"",@"figures":@"http://mx01-dc.oss-us-west-1.aliyuncs.com/face/id_card_front/123456789620250115050732_gxysu0nt03.restigiousStates?OSSAccessKeyId=LTAI5tRTpHKkkb8p8uxmiXMp&Expires=1926155252&Signature=f%2BcsJH8vCTSkeMLPKE%2BMEUgtV74%3D",@"crimson":@"",@"bulldogs":@"",@"biennially":@"1"};
//    MXAPPUserIDCardInfo *cardInfoModel = [MXAPPUserIDCardInfo modelWithDictionary:dict];
//    MXAPPUserInfoPopView *popView = [[MXAPPUserInfoPopView alloc] initWithFrame:self.view.bounds];
//        [popView reloadUserinfoPop:cardInfoModel];
//        [self.view addSubview:popView];
//        [popView popAnimation];
//        popView.clickConfirmBlock = ^(MXAPPLoadingButton * _Nonnull sender, MXAPPPopBaseView * _Nonnull pView) {
//            MXAPPUserInfoPopView *infoView = (MXAPPUserInfoPopView *)pView;
//            [sender startAnimation];
//            [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/composer" params:@{@"robin": infoView.userName, @"sites": @"11", @"coat": infoView.idNumber, @"etymology": infoView.birthday} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
//                [sender stopAnimation];
//                [pView dismissAnimation];
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
//                [sender stopAnimation];
//            }];
//        };
//    return;
    self.isFace = [sender isEqual: self.backItem];
    self.buryBeginTime = [NSDate timeStamp];
    if (self.isFace) {
        if (!self.cardModel.surprises.ssn) {
            [self.view makeToast:[[MXAPPLanguage language] languageValue:@"alert_id_certification"]];
            return;
        }
        if (self.cardModel.father.ssn) {
            return;
        }
        MXAPPCardFacePopView *popView = [[MXAPPCardFacePopView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:popView];
        [popView popAnimation];
        WeakSelf;
        popView.clickConfirmBlock = ^(MXAPPLoadingButton * _Nonnull sender, MXAPPPopBaseView * _Nonnull popView) {
            [weakSelf takePhotoWithCamera:weakSelf.isFace];
            [popView dismissAnimation];
        };
    } else {
        if (self.cardModel.surprises.ssn) {
            return;
        }
        MXAPPCardFrontPopView *popView = [[MXAPPCardFrontPopView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:popView];
        [popView popAnimation];
        WeakSelf;
        popView.clickConfirmBlock = ^(MXAPPLoadingButton * _Nonnull sender, MXAPPPopBaseView * _Nonnull popView) {
            [weakSelf takePhotoWithCamera:weakSelf.isFace];
            [popView dismissAnimation];
        };
    }
}

- (void)clickNext:(MXAPPLoadingButton *)sender {
    if (!self.cardModel.surprises.ssn) {
        [self clickCardItem:self.frontItem];
        return;
    }
    
    if (!self.cardModel.father.ssn) {
        [self clickCardItem:self.backItem];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *originalImg = info[UIImagePickerControllerOriginalImage];
    NSData *compress_img_data = [UIImage compressImageQuality:originalImg toSpecifyByte:1024 * 1024];
    NSString *filePath = [[MXGlobal global] saveImagePath:(self.isFace ? @"imageFace" : @"imageCard")];
    [compress_img_data writeToURL:[NSURL fileURLWithPath:filePath] atomically:YES];
    [self imageUploadRequest:filePath];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)takePhotoWithCamera:(BOOL)isFront {
    WeakSelf;
    [[MXAuthorizationTool authorization] requestCameraAuthrization:^(BOOL status) {
        if (!status) {
            [weakSelf showSystemStyleSettingAlert:[[MXAPPLanguage language] languageValue:@"alert_camera"] okTitle:nil cancelTitle:nil];
            return;
        }
        
        dispatch_async_on_main_queue(^{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *pickController = [[UIImagePickerController alloc] init];
                pickController.delegate = weakSelf;
                pickController.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickController.allowsEditing = false;
                pickController.cameraDevice = isFront ? UIImagePickerControllerCameraDeviceFront : UIImagePickerControllerCameraDeviceRear;
                [weakSelf.navigationController presentViewController:pickController animated:YES completion:nil];
            }
        });
    }];
}

- (void)setupUI {
    
    self.title = [[MXAPPLanguage language] languageValue:@"certification_id_nav_title"];
    [self.topView updateCertificationProcess:self.process];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.frontItem addTarget:self action:@selector(clickCardItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.backItem addTarget:self action:@selector(clickCardItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveBtn addTarget:self action:@selector(clickNext:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.vScrollView];
    [self.vScrollView addSubview:self.topView];
    [self.vScrollView addSubview:self.contentView];
    [self.contentView addSubview:self.frontItem];
    [self.contentView addSubview:self.backItem];
    [self.view addSubview:self.saveBtn];
}

- (void)layoutCardViews {
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
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.vScrollView).offset(PADDING_UNIT);
        make.left.width.mas_equalTo(self.vScrollView);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.mas_equalTo(self.vScrollView);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(-PADDING_UNIT * 23);
        make.height.mas_greaterThanOrEqualTo(self.view).multipliedBy(0.4);
    }];
    
    [self.frontItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT * 4);
    }];
    
    [self.backItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.frontItem.mas_bottom).offset(PADDING_UNIT * 4);
        make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 2);
    }];
}

- (UIScrollView *)vScrollView {
    if (!_vScrollView) {
        _vScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    }
    
    return _vScrollView;
}

- (MXAPPCardTopView *)topView {
    if (!_topView) {
        _topView = [[MXAPPCardTopView alloc] initWithFrame:CGRectZero];
    }
    
    return _topView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return _contentView;
}

- (MXAPPCardItem *)frontItem {
    if (!_frontItem) {
        _frontItem = [[MXAPPCardItem alloc] initWithFrame:CGRectZero isFront:YES];
    }
    
    return _frontItem;
}

- (MXAPPCardItem *)backItem {
    if (!_backItem) {
        _backItem = [[MXAPPCardItem alloc] initWithFrame:CGRectZero isFront:NO];
    }
    
    return _backItem;
}

- (MXAPPLoadingButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"certification_submit"] radius:12];
    }
    
    return _saveBtn;
}

@end
