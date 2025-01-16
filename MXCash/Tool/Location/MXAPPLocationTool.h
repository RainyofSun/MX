//
//  MXAPPLocationTool.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/3.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPLocationTool : NSObject

@property (nonatomic, strong) CLPlacemark *placeMark;
@property (nonatomic, strong) CLLocation *location;

+ (instancetype)location;
- (void)startLocation;
- (void)stopLocation;
- (void)requestLocation;

@end

NS_ASSUME_NONNULL_END
