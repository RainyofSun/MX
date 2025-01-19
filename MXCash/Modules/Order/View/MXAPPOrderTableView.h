//
//  MXAPPOrderTableView.h
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MXAPPOrderTableView, MXAPPOrderItemModel;

@protocol OrderTableRefreshProtocol <NSObject>

/// 开始请求数据
- (void)beginRefreshOrderData:(MXAPPOrderTableView *)tab;
/// 前往首页
- (void)gotoHomePage;

@end

@protocol OrderTableSelectedProtocol <NSObject>

/// 选中订单
- (void)didSelectedOrder:(MXAPPOrderItemModel *)order;

@end

@interface MXAPPOrderTableView : UITableView

@property (nonatomic, weak) id<OrderTableRefreshProtocol> refreshDelegate;
@property (nonatomic, weak) id<OrderTableSelectedProtocol> selectDelegate;

/// 刷新页面数据
- (void)refreshOrderWithSource:(NSArray <MXAPPOrderItemModel *>*)source;
/// 开始刷新
- (void)beginRefresh:(BOOL)begin;
/// 切换列表刷新
- (void)switchOrderListAndRefresh;

@end

NS_ASSUME_NONNULL_END
