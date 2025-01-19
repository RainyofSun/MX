//
//  MXAPPOrderViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/2.
//

#import "MXAPPOrderViewController.h"
#import "MXAPPOrderContentView.h"

@interface MXAPPOrderViewController ()

@property (nonatomic, strong) UIImageView *textImgView;
@property (nonatomic, strong) UIImageView *orderImgView;
@property (nonatomic, strong) MXAPPOrderContentView *contentView;

@end

@implementation MXAPPOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self layoutOrderSubViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.contentView refreshOrder];
}

- (void)setupUI {
    self.title = [[MXAPPLanguage language] languageValue:@"order_nav_title"];
    [self resetGradientColors:@[[UIColor colorWithHexString:@"#F7D376"], [UIColor colorWithHexString:@"#F6AB9D"]]];
    [self.view addSubview:self.textImgView];
    [self.view addSubview:self.orderImgView];
    [self.view addSubview:self.contentView];
    
    WeakSelf;
    self.contentView.GotoHomeBlock = ^{
        weakSelf.tabBarController.selectedIndex = 0;
    };
}

- (void)layoutOrderSubViews {
    [self.textImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PADDING_UNIT * 4);
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight + PADDING_UNIT * 3.5);
    }];
    
    [self.orderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-PADDING_UNIT * 3.5);
        make.top.mas_equalTo(self.view).offset([UIDevice currentDevice].app_navigationBarAndStatusBarHeight + PADDING_UNIT * 1.5);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.orderImgView.mas_bottom).offset(PADDING_UNIT * 6);
    }];
}

- (UIImageView *)textImgView {
    if (!_textImgView) {
        NSString *name = [MXUserDefaultCache readLanguageCodeFromCache] == English ? @"order_top_text_img" : @"order_top_text_img_es";
        _textImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    }
    
    return _textImgView;
}

- (UIImageView *)orderImgView {
    if (!_orderImgView) {
        _orderImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_top_img"]];
    }
    
    return _orderImgView;
}

- (MXAPPOrderContentView *)contentView {
    if (!_contentView) {
        _contentView = [[MXAPPOrderContentView alloc] initWithFrame:CGRectZero];
    }
    
    return _contentView;
}

@end
