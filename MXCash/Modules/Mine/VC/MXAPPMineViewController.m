//
//  MXAPPMineViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/2.
//

#import "MXAPPMineViewController.h"
#import "MXAPPMineModel.h"
#import "MXAPPMineItemControl.h"

@interface MXAPPMineViewController ()

@property (nonatomic, strong) UIImageView *userImgView;
@property (nonatomic, strong) UILabel *userPhoneLab;
@property (nonatomic, strong) UILabel *unitLab;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *tipLab;

@end

@implementation MXAPPMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self mineNetRequest];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:APP_LOGIN_STATUS]) {
        MXLoginModel *loginModel = [change valueForKey:NSKeyValueChangeNewKey];
        if ([loginModel isEqual:[NSNull null]] || loginModel == nil) {
            self.userPhoneLab.text = @"";
        } else {
            self.userPhoneLab.text = loginModel.composer.maskPhoneNumber;
        }
    }
}

- (void)mineNetRequest {
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Get reqesutUrl:@"secondary/duck" params:nil success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        MXAPPMineModel *mineModel = [MXAPPMineModel modelWithDictionary:responseObject.jsonDict];
        if (weakSelf.bgView.subviews.count == 0) {
            [weakSelf buildMineCell:mineModel.seals];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        
    }];
}

- (void)buildMineCell:(NSArray <MXAPPMineItem *>*)items {
    NSArray <UIColor *>*colors = @[[UIColor colorWithHexString:@"#E5F9E0"], [UIColor colorWithHexString:@"#DAF0FE"],
                                   [UIColor colorWithHexString:@"#F2E7FF"], [UIColor colorWithHexString:@"#FDE6F9"],
                                   [UIColor colorWithHexString:@"#FFE1DE"], [UIColor colorWithHexString:@"#FFD39E"]];
    
    MXAPPMineItemControl *temp_top_item = nil;
    MXAPPMineItemControl *temp_left_item = nil;
    NSInteger row = items.count%2 == 0 ? items.count/2 : (items.count/2 + 1);
    CGFloat item_width = (ScreenWidth - 8 * 6)/3;
    
    NSInteger index = 0;
    for (int i = 0; i < row; i ++) {
        for (int j = 0; j < 3; j ++) {
            if (index >= items.count) {
                return;
            }
            MXAPPMineItem *infoModel = items[index];
            MXAPPMineItemControl *item = [[MXAPPMineItemControl alloc] initWithFrame:CGRectZero];
            [item setItemTitle:infoModel.coined andImage:infoModel.hero];
            item.jumpURL = infoModel.figures;
            item.backgroundColor = colors[index];
            item.layer.cornerRadius = 10;
            item.clipsToBounds = YES;
            [item addTarget:self action:@selector(clickMineItem:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.bgView addSubview:item];
            
            if (temp_top_item != nil) {
                if (temp_left_item != nil) {
                    if (index == items.count - 1) {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(temp_left_item.mas_right).offset(PADDING_UNIT * 1.5);
                            make.size.top.mas_equalTo(temp_left_item);
                            make.bottom.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 1.5);
                        }];
                    } else {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(temp_left_item.mas_right).offset(PADDING_UNIT * 1.5);
                            make.size.top.mas_equalTo(temp_left_item);
                        }];
                    }
                } else {
                    if (index == items.count - 1) {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(temp_top_item.mas_bottom).offset(PADDING_UNIT * 1.5);
                            make.size.left.mas_equalTo(temp_top_item);
                            make.bottom.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 1.5);
                        }];
                    } else {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(temp_top_item.mas_bottom).offset(PADDING_UNIT * 1.5);
                            make.size.left.mas_equalTo(temp_top_item);
                        }];
                    }
                }
            } else {
                if (temp_left_item != nil) {
                    if (index == items.count - 1) {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(temp_left_item.mas_right).offset(PADDING_UNIT * 1.5);
                            make.size.top.mas_equalTo(temp_left_item);
                            make.bottom.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 1.5);
                        }];
                    } else {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(temp_left_item.mas_right).offset(PADDING_UNIT * 1.5);
                            make.size.top.mas_equalTo(temp_left_item);
                        }];
                    }
                } else {
                    [item mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(self.bgView).offset(PADDING_UNIT * 1.5);
                        make.top.mas_equalTo(self.bgView).offset(PADDING_UNIT * 1.5);
                        make.size.mas_equalTo(CGSizeMake(item_width, 126));
                    }];
                }
            }
            
            if (j == 0) {
                temp_top_item = item;
            }
            if (j == 2) {
                temp_left_item = nil;
            } else {
                temp_left_item = item;
            }
            index ++;
        }
    }
}

- (void)clickMineItem:(MXAPPMineItemControl *)sender {
    if ([NSString isEmptyString:sender.jumpURL]) {
        return;
    }
    
    [[MXAPPRouting shared] pageRouter:sender.jumpURL backToRoot:YES targetVC:nil];
}

- (void)setupUI {
    [[MXGlobal global] addObserver:self forKeyPath:APP_LOGIN_STATUS options:NSKeyValueObservingOptionNew context:nil];
    [self topImage:@"mine_top_bg"];
    self.title = [[MXAPPLanguage language] languageValue:@"mine_nav_title"];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"mine_text_bottom"];
    attachment.bounds = CGRectMake(0, 3, attachment.image.size.width, attachment.image.size.height);
    NSAttributedString *attributeStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc] initWithString:[[MXAPPLanguage language] languageValue:@"mine_tip"] attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#999999"], NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:16]}];
    [textStr insertAttributedString:attributeStr atIndex:0];
    [textStr appendAttributedString:attributeStr];
    
    self.tipLab.attributedText = textStr;
    self.userPhoneLab.text = [MXGlobal global].loginModel.composer.maskPhoneNumber;
    
    [self.view addSubview:self.userImgView];
    [self.view addSubview:self.userPhoneLab];
    [self.view addSubview:self.unitLab];
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.tipLab];
    
    [self.userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(56, 56));
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 5);
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight + PADDING_UNIT * 4.5);
    }];
    
    [self.userPhoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.userImgView);
        make.left.mas_equalTo(self.userImgView.mas_right).offset(PADDING_UNIT * 3);
    }];
    
    [self.unitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 4);
        make.top.mas_equalTo(self.userImgView.mas_bottom).offset(PADDING_UNIT * 26);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.unitLab.mas_bottom).offset(PADDING_UNIT * 2.5);
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 3);
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 3);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-[UIDevice currentDevice].app_tabbarAndSafeAreaHeight - PADDING_UNIT * 4);
    }];
}

- (UIImageView *)userImgView {
    if (!_userImgView) {
        _userImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_header"]];
        _userImgView.layer.cornerRadius = 28;
        _userImgView.clipsToBounds = YES;
    }
    
    return _userImgView;
}

- (UILabel *)userPhoneLab {
    if (!_userPhoneLab) {
        _userPhoneLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _userPhoneLab.textColor = [UIColor colorWithHexString:@"#F2442D"];
        _userPhoneLab.font = [UIFont systemFontOfSize:16];
    }
    
    return _userPhoneLab;
}

- (UILabel *)unitLab {
    if (!_unitLab) {
        _unitLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _unitLab.textColor = BLACK_COLOR_333333;
        _unitLab.font = [UIFont systemFontOfSize:16];
        _unitLab.text = [[MXAPPLanguage language] languageValue:@"mine_service"];
    }
    
    return _unitLab;
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

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    return _tipLab;
}


@end
