//
//  MXAPPSingleChoiseView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/14.
//

#import "MXAPPSingleChoiseView.h"
#import <BRPickerView/BRTextPickerView.h>
#import "MXAPPQuestionModel.h"

@interface MXAPPSingleChoiseView ()

@property (nonatomic, strong) UIView *pickerBgView;
@property (nonatomic, strong) BRTextPickerView *pickView;

@property (nonatomic, strong, readwrite) MXAPPQuestionChoiseModel *selectModel;

@end

@implementation MXAPPSingleChoiseView

- (void)setupUI {
    [super setupUI];
    
    [self setPopBackgrooundImage:@"pop_time" popTitle:@"pop_card_certification3"];
    self.confirmTitle = [[MXAPPLanguage language] languageValue:@"pop_confirm_title"];
    
    [self.contentView addSubview:self.pickerBgView];
    [self.pickView addPickerToView:self.pickerBgView];
    [self.contentView addSubview:self.confirmBtn];
    WeakSelf;
    self.pickView.singleChangeBlock = ^(BRTextModel * _Nullable model, NSInteger index) {
        weakSelf.selectModel = [[MXAPPQuestionChoiseModel alloc] init];
        weakSelf.selectModel.sites = model.code.integerValue;
        weakSelf.selectModel.robin = model.text;
    };
    
    self.pickView.singleResultBlock = ^(BRTextModel * _Nullable model, NSInteger index) {
        weakSelf.selectModel = [[MXAPPQuestionChoiseModel alloc] init];
        weakSelf.selectModel.sites = model.code.integerValue;
        weakSelf.selectModel.robin = model.text;
    };
}

- (void)layoutPopViews {
    [super layoutPopViews];
    [self.pickerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT * 20);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - PADDING_UNIT * 16, 200));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 10);
        make.top.mas_equalTo(self.pickerBgView.mas_bottom).offset(PADDING_UNIT * 4);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 5);
    }];
}

- (void)clickConfirm {
    [super clickConfirm];
    self.pickView.doneBlock();
}

- (void)reloadSource:(NSArray<MXAPPQuestionChoiseModel *> *)models {
    NSMutableArray *array = [NSMutableArray array];
    [models enumerateObjectsUsingBlock:^(MXAPPQuestionChoiseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:@{@"code": @(obj.sites), @"text": obj.robin}];
    }];
    
    self.pickView.dataSourceArr = [NSArray br_modelArrayWithJson:array mapper:nil];
    [self.pickView reloadData];
}

- (UIView *)pickerBgView {
    if (!_pickerBgView) {
        _pickerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - PADDING_UNIT * 16, 200)];
    }
    
    return _pickerBgView;
}

- (BRTextPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[BRTextPickerView alloc] initWithPickerMode:BRTextPickerComponentSingle];
        BRPickerStyle *style = [[BRPickerStyle alloc] init];
        style.hiddenDoneBtn = YES;
        style.hiddenCancelBtn = YES;
        style.hiddenTitleLine = YES;
        style.pickerColor = [UIColor whiteColor];
        style.pickerTextColor = BLACK_COLOR_333333;
        style.pickerTextFont = [UIFont systemFontOfSize:14];
        style.selectRowColor = ORANGE_COLOR_F7D376;
        style.selectRowTextColor = [UIColor colorWithHexString:@"#FA6603"];
        style.pickerHeight = 250;
        style.selectRowRadius = 12;
        _pickView.pickerStyle = style;
    }
    
    return _pickView;
}

@end
