//
//  MXNetRequestURL.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import "MXNetRequestURL.h"

@interface MXNetRequestURL ()

@property (nonatomic, copy) NSString *requestDomainURL;
@property (nonatomic, strong) NSMutableArray<NSString *>* usedDomainURLs;

@end

@implementation MXNetRequestURL

+ (instancetype)shared {
    static MXNetRequestURL *url;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (url == nil) {
            url = [[MXNetRequestURL alloc] init];
        }
    });
    
    return url;
}

- (BOOL)setNewRequestDomainURL:(NSString *)url {
    if ([self.usedDomainURLs containsObject:url]) {
        return NO;
    }
    
    self.requestDomainURL = url;
    [self.usedDomainURLs addObject:url];
    DDLogDebug(@"-------- 设置新的域名 = %@ success ---------", url);
    
    return YES;
}

- (NSURL *)requestURL {
    if ([NSString isEmptyString:self.requestDomainURL]) {
        return [NSURL URLWithString:BASE_URL];
    }
    
    return [NSURL URLWithString:self.requestDomainURL];
}

- (NSMutableArray<NSString *> *)usedDomainURLs {
    if (!_usedDomainURLs) {
        _usedDomainURLs = [NSMutableArray array];
    }
    
    return _usedDomainURLs;
}

@end
