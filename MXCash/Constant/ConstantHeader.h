//
//  ConstantHeader.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#ifndef ConstantHeader_h
#define ConstantHeader_h
#import <UIKit/UIKit.h>

#pragma mark - URL
#if DEBUG
static NSString * const BASE_URL = @"http://47.251.52.24:8287/exhibits";
#else
static NSString * const BASE_URL = @"http://47.251.52.24:8287/exhibits";
#endif

// TODO 要替换
#define Dynamic_Domain_URL   @"https://ph01-dc.oss-ap-southeast-6.aliyuncs.com/"
#define Dynamic_Domain_Path  @"pera-pilot/ppt.json"

#pragma mark - Frame
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define PADDING_UNIT    4

#pragma mark - color

#pragma mark - idfv key
#define APP_IDFV_KEY    @"APP_IDFV_KEY"

#pragma matk - 原生与H5页面对照
/// 设置页面
static NSString * const APP_SETTING_PATH = @"ac://ce.ssc.ash/dimensions";
/// 首页
static NSString * const APP_HOME_PATH = @"ac://ce.ssc.ash/themseleves";
/// 登录
static NSString * const APP_LOGIN_PATH = @"ac://ce.ssc.ash/large";
/// 订单
static NSString * const APP_ORDER_PATH = @"ac://ce.ssc.ash/jpour";
/// 产品详情
static NSString * const APP_PRODUCT_PATH = @"ac://ce.ssc.ash/dark";

#pragma mark - H5交互函数
/// 页面跳转
static NSString * const APP_PAGE_JUMP_METHOD = @"GovernmentAgo";
/// 关闭当前webview
static NSString * const APP_CLOSE_WEB_METHOD = @"UnionGold";
/// 带参数页面跳转
static NSString * const APP_PAGE_JUMP_PARAMS_METHOD = @"EuropeanThe";
/// 回到首页，并关闭当前页
static NSString * const APP_GO_HOME_METHOD = @"TheThe";
/// 回到个人中心，并关闭当前页
static NSString * const APP_GO_CENTER_METHOD = @"TheReside";
/// 跳转到登录页，并清空页面栈
static NSString * const APP_GO_LOGIN_METHOD = @"LowestBy";
/// 拨打电话号码
static NSString * const APP_CALL_METHOD = @"CensusFounded";
/// app store评分功能
static NSString * const APP_STORE_SOURCE_METHOD = @"SaybrookStructure";
/// 确认申请埋点调用方法
static NSString * const APP_CONFIRM_APPLY_METHOD = @"ByIn";

#pragma mark - 通知
/// 网络状态通知
static NSString * const APP_NET_CHANGE_NOTIFICATION = @"com.mx.notification.name.net.change";
/// 登录状态失效
static NSString * const APP_LOGIN_EXPIRED_NOTIFICATION = @"com.mx.notification.name.login.expired";

#pragma mark - Macro
#define WeakSelf  __weak typeof(self) weakSelf = self
#define StrongSelf  __strong typeof(self) strongSelf = weakSelf

#pragma mark - Color
#define ORANGE_COLOR_FF8D0E    [UIColor colorWithHexString:@"#FF8D0E"]
#define ORANGE_COLOR_FA6603    [UIColor colorWithHexString:@"#FA6603"]
#define ORANGE_COLOR_F7D376    [UIColor colorWithHexString:@"#F7D376"]
#define PINK_COLOR_F6AB9D    [UIColor colorWithHexString:@"#F6AB9D"]
#define BLACK_COLOR_333333     [UIColor colorWithHexString:@"#333333"]
#define BLACK_COLOR_666666     [UIColor colorWithHexString:@"#666666"]

#endif /* ConstantHeader_h */
