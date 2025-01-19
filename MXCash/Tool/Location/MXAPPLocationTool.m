//
//  MXAPPLocationTool.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/3.
//

#import "MXAPPLocationTool.h"
#import "MXAPPNetObserver.h"
#import "MXAuthorizationTool.h"

@interface MXAPPLocationTool ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MXAPPLocationTool

+ (instancetype)location {
    static MXAPPLocationTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tool == nil) {
            tool = [[MXAPPLocationTool alloc] init];
        }
    });
    
    return tool;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return self;
}

- (void)startLocation {
    if ([MXAuthorizationTool authorization].phoneOpenLocation) {
        CLAuthorizationStatus status = [self.locationManager authorizationStatus];
        if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
            [[UIDevice currentDevice].keyWindow.rootViewController showSystemStyleSettingAlert:[[MXAPPLanguage language] languageValue:@"alert_location"] okTitle:nil cancelTitle:nil];
            return;
        }
        
        [self.locationManager startUpdatingLocation];
    } else {
        if (![CLLocationManager locationServicesEnabled]) {
            [[UIDevice currentDevice].keyWindow.rootViewController showSystemStyleSettingAlert:[[MXAPPLanguage language] languageValue:@"alert_location"] okTitle:nil cancelTitle:nil];
            return;
        }
        
        if ([[MXAuthorizationTool authorization] locationAuthorization] == NotDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
}

- (void)stopLocation {
    [self.locationManager stopUpdatingLocation];
}

- (void)requestLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)geocoderInfoForLocation:(CLLocation *)location {
    if (![MXAPPNetObserver Observer].netWorkReachable) {
        return;
    }
    
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    WeakSelf;
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        weakSelf.placeMark = placemarks.firstObject;
        weakSelf.location = location;
    }];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败了 --- %@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.lastObject;
    if (location == nil) {
        return;
    }
    
    DDLogDebug(@"------ 埋点定位 -- %f - %f", location.coordinate.latitude, location.coordinate.longitude);
    [self geocoderInfoForLocation:location];
    [self.locationManager stopUpdatingLocation];
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

@end
