//
//  MXAPPLoginInputView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import <UIKit/UIKit.h>
#import "MXAPPTimerButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol APPLoginInputProtocol <NSObject>

- (void)requestVoiceCode:(UIButton *)sender phoneNumber:(NSString *)phone;
- (void)requestSMSCode:(MXAPPTimerButton *)sender phoneNumber:(NSString *)phone;
- (void)requestLogin:(MXAPPLoadingButton *)sender phoneNumber:(NSString *)phone smsCode:(NSString *)code;

@end

@interface MXAPPLoginInputView : UIView

@property (nonatomic, weak) id<APPLoginInputProtocol> loginDelegate;

- (void)phoneShowKeyboard;
- (void)codeShowKeyboard;
- (void)clearCodeText;
- (void)stopTimer;

@end

NS_ASSUME_NONNULL_END
