//
//  MXBaseViewController.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import "MXBaseViewController.h"
#import "MXAPPLocationTool.h"

@interface MXBaseViewController ()

@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong, readwrite) MXAPPGradientView *gradientView;

@end

@implementation MXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_interactivePopDisabled = NO;
    self.fd_prefersNavigationBarHidden = NO;
    self.buryBeginTime = [NSDate timeStamp];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFF5E4"];
    [self.view addSubview:self.gradientView];
    [self.view addSubview:self.topImgView];
}

- (void)dealloc {
    DDLogDebug(@"%s -- %@", __func__, NSStringFromClass(self.class));
}

- (void)topImage:(NSString *)imageName {
    self.gradientView.hidden = YES;
    self.topImgView.image = [UIImage imageNamed:imageName];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
    }];
}

- (void)updateLocation {
    [[MXAPPLocationTool location] requestLocation];
}

- (void)hideBackgroundGradientView {
    self.gradientView.hidden = YES;
}

- (void)resetGradientColors:(NSArray<UIColor *> *)colors {
    [self.gradientView buildGradientWithColors:colors gradientStyle:LeftToRight];
}

- (MXAPPGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[MXAPPGradientView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight * 0.31)];
        [_gradientView buildGradientWithColors:@[[UIColor colorWithHexString:@"#FFA803"], [UIColor colorWithHexString:@"#FF8D0E"]] gradientStyle:LeftToRight];
    }
    
    return _gradientView;
}

- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] init];
    }
    return _topImgView;
}

@end
