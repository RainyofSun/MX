//
//  MXWeakScriptMessage.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/5.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXWeakScriptMessage : NSObject<WKScriptMessageHandler>

- (instancetype)initWithScriptDelegate:(id<WKScriptMessageHandler>)message;

@end

NS_ASSUME_NONNULL_END
