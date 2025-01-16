//
//  MXAPPNetObserver.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    WIFI,
    Cellular,
    LTE,
    EDGE,
    NONet
} MXNetworkStatus;

@interface MXAPPNetObserver : NSObject

+ (instancetype)Observer;

- (void)startNetObserver;
- (void)stopNetObserver;
- (BOOL)netWorkReachable;

@end

NS_ASSUME_NONNULL_END
