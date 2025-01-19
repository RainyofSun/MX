//
//  MXAPPQuestionViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPQuestionViewController.h"
#import "MXAPPQuestionHeaderView.h"
#import "MXAPPQuestionTableViewCell.h"
#import "MXAPPQuestionModel.h"

@interface MXAPPQuestionViewController ()<UITableViewDelegate, UITableViewDataSource, QuestionCellProtocol>

@property (nonatomic, assign) CGFloat process;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MXAPPLoadingButton *saveBtn;
@property (nonatomic, strong) NSArray<MXAPPQuestionModel *>* modelArray;
@property (nonatomic, strong) NSMutableDictionary *questionDict;

@end

@implementation MXAPPQuestionViewController

- (instancetype)initWithCertificationProcess:(CGFloat)process {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.process = process;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)netRequest {
    WeakSelf;
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/statuary" params:@{@"tin":[MXGlobal global].productIDNumber} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [weakSelf.tableView refresh:NO];
        weakSelf.modelArray = [NSArray modelArrayWithClass:[MXAPPQuestionModel class] json:responseObject.jsonDict[@"mantis"]];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [weakSelf.tableView refresh:NO];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXAPPQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MXAPPQuestionTableViewCell class]) forIndexPath:indexPath];
    cell.cellDelegate = self;
    [cell reloadQuestionCell:self.modelArray[indexPath.row] indexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MXAPPQuestionHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([MXAPPQuestionHeaderView class])];
    [view updateCertificationProcess:self.process];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 245;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

#pragma mark - QuestionCellProtocol
- (void)didSelectedChoise:(NSDictionary *)value cellIndex:(NSIndexPath *)index {
    self.modelArray[index.row].tartan = [NSString stringWithFormat:@"%@", value.allValues.firstObject];
    [self.questionDict addEntriesFromDictionary:value];
    DDLogDebug(@"///// ----- \n %@ ----", self.questionDict);
}

- (void)clickSaveButton:(MXAPPLoadingButton *)sender {
    if (self.questionDict.count == 0 || [NSString isEmptyString:[MXGlobal global].productIDNumber]) {
        return;
    }
    
    [sender startAnimation];
    WeakSelf;
    [self.questionDict setValue:[MXGlobal global].productIDNumber forKey:@"tin"];
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/statues" params:self.questionDict success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [sender stopAnimation];
        // 埋点
        [MXAPPBuryReport riskControlReport:APP_Questionnaire beginTime:weakSelf.buryBeginTime endTime:[NSDate timeStamp] orderNumber:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [sender stopAnimation];
    }];
}

- (void)setupUI {
    self.title = [[MXAPPLanguage language] languageValue:@"certification_question"];
    [self hideBackgroundGradientView];
    
    [self.saveBtn addTarget:self action:@selector(clickSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MXAPPQuestionTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MXAPPQuestionTableViewCell class])];
    [self.tableView registerClass:[MXAPPQuestionHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([MXAPPQuestionHeaderView class])];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.saveBtn];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    WeakSelf;
    [self.tableView addMJRefresh:NO refreshCall:^(BOOL refresh) {
        [weakSelf netRequest];
    }];
    
    [self.tableView refresh:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    
    return _tableView;
}

- (MXAPPLoadingButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [MXAPPLoadingButton buildNormalStyleButton:[[MXAPPLanguage language] languageValue:@"certification_submit"] radius:12];
    }
    
    return _saveBtn;
}

- (NSMutableDictionary *)questionDict {
    if (!_questionDict) {
        _questionDict = [NSMutableDictionary dictionary];
    }
    
    return _questionDict;
}

@end
