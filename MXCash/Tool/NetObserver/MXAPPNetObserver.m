//
//  MXAPPNetObserver.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import "MXAPPNetObserver.h"
#import <Reachability/Reachability.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface MXAPPNetObserver ()

@property (nonatomic, strong) Reachability *reach;
@property (nonatomic, assign) MXNetworkStatus status;

@end

@implementation MXAPPNetObserver

+ (instancetype)Observer {
    static MXAPPNetObserver *ob;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (ob == nil) {
            ob = [[MXAPPNetObserver alloc] init];
        }
    });
    return ob;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.reach = [Reachability reachabilityForInternetConnection];
    }
    return self;
}

- (void)startNetObserver {
    [self resetNetState:self.reach];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange:) name:kReachabilityChangedNotification object:nil];
    [self.reach startNotifier];
}

- (void)stopNetObserver {
    [self.reach stopNotifier];
}

- (BOOL)netWorkReachable {
    return [self.reach isReachable];
}

- (void)resetNetState:(Reachability* )reach {
    if (reach.isReachable) {
        if (reach.isReachableViaWiFi) {
            self.status = WIFI;
        } else {
            self.status = Cellular;
        }
    } else {
        [self checkNetConnection];
    }
}

- (void)checkNetConnection {
    CTTelephonyNetworkInfo *workinfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *netName = workinfo.currentRadioAccessTechnology;
    if (netName == nil) {
        self.status = NONet;
        return;
    }
    
    if (netName == CTRadioAccessTechnologyLTE) {
        self.status = LTE;
    } else if (netName == CTRadioAccessTechnologyEdge) {
        self.status = EDGE;
    } else {
        self.status = NONet;
    }
}

#pragma mark - 通知
- (void)networkChange:(NSNotification *)notification {
    Reachability *currReach = [notification object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    [self resetNetState:currReach];
    [[NSNotificationCenter defaultCenter] postNotificationName:(NSNotificationName)APP_NET_CHANGE_NOTIFICATION object:[NSNumber numberWithInteger:self.status]];
}

@end
