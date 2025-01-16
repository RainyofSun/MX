//
//  MXAPPUserTimePopView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/13.
//

#import "MXAPPUserTimePopView.h"
#import <BRPickerView/BRDatePickerView.h>

@interface MXAPPUserTimePopView ()

@property (nonatomic, strong) UILabel *dayLab;
@property (nonatomic, strong) UILabel *monthLab;
@property (nonatomic, strong) UILabel *yearLab;
@property (nonatomic, strong) UIView *pickBgView;
@property (nonatomic, strong) BRDatePickerView *pickerView;
@property (nonatomic, copy, readwrite) NSString *time;

@end

@implementation MXAPPUserTimePopView

- (void)setupUI {
    [super setupUI];
    
    [self setPopBackgrooundImage:@"pop_time" popTitle:@"pop_card_certification2"];
    self.confirmTitle = [[MXAPPLanguage language] languageValue:@"pop_confirm_title"];
    
    [self.contentView addSubview:self.dayLab];
    [self.contentView addSubview:self.monthLab];
    [self.contentView addSubview:self.yearLab];
    [self.contentView addSubview:self.pickBgView];
    [self.contentView addSubview:self.confirmBtn];
    [self.pickerView addPickerToView:self.pickBgView];
    
    WeakSelf;
    self.pickerView.resultBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        weakSelf.time = selectValue;
    };
    
    self.pickerView.changeBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        weakSelf.time = selectValue;
    };
}

- (void)layoutPopViews {
    [super layoutPopViews];
    
    [self.dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 7);
        make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT * 20);
    }];
    
    [self.monthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dayLab.mas_right).offset(PADDING_UNIT * 9);
        make.width.top.mas_equalTo(self.dayLab);
    }];
    
    [self.yearLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.monthLab.mas_right).offset(PADDING_UNIT * 9);
        make.width.top.mas_equalTo(self.monthLab);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 9);
    }];
    
    [self.pickBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dayLab);
        make.right.mas_equalTo(self.yearLab);
        make.top.mas_equalTo(self.dayLab.mas_bottom).offset(PADDING_UNIT * 6);
        make.height.mas_equalTo(250);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 10);
        make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 10);
        make.top.mas_equalTo(self.pickBgView.mas_bottom).offset(PADDING_UNIT * 4);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 5);
    }];
}

- (void)clickConfirm {
    self.pickerView.doneBlock();
}

- (UILabel *)dayLab {
    if (!_dayLab) {
        _dayLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _dayLab.textColor = BLACK_COLOR_333333;
        _dayLab.font = [UIFont boldSystemFontOfSize:16];
        _dayLab.text = [[MXAPPLanguage language] languageValue:@"pop_time_day"];
        _dayLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _dayLab;
}

- (UILabel *)monthLab {
    if (!_monthLab) {
        _monthLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _monthLab.textColor = BLACK_COLOR_333333;
        _monthLab.font = [UIFont boldSystemFontOfSize:16];
        _monthLab.text = [[MXAPPLanguage language] languageValue:@"pop_time_month"];
        _monthLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _monthLab;
}

- (UILabel *)yearLab {
    if (!_yearLab) {
        _yearLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _yearLab.textColor = BLACK_COLOR_333333;
        _yearLab.font = [UIFont boldSystemFontOfSize:16];
        _yearLab.text = [[MXAPPLanguage language] languageValue:@"pop_time_year"];
        _yearLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _yearLab;
}

- (UIView *)pickBgView {
    if (!_pickBgView) {
        _pickBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 240, 250)];
    }
    
    return _pickBgView;
}

- (BRDatePickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[BRDatePickerView alloc] initWithPickerMode:BRDatePickerModeYMD];
        _pickerView.minDate = [NSDate br_setYear:1949 month:3 day:12];
        _pickerView.maxDate = [NSDate now];
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
        style.language = @"en";
        _pickerView.pickerStyle = style;
    }
    
    return _pickerView;
}

@end
