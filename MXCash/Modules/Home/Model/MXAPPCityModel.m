//
//  MXAPPCityModel.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import "MXAPPCityModel.h"

@implementation MXCityItem



@end

@implementation MXAPPCityModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"harvard" : [MXCityItem class]};
}

+ (void)writeCityJsonToFile:(NSString *)fileContent {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[MXGlobal global].cityPath]) {
        DDLogDebug(@"本地已存储城市列表 -----------");
        return;c
    }
    
    [[NSFileManager defaultManager] createFileAtPath:[MXGlobal global].cityPath contents:[fileContent dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}

+ (NSArray<MXAPPCityModel *> *)readCityJsonFormFile {
    if (![[NSFileManager defaultManager] fileExistsAtPath:[MXGlobal global].cityPath]) {
        return @[];
    }
    
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[MXGlobal global].cityPath]];
    NSArray<MXAPPCityModel *>*cityModels = [NSArray modelArrayWithClass:[MXAPPCityModel class] json:jsonData];
    return cityModels;
}

@end
