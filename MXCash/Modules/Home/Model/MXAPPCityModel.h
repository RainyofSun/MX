//
//  MXAPPCityModel.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXCityItem : NSObject

@property (nonatomic, copy) NSString *robin;

@end

@interface MXAPPCityModel : NSObject<YYModel>

/// 省
@property (nonatomic, strong) NSString *nfl;
/// 市
@property (nonatomic, strong) NSArray <MXCityItem *>*harvard;

+ (void)writeCityJsonToFile:(NSString *)fileContent;
+ (NSArray <MXAPPCityModel *>*)readCityJsonFormFile;

@end

NS_ASSUME_NONNULL_END
