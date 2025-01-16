//
//  MXAuthorizationTool.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    NotDetermined,
    Restricted,
    Denied,
    Authorized,
    Limited,
    Disable
} MXAuthorizationStatus;

typedef enum : NSUInteger {
    AddOnly,
    ReadAndWrite,
} MXPhotoAccessLevel;

typedef enum : NSUInteger {
    WhenInUse,
    Always,
} MXLocationAuthLevel;

@interface MXAuthorizationTool : NSObject

@property (nonatomic, assign) BOOL phoneOpenLocation;

+ (instancetype)authorization;
- (MXAuthorizationStatus)locationAuthorization;
- (ATTrackingManagerAuthorizationStatus)ATTTrackingStatus;

- (void)requestPhotoAuthrization:(MXPhotoAccessLevel)level completeHandler:(void(^)(BOOL status))handler;
- (void)requestCameraAuthrization:(void(^)(BOOL status))handler;
- (void)requestLocationAuthrization:(MXLocationAuthLevel)level completeHandler:(void(^)(BOOL status))handler;
- (void)requestIDFAAuthrization:(void(^)(BOOL status))handler;

@end

NS_ASSUME_NONNULL_END
