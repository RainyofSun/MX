//
//  MXNetRequestURL.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXNetRequestURL : NSObject

+ (instancetype)shared;

- (BOOL)setNewRequestDomainURL:(NSString *)url;
- (NSURL *)requestURL;

@end

NS_ASSUME_NONNULL_END
