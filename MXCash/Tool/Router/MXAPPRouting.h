//
//  MXAPPRouting.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import <Foundation/Foundation.h>

@interface MXAPPRouting : NSObject

+ (instancetype)shared;

- (void)pageRouter:(NSString *)url backToRoot:(BOOL)toRoot targetVC:(nullable UIViewController *)target;

@end
