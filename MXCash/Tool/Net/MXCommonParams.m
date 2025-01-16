//
//  MXCommonParams.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "MXCommonParams.h"
#import "MXGlobal.h"
#import "MXAuthorizationTool.h"
#import <AdSupport/AdSupport.h>

@implementation MXCommonParams

+ (NSString *)splicingCommonArgus:(NSString *)requestUrl {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
    NSString *deviceName = [[UIDevice currentDevice] machineModel];
    NSString *idfvStr = [[UIDevice currentDevice] readIDFVFormKeyChain];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *loginToken = [MXGlobal global].loginModel.winsted;
    NSString *IDFAStr = [[MXAuthorizationTool authorization] ATTTrackingStatus] == ATTrackingManagerAuthorizationStatusAuthorized ? [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString : @"";
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:requestUrl];
    NSMutableArray<NSURLQueryItem *>* url_components = [NSMutableArray array];
    if (![NSString isEmptyString:appVersion]) {
        [url_components addObject:[[NSURLQueryItem alloc] initWithName:@"elections" value:appVersion]];
    }
    
    if (![NSString isEmptyString:deviceName]) {
        [url_components addObject:[[NSURLQueryItem alloc] initWithName:@"strength" value:deviceName]];
    }
    
    if (![NSString isEmptyString:idfvStr]) {
        [url_components addObject:[[NSURLQueryItem alloc] initWithName:@"politics" value:idfvStr]];
    }
    
    if (![NSString isEmptyString:systemVersion]) {
        [url_components addObject:[[NSURLQueryItem alloc] initWithName:@"provide" value:systemVersion]];
    }
    
    if (![NSString isEmptyString:loginToken]) {
        [url_components addObject:[[NSURLQueryItem alloc] initWithName:@"winsted" value:loginToken]];
    }
    
    if (![NSString isEmptyString:IDFAStr]) {
        [url_components addObject:[[NSURLQueryItem alloc] initWithName:@"subsection" value:IDFAStr]];
    }
    
    if (![NSString isEmptyString:[MXGlobal global].languageCode]) {
        [url_components addObject:[[NSURLQueryItem alloc] initWithName:@"margaret" value:[MXGlobal global].languageCode]];
    }
    
    if ([requestUrl containsString:@"?"]) {
        NSArray<NSArray <NSString *>*>* argusArray = [self separamtionRequestURLParameter:requestUrl];
        if (argusArray.count != 0) {
            [argusArray enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [url_components addObject:[[NSURLQueryItem alloc] initWithName:obj.firstObject value:obj.lastObject]];
            }];
        }
    }
    
    components.queryItems = url_components;
    
    return [NSString isEmptyString:components.URL.absoluteString] ? requestUrl : components.URL.absoluteString;
}

+ (NSArray<NSArray<NSString *> *>*)separamtionRequestURLParameter:(NSString *)requestURL {
    NSString *lastStr = [[requestURL componentsSeparatedByString:@"?"] lastObject];
    NSMutableArray<NSArray <NSString *>*>* argusArray = [NSMutableArray array];
    NSArray<NSString *>* params = [lastStr componentsSeparatedByString:@"&"];
    [params enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<NSString *>* tempArray = [obj componentsSeparatedByString:@"="];
        [argusArray addObject:tempArray];
    }];
    
    return argusArray;
}

@end
