//
//  MXAPPWebViewController.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPWebViewController : MXBaseViewController

- (instancetype)initWithWebLink:(NSString *)url backToRoot:(BOOL)toRoot;

@end

NS_ASSUME_NONNULL_END
