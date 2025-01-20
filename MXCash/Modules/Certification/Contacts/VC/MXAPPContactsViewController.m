//
//  MXAPPContactsViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/15.
//

#import "MXAPPContactsViewController.h"
#import "MXAPPContactsModel.h"
#import "MXAPPContactsItem.h"
#import "MXAPPSingleChoiseView.h"
#import "LJContactManager.h"
#import "LJPerson.h"

@interface MXAPPContactsViewController ()<APPContactsItemProtocol>

@property (nonatomic, assign) CGFloat process;

@property (nonatomic, strong) UIScrollView *vScrollView;
@property (nonatomic, strong) MXAPPProcessBar *processBar;
@property (nonatomic, strong) MXAPPLoadingButton *saveBtn;

@property (nonatomic, strong) NSMutableArray <MXAPPEmergencyPersonModel *>*personModel;
@property (nonatomic, strong) NSDateFormatter *timeFormater;
@property (nonatomic, copy) NSString *navTitle;

@end

@implementation MXAPPContactsViewController

- (instancetype)initWithCertificationProcess:(CGFloat)process citificationTitle:(nonnull NSString *)title {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.process = process;
        self.navTitle = title;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self layoutInfoViews];
}

- (void)netRequest {
    if ([NSString isEmptyString:[MXGlobal global].productIDNumber]) {
        return;
    }
    
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/corsair" params:@{@"tin": [MXGlobal global].productIDNumber} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [weakSelf.vScrollView refresh:NO];
        MXAPPContactsModel *infoModel = [MXAPPContactsModel modelWithDictionary:responseObject.jsonDict];
        [weakSelf buildContactInfoViews:infoModel.titles];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [weakSelf.vScrollView refresh:NO];
    }];
}

- (void)buildContactInfoViews:(NSArray <MXAPPContactsPeopleModel *>*)modelSource {
    __block MXAPPContactsItem *topItem = nil;
    
    WeakSelf;
    [modelSource enumerateObjectsUsingBlock:^(MXAPPContactsPeopleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MXAPPContactsItem *tempItem = [[MXAPPContactsItem alloc] initWithFrame:CGRectZero];
        tempItem.contactDelegate = weakSelf;
        [tempItem reloadContactsItemWithModel:obj];
        tempItem.tag = 1000 + idx;
        [weakSelf.vScrollView addSubview:tempItem];
        // 保存联系人信息
        [weakSelf saveEmergencyPersonInfo:tempItem.tag userName:obj.robin userPhone:obj.repeated relationship:obj.feat];
        
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
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/noted" params:@{@"tin": [MXGlobal global].productIDNumber, @"gibson": self.personModel.modelToJSONString} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [sender stopAnimation];
        // 埋点
        [MXAPPBuryReport riskControlReport:APP_Contacts beginTime:weakSelf.buryBeginTime endTime:[NSDate timeStamp] orderNumber:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [sender stopAnimation];
    }];
}

- (void)saveEmergencyPersonInfo:(NSInteger)tag userName:(NSString *)userName userPhone:(NSString *)phone relationship:(NSString * _Nullable)relation {
    
    __block NSInteger index = -1;
    [self.personModel enumerateObjectsUsingBlock:^(MXAPPEmergencyPersonModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.personTag == tag) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index >= 0) {
        self.personModel[index].personTag = tag;
        if (![NSString isEmptyString:userName]) {
            self.personModel[index].robin = userName;
        }
        
        if (![NSString isEmptyString:phone]) {
            self.personModel[index].repeated = phone;
        }
        
        if (![NSString isEmptyString:relation]) {
            self.personModel[index].feat = relation;
        }
    } else {
        MXAPPEmergencyPersonModel *personModel = [[MXAPPEmergencyPersonModel alloc] init];
        personModel.personTag = tag;
        if (![NSString isEmptyString:userName]) {
            personModel.robin = userName;
        }
        
        if (![NSString isEmptyString:phone]) {
            personModel.repeated = phone;
        }
        
        if (![NSString isEmptyString:relation]) {
            personModel.feat = relation;
        }

        [self.personModel addObject:personModel];
    }
}

#pragma mark - APPContactsItemProtocol
- (void)clickContactsItem:(MXAPPContactsItem *)item isRelationShip:(BOOL)relationShip {
    if (relationShip) {
        MXAPPSingleChoiseView *singleView = [[MXAPPSingleChoiseView alloc] initWithFrame:self.view.bounds];
        [singleView reloadSource:item.relationModels];
        [self.view addSubview:singleView];
        [singleView popAnimation];
        WeakSelf;
        singleView.clickConfirmBlock = ^(MXAPPLoadingButton * _Nonnull sender, MXAPPPopBaseView * _Nonnull pView) {
            MXAPPSingleChoiseView *sView = (MXAPPSingleChoiseView *)pView;
            [weakSelf saveEmergencyPersonInfo:item.tag userName:nil userPhone:nil relationship:[NSString stringWithFormat:@"%ld", sView.selectModel.sites]];
            [item reloadInputValue:nil relationShip:sView.selectModel.robin];
            [pView dismissAnimation];
        };
    } else {
        WeakSelf;
        [[LJContactManager sharedInstance] requestAddressBookAuthorization:^(BOOL authorization) {
            if (!authorization) {
                
                [weakSelf showSystemStyleSettingAlert:[[MXAPPLanguage language] languageValue:@"alert_addressbook"] okTitle:nil cancelTitle:nil];
                return;
            }
            
            [weakSelf fetchAllContacts];
            [[LJContactManager sharedInstance] selectContactAtController:weakSelf complection:^(NSString *name, NSString *phone) {
                [item reloadInputValue:[NSString stringWithFormat:@"%@-%@", name, phone] relationShip:nil];
                [weakSelf saveEmergencyPersonInfo:item.tag userName:name userPhone:phone relationship:nil];
            }];
        }];
    }
}

- (void)fetchAllContacts {
    [[LJContactManager sharedInstance] accessContactsComplection:^(BOOL succeed, NSArray<LJPerson *> *contacts) {
        if (!succeed) {
            return;
        }
        
        WeakSelf;
        NSMutableArray <MXAPPReportAllContactsModel *>*personArray = [NSMutableArray array];
        [contacts enumerateObjectsUsingBlock:^(LJPerson * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MXAPPReportAllContactsModel *pModel = [[MXAPPReportAllContactsModel alloc] init];
            NSMutableArray *phoneArray = [NSMutableArray array];
            for (LJPhone *phone in obj.phones) {
                if (phone.phone.length) {
                    [phoneArray addObject:phone.phone];
                }
            }
            pModel.edward = [phoneArray componentsJoinedByString:@","];
            pModel.soccer = [weakSelf.timeFormater stringFromDate:obj.modificationDate];
            pModel.wnba = [weakSelf.timeFormater stringFromDate:obj.creationDate];
            pModel.uncasville = obj.note;
            pModel.etymology = [weakSelf.timeFormater stringFromDate:obj.birthday.brithdayDate];
            pModel.currently = obj.emails.firstObject.email;
            pModel.robin = obj.fullName;
            
            [personArray addObject:pModel];
        }];
        NSString *jsonStr = [personArray modelToJSONString];
        if ([NSString isEmptyString:jsonStr]) {
            return;
        }
        
#if DEBUG
        jsonStr = @"[{\"reinhard\":\"13303029382\",\"jres\":\"王XX\"}]";
#endif
        [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/connecticutie" params:@{@"gibson": jsonStr} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
            
        }];
    }];
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

- (NSMutableArray<MXAPPEmergencyPersonModel *> *)personModel {
    if (!_personModel) {
        _personModel = [NSMutableArray array];
    }
    
    return _personModel;
}

- (NSDateFormatter *)timeFormater {
    if (!_timeFormater) {
        _timeFormater = [[NSDateFormatter alloc] init];
        _timeFormater.dateFormat = @"yyyy-MM-dd";
    }
    
    return _timeFormater;
}

@end
