//
//  MXAPPTimerButton.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/5.
//

#import "MXAPPTimerButton.h"

@interface MXAPPTimerButton ()

@property (nonatomic, strong) MXAPPGradientView *gradientView;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

@end

@implementation MXAPPTimerButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    DDLogDebug(@"%@", NSStringFromClass([self class]));
}

- (void)startTimer {
    if (_timer == nil) {
        WeakSelf;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            dispatch_async_on_main_queue(^{
                if (weakSelf.time <= 0) {
                    [weakSelf.timer invalidate];
                    weakSelf.timer = nil;
                    weakSelf.timeLab.text = [[MXAPPLanguage language] languageValue:@"login_code_btn"];
                    weakSelf.gradientView.hidden = YES;
                    [weakSelf initData];
                } else {
                    weakSelf.timeLab.text = [NSString stringWithFormat:@"%lds", (long)weakSelf.time];
                    weakSelf.time -= 1;
                    weakSelf.gradientView.hidden = NO;
                }
            });
        } repeats:YES];
    }
}

- (void)stopTimer {
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
}

- (void)timerMethod:(NSTimer *)timer {
    WeakSelf;
    dispatch_async_on_main_queue(^{
        if (weakSelf.time <= 0) {
            [weakSelf.timer invalidate];
            weakSelf.timeLab.text = [[MXAPPLanguage language] languageValue:@"login_code_btn"];
            weakSelf.gradientView.hidden = YES;
            [weakSelf initData];
        } else {
            weakSelf.timeLab.text = [NSString stringWithFormat:@"%lds", (long)weakSelf.time];
            weakSelf.time -= 1;
            weakSelf.gradientView.hidden = NO;
        }
    });
}

- (void)initData {
#if DEBUG
        self.time = 5;
#else
        self.time = 60;
#endif
}

- (void)setupUI {
    self.layer.cornerRadius = 7;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithHexString:@"#FF8D0E"];
    
    [self.gradientView buildGradientWithColors:@[ORANGE_COLOR_F7D376,PINK_COLOR_F6AB9D] gradientStyle:LeftTopToRightBottom];
    self.timeLab.text = [[MXAPPLanguage language] languageValue:@"login_code_btn"];
    
    [self addSubview:self.gradientView];
    [self addSubview:self.timeLab];
    
    [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 4.5);
        make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4.5);
        make.top.mas_equalTo(self).offset(PADDING_UNIT * 2.5);
        make.bottom.mas_equalTo(self).offset(-PADDING_UNIT * 2.5);
        make.width.mas_greaterThanOrEqualTo(80);
        make.height.mas_equalTo(17);
    }];
}

#pragma mark - setter
- (MXAPPGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[MXAPPGradientView alloc] init];
        _gradientView.hidden = YES;
    }
    return _gradientView;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}

@end
