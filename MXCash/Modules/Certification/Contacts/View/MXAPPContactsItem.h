//
//  MXAPPContactsItem.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MXAPPContactsItem, MXAPPContactsPeopleModel, MXAPPQuestionChoiseModel;

@protocol APPContactsItemProtocol <NSObject>

- (void)clickContactsItem:(MXAPPContactsItem *)item isRelationShip:(BOOL)relationShip;

@end

@interface MXAPPContactsItem : UIView

@property (nonatomic, weak) id<APPContactsItemProtocol> contactDelegate;
@property (nonatomic, strong, readonly) NSArray<MXAPPQuestionChoiseModel *>* relationModels;

- (void)reloadContactsItemWithModel:(MXAPPContactsPeopleModel *)model;
- (void)reloadInputValue:(NSString * _Nullable)value relationShip:(NSString * _Nullable)relation;

@end

NS_ASSUME_NONNULL_END
