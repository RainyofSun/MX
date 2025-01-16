//
//  MXNetRequestProtocol.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import <Foundation/Foundation.h>
#import "MXNetResponseHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MXNetRequestProtocol <NSObject>

- (NSDictionary *)requestParams;
- (AFNRequestType)requestType;
- (NSString *)requestURLPath;

@end

NS_ASSUME_NONNULL_END
