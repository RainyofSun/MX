//
//  MXAPPCitySelectView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/15.
//

#import "MXAPPPopBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXAPPCityCell : UITableViewCell

- (void)setCity:(NSString *)city;

@end

@interface MXAPPCitySelectView : MXAPPPopBaseView

@property (nonatomic, copy, readonly) NSString *cityStr;

@end

NS_ASSUME_NONNULL_END
