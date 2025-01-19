//
//  MXCacheKeyHeader.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#ifndef MXCacheKeyHeader_h
#define MXCacheKeyHeader_h

/// 是否首次安装
static NSString * const app_first_install_key = @"app_first_install_key";
/// 保存登录信息
static NSString * const cache_login_info_key = @"cache_login_info_key";
/// 多语言
static NSString * const language_code_key = @"language_code_key";
/// 今天是否展示过弹窗
static NSString * const show_location_alert_today = @"show_location_alert_today";

#endif /* MXCacheKeyHeader_h */
