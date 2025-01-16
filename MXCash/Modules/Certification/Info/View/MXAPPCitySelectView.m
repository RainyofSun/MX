//
//  MXAPPCitySelectView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/15.
//

#import "MXAPPCitySelectView.h"
#import "MXAPPCityModel.h"

@interface MXAPPCityCell ()

@property (nonatomic, strong) MXAPPGradientView *gradientView;
@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation MXAPPCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.gradientView];
        [self.contentView addSubview:self.titleLab];
        
        [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 6);
            make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 6);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT);
            make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
        }];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.titleLab.textColor = selected ? ORANGE_COLOR_FA6603 : BLACK_COLOR_333333;
    self.gradientView.hidden = !selected;
}

- (void)setCity:(NSString *)city {
    self.titleLab.text = city;
}

- (MXAPPGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[MXAPPGradientView alloc] initWithFrame:CGRectZero];
        [_gradientView buildGradientWithColors:@[[UIColor colorWithHexString:@"#F7D376"], [UIColor colorWithHexString:@"#F6AB9D"]] gradientStyle:LeftTopToRightBottom];
        _gradientView.layer.cornerRadius = 8;
        _gradientView.clipsToBounds = YES;
        _gradientView.hidden = YES;
    }
    
    return _gradientView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = BLACK_COLOR_333333;
    }
    
    return _titleLab;
}

@end

@interface MXAPPCitySelectView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *cityBtn1;
@property (nonatomic, strong) UIButton *cityBtn2;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UIScrollView *hScrllView;
@property (nonatomic, strong) UITableView *leftTabView;
@property (nonatomic, strong) UITableView *midTabView;

@property (nonatomic, strong) NSMutableArray <NSString *> *cityModels1;
@property (nonatomic, strong) NSMutableArray <NSString *> *cityModels2;

@property (nonatomic, assign) BOOL selectAllCity;
@property (nonatomic, copy, readwrite) NSString *cityStr;
@property (nonatomic, strong) NSArray <MXAPPCityModel *>*total_citys;

@end

@implementation MXAPPCitySelectView

- (void)setupUI {
    [super setupUI];
    self.selectAllCity = NO;
    
    [self setPopBackgrooundImage:@"pop_location" popTitle:@"pop_card_certification4"];
    self.confirmTitle = [[MXAPPLanguage language] languageValue:@"pop_confirm_title"];
    
    [self.leftTabView registerClass:[MXAPPCityCell class] forCellReuseIdentifier:NSStringFromClass([MXAPPCityCell class])];
    [self.midTabView registerClass:[MXAPPCityCell class] forCellReuseIdentifier:NSStringFromClass([MXAPPCityCell class])];
    
    self.leftTabView.delegate = self;
    self.leftTabView.dataSource = self;
    self.midTabView.delegate = self;
    self.midTabView.dataSource = self;
    
    [self.cityBtn1 addTarget:self action:@selector(switchCityList:) forControlEvents:UIControlEventTouchUpInside];
    [self.cityBtn2 addTarget:self action:@selector(switchCityList:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.cityBtn1];
    [self.contentView addSubview:self.cityBtn2];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.hScrllView];
    [self.hScrllView addSubview:self.leftTabView];
    [self.hScrllView addSubview:self.midTabView];
    [self.contentView addSubview:self.confirmBtn];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[MXGlobal global].cityPath]) {
        self.total_citys = [MXAPPCityModel readCityJsonFormFile];
        [_total_citys enumerateObjectsUsingBlock:^(MXAPPCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cityModels1 addObject:obj.nfl];
        }];
        [self.leftTabView reloadData];
    } else {
        WeakSelf;
        [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"v3/certify/city-init" params:nil success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
            [MXAPPCityModel writeCityJsonToFile:responseObject.jsonArray.modelToJSONString];
            weakSelf.total_citys = [NSArray modelArrayWithClass:[MXAPPCityModel class] json:responseObject.jsonArray];
            [weakSelf.total_citys enumerateObjectsUsingBlock:^(MXAPPCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [weakSelf.cityModels1 addObject:obj.nfl];
            }];
            [weakSelf.leftTabView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
            
        }];
    }
}

- (void)layoutPopViews {
    [super layoutPopViews];
    
    [self.cityBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView).multipliedBy(0.8);
        make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT * 10);
    }];
    
    [self.cityBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView).multipliedBy(0.8);
        make.top.mas_equalTo(self.cityBtn1.mas_bottom).offset(PADDING_UNIT * 2);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.cityBtn2.mas_bottom).offset(PADDING_UNIT * 7);
    }];
    
    [self.hScrllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(PADDING_UNIT * 7);
        make.height.mas_equalTo(self).multipliedBy(0.3);
    }];
    
    [self.leftTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.left.mas_equalTo(self.hScrllView);
    }];
    
    [self.midTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTabView.mas_right);
        make.size.top.mas_equalTo(self.leftTabView);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 10);
        make.top.mas_equalTo(self.hScrllView.mas_bottom).offset(PADDING_UNIT * 4);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 5);
    }];
}

- (void)clickConfirmButton:(MXAPPLoadingButton *)sender {
    if (!self.selectAllCity) {
        [self makeToast:[[MXAPPLanguage language] languageValue:@"alert_address"]];
        return;
    }
    
    [super clickConfirmButton:sender];
}

- (void)switchCityList:(UIButton *)sender {
    [self.hScrllView setContentOffset:CGPointMake((ScreenWidth - PADDING_UNIT * 15) * (sender.tag - 1000), 0) animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTabView) {
        return self.cityModels1.count;
    } else if (tableView == self.midTabView) {
        return self.cityModels2.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXAPPCityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MXAPPCityCell class])];
    if (tableView == self.leftTabView) {
        [cell setCity:self.cityModels1[indexPath.row]];
    } else if (tableView == self.midTabView) {
        [cell setCity:self.cityModels2[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTabView) {
        [self.cityBtn1 setTitle:self.cityModels1[indexPath.row] forState:UIControlStateNormal];
        [self.cityBtn1 setTitleColor:BLACK_COLOR_333333 forState:UIControlStateNormal];
        [self.cityBtn2 setTitleColor:[UIColor colorWithHexString:@"#EC6634"] forState:UIControlStateNormal];
        [self.cityBtn2 setTitle:[[MXAPPLanguage language] languageValue:@"pop_city_choise"] forState:UIControlStateNormal];
        
        MXAPPCityModel *cityModel = self.total_citys[indexPath.row];
        [cityModel.harvard enumerateObjectsUsingBlock:^(MXCityItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cityModels2 addObject:obj.robin];
        }];
        [self.midTabView reloadData];
        [self switchCityList:self.cityBtn2];
        self.selectAllCity = NO;
        self.cityStr = self.cityBtn1.currentTitle;
    } else if (tableView == self.midTabView) {
        [self.cityBtn2 setTitle:self.cityModels2[indexPath.row] forState:UIControlStateNormal];
        [self.cityBtn2 setTitleColor:BLACK_COLOR_333333 forState:UIControlStateNormal];
        
        self.selectAllCity = YES;
        self.cityStr = [NSString stringWithFormat:@"%@ | %@", self.cityStr, self.cityBtn2.currentTitle];
    }
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:YES animated:YES];
}

- (UIButton *)cityBtn1 {
    if (!_cityBtn1) {
        _cityBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityBtn1 setTitle:[[MXAPPLanguage language] languageValue:@"pop_city_choise"] forState:UIControlStateNormal];
        [_cityBtn1 setTitleColor:[UIColor colorWithHexString:@"#EC6634"] forState:UIControlStateNormal];
        _cityBtn1.titleLabel.font = [UIFont systemFontOfSize:16];
        _cityBtn1.tag = 1000;
    }
    
    return _cityBtn1;
}

- (UIButton *)cityBtn2 {
    if (!_cityBtn2) {
        _cityBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityBtn2 setTitle:[[MXAPPLanguage language] languageValue:@"pop_city_choise"] forState:UIControlStateNormal];
        [_cityBtn2 setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _cityBtn2.titleLabel.font = [UIFont systemFontOfSize:16];
        _cityBtn2.tag = 1001;
    }
    
    return _cityBtn2;
}

- (UIImageView *)lineView {
    if (!_lineView) {
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_line_img"]];
    }
    
    return _lineView;
}

- (UIScrollView *)hScrllView {
    if (!_hScrllView) {
        _hScrllView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _hScrllView.scrollEnabled = NO;
        _hScrllView.contentSize = CGSizeMake((ScreenWidth - PADDING_UNIT * 15) * 3, 0);
        _hScrllView.pagingEnabled = YES;
    }
    
    return _hScrllView;
}

- (UITableView *)leftTabView {
    if (!_leftTabView) {
        _leftTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _leftTabView;
}

- (UITableView *)midTabView {
    if (!_midTabView) {
        _midTabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _midTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _midTabView;
}

- (NSMutableArray<NSString *> *)cityModels1 {
    if (!_cityModels1) {
        _cityModels1 = [NSMutableArray array];
    }
    
    return _cityModels1;
}

- (NSMutableArray<NSString *> *)cityModels2 {
    if (!_cityModels2) {
        _cityModels2 = [NSMutableArray array];
    }
    
    return _cityModels2;
}

@end
