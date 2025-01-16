//
//  MXAPPInfoCertificationItem.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import <UIKit/UIKit.h>
#import "MXAPPQuestionModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MXAPPInfoCertificationItem;

@protocol APPInfoCertificationProtocol <NSObject>

- (void)clickCertificationInfoView:(MXAPPInfoCertificationItem *)itemView itemType:(ControlType)type;
- (void)didEndEditing:(MXAPPInfoCertificationItem *)itemView inputValue:(NSString *)value;

@end

@interface MXAPPInfoCertificationItem : UIView

@property (nonatomic, weak) id<APPInfoCertificationProtocol> itemDelegate;
@property (nonatomic, copy, readonly) NSString *paramsKey;
@property (nonatomic, assign, readonly) ControlType cType;
@property (nonatomic, strong, readonly) NSArray<MXAPPQuestionChoiseModel *>*choiseModel;

- (void)reloadInfoViewWithModel:(MXAPPQuestionModel *)model;
- (void)reloadInfoViewText:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
