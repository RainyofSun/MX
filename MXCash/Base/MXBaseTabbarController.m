//
//  MXBaseTabbarController.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import "MXBaseTabbarController.h"
#import "MXBaseNavigationController.h"
#import "MXAPPLoginViewController.h"
#import "MXCustomTabbar.h"
#import "MXGlobal.h"

@interface MXBaseTabbarController ()<APPCustomTabbarProtocol>

@property (nonatomic, strong) MXCustomTabbar *tabbar;

@end

@implementation MXBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAPP) name:(NSNotificationName)APP_LOGIN_EXPIRED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:(NSNotificationName)APP_LOGIN_SUCCESS_NOTIFICATION object:nil];
    self.selectedIndex = 0;    
}

- (void)setupUI {
    [self setValue:self.tabbar forKey:@"tabBar"];
    [self.tabbar setTabbarWithTitles:@[] barItemImages:@[@"tab_home", @"tab_order", @"tab_mine"] barSelectedImgages:@[@"tab_home_selected", @"tab_order_selected", @"tab_mine_selected"]];
    self.tabbar.barDelegate = self;
    NSArray <NSString *>* classArray = @[@"MXAPPHomeViewController", @"MXAPPOrderViewController", @"MXAPPMineViewController"];
    NSMutableArray <MXBaseNavigationController*>* vcArray = [NSMutableArray arrayWithCapacity:classArray.count];
    [classArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id cls = [[NSClassFromString(obj) alloc] init];
        if ([cls isKindOfClass:[UIViewController class]]) {
            UIViewController *tempVC = (UIViewController *)cls;
            [vcArray addObject: [[MXBaseNavigationController alloc] initWithRootViewController:tempVC]];
        }
    }];
    
    self.viewControllers = vcArray;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self.tabbar selectedTabbarItem:selectedIndex];
    [super setSelectedIndex:selectedIndex];
}

#pragma mark - APPCustomTabbarProtocol
- (BOOL)canSelected:(NSInteger)shouldSelectedIndex {
    if (shouldSelectedIndex >= self.viewControllers.count) {
        return NO;
    }
    
    MXBaseNavigationController *navController = self.viewControllers[shouldSelectedIndex];
    if ([@[@"MXAPPOrderViewController", @"MXAPPMineViewController"] containsObject:[navController.topViewController className]] && [MXGlobal global].isLoginOut) {
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSNotificationName)APP_LOGIN_EXPIRED_NOTIFICATION object:nil];
        return NO;
    }
    
    return YES;
}

- (void)didSelectedItem:(MXCustomTabbar *)bar item:(UIButton *)item selectedIndex:(NSInteger)index {
    self.selectedIndex = index;
}

- (void)loginAPP {
    WeakSelf;
    dispatch_async_on_main_queue(^{
        self.selectedIndex = 0;
        MXBaseNavigationController *navController = [[MXBaseNavigationController alloc] initWithRootViewController:[[MXAPPLoginViewController alloc] init]];
        navController.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakSelf presentViewController:navController animated:true completion:nil];
    });
}

- (void)loginSuccess {
    dispatch_async_on_main_queue(^{
        if ([MXGlobal global].isLoginOut) {
            self.selectedIndex = 0;
        }
    });
}

#pragma mark - setter
- (MXCustomTabbar *)tabbar {
    if (!_tabbar) {
        _tabbar = [[MXCustomTabbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [[UIDevice currentDevice] app_tabbarAndSafeAreaHeight])];
    }
    return _tabbar;
}

@end
