//
//  MXAPPMineModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPMineItem : NSObject

/// 跳转地址【重要】 返回的是http开头的，就跳转内置浏览器webview,如果返回的不是http开头的，而是我们自定义的scheme，就跳转我们定义的五个原生页面
@property (nonatomic, copy) NSString *figures;
/// 标题
@property (nonatomic, copy) NSString *coined;
/// 图标
@property (nonatomic, copy) NSString *hero;

@end

@interface MXAPPMineModel : NSObject<YYModel>

@property (nonatomic, strong) NSArray<MXAPPMineItem *>*seals;

@end

NS_ASSUME_NONNULL_END
