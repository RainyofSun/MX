//
//  FileHeader.h
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#ifndef FileHeader_h
#define FileHeader_h

#import <YYKit/YYKit.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <Masonry/Masonry.h>
#import <Toast/Toast.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "MXAPPBuryReport.h"
#import "MXAPPLanguage.h"
#import "MXGlobal.h"
#import "MXNetRequestManager.h"
#import "MXUserDefaultCache.h"
#import "MXAPPLoadingButton.h"
#import "MXAPPGradientView.h"
#import "MXAPPRouting.h"
#import "MXAuthorizationTool.h"
#import "MXAPPProcessBar.h"

#import "MXHideNavigationBarProtocol.h"

#import "NSString+MXNSStringExtension.h"
#import "UIDevice+MXDeviceExtension.h"
#import "UIViewController+MXControllerExtension.h"
#import "NSDate+MXTimeExtension.h"
#import "NSAttributedString+MXAttributedString.h"
#import "UIButton+MXButtonExtension.h"
#import "UIScrollView+MXScrollViewExtension.h"
#import "UIView+MXViewAnimation.h"
#import "UIImage+Compress.h"

#ifdef DEBUG
    static const int ddLogLevel = DDLogLevelVerbose;
#else
    static const int ddLogLevel = DDLogLevelOff;
#endif

#endif /* FileHeader_h */
