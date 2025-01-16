//
//  MXCustomTextView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXCustomTextView.h"

@implementation MXCustomTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.inputAssistantItem.allowsHidingShortcuts = NO;
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end
