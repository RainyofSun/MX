//
//  MXAPPQuestionModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    Input,
    Choise,
    DataSelected,
    Tip,
    CitySelected
} ControlType;

@interface MXAPPQuestionChoiseModel : NSObject

/// 标题
@property (nonatomic, strong) NSString *robin;
/// 标题对应的Value
@property (nonatomic, assign) NSInteger sites;

@end

@interface MXAPPQuestionModel : NSObject<YYModel>
/// 标题
@property (nonatomic, strong) NSString *coined;
/// 预留字
@property (nonatomic, strong) NSString *freedom;
/// Key
@property (nonatomic, strong) NSString *nekita;
/// 组件类型
@property (nonatomic, strong) NSString *insect;
@property (nonatomic, assign, readonly) ControlType cType;
/// 键盘类型 1 为数字键盘
@property (nonatomic, assign) BOOL shad;
/// 可选项目
@property (nonatomic, strong) NSArray<MXAPPQuestionChoiseModel *> *fish;
/// 认证状态
@property (nonatomic, assign) BOOL ssn;
/// 返回的值
@property (nonatomic, strong) NSString *tartan;

@end

NS_ASSUME_NONNULL_END
