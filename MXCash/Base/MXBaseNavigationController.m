//
//  MXBaseNavigationController.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import "MXBaseNavigationController.h"
#import "MXHideNavigationBarProtocol.h"

@interface MXBaseNavigationController ()<UINavigationControllerDelegate, UINavigationBarDelegate>

@end

@implementation MXBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
//    MXAPPGradientView *gradientView = [[MXAPPGradientView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [UIDevice currentDevice].app_navigationBarAndStatusBarHeight)];
//    [gradientView buildGradientWithColors:@[[UIColor colorWithHexString:@"#FFA803"], [UIColor colorWithHexString:@"#FF8D0E"]] gradientStyle:LeftToRight];
//    UIGraphicsBeginImageContextWithOptions(gradientView.bounds.size, YES, 0.0);
//    [gradientView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [self initNavigationAppearance];
}

- (void)initNavigationAppearance {
    [UINavigationBar appearance].barTintColor = [UIColor clearColor];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [self updateSystemNavigationBarAppearance:[UIColor colorWithHexString:@"#313131"] backColor:[UIColor colorWithHexString:@"#333333"]];
    [UINavigationBar appearance].shadowImage = [self barShadowImage];
}

- (UIImage *)barShadowImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ScreenWidth, 0.5), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [[UIColor clearColor] setFill];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    [super pushViewController:viewController animated:animated];
}

- (void)dealloc {
    DDLogDebug(@"%s--%@", __func__, NSStringFromClass(self.class));
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController conformsToProtocol:@protocol(MXHideNavigationBarProtocol)]) {
        [self setNavigationBarHidden:YES animated:YES];
    } else {
        [self setNavigationBarHidden:NO animated:YES];
    }
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if (self.viewControllers.count < navigationBar.items.count) {
        return  YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController *topVC = self.topViewController;
    
    if ([topVC respondsToSelector:@selector(currentViewControllerShouldPop)]) {
        shouldPop = [topVC currentViewControllerShouldPop];
    }
    
    if (shouldPop) {
        dispatch_async_on_main_queue(^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        [navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (0 < obj.alpha && obj.alpha < 1.0) {
                [UIView animateWithDuration:0.25 animations:^{
                    obj.alpha = 1.0;
                }];
            }
        }];
    }
    
    return NO;
}

@end
