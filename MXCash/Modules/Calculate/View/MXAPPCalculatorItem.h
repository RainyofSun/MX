//
//  MXAPPCalculatorItem.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPCalculatorItem : UIView

@property (nonatomic, copy, readonly) NSString *value;
@property (nonatomic, strong, readonly) NSString *loanTerm;

- (void)setItemTitle:(NSString *)title placeholder:(NSString *)placeHolder;
- (void)setInputTypeLimit:(BOOL)canInputFloat;
- (void)setLoanRepaymentType;
- (void)clearText;

@end

NS_ASSUME_NONNULL_END
