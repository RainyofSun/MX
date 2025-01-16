//
//  MXAPPLoanCertficationView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import <UIKit/UIKit.h>
#import "MXAPPCertificationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPLoanCertficationView : UIControl

@property (nonatomic, assign) CertificationType type;
@property (nonatomic, copy, readonly) NSString *jumpUrl;

- (void)reloadCertificationView:(MXAPPCertificationModel *)model showLine:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
