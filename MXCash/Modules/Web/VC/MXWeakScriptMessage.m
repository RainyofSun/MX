//
//  MXWeakScriptMessage.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/5.
//

#import "MXWeakScriptMessage.h"

@interface MXWeakScriptMessage ()

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

@end

@implementation MXWeakScriptMessage

- (instancetype)initWithScriptDelegate:(id<WKScriptMessageHandler>)message {
    self = [super init];
    self.scriptDelegate = message;
    
    return self;
}

- (void)dealloc {
    DDLogDebug(@"--- %@ ---", NSStringFromClass([self class]));
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
