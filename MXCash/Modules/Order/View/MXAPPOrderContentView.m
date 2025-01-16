//
//  MXAPPOrderContentView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import "MXAPPOrderContentView.h"
#import "MXAPPOrderMenuView.h"
#import "UIView+MXViewAnimation.h"
#import "MXAPPOrderTableView.h"
#import "MXAPPOrderModel.h"

@interface MXAPPOrderContentView ()<OrderMenuProtocol, OrderTableRefreshProtocol, OrderTableSelectedProtocol>

@property (nonatomic, strong) MXAPPOrderMenuView *menuView;
@property (nonatomic, strong) UIScrollView *hScrollView;
@property (nonatomic, strong) MXAPPOrderTableView *applyTab;
@property (nonatomic, strong) MXAPPOrderTableView *repaymentTab;
@property (nonatomic, strong) MXAPPOrderTableView *finishedTab;

@end

@implementation MXAPPOrderContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self cutViewRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:32];
}

- (void)refreshOrder {
    if (self.menuView.selectedTag == 0) {
        [self.applyTab beginRefresh:YES];
    }
    
    if (self.menuView.selectedTag == 1) {
        [self.repaymentTab beginRefresh:YES];
    }
    
    if (self.menuView.selectedTag == 2) {
        [self.finishedTab beginRefresh:YES];
    }
}

#pragma mark - OrderMenuProtocol
- (void)didSelectedMenuItem:(NSInteger)tag {
    if (tag == 0) {
        [self.hScrollView setContentOffset:CGPointZero animated:YES];
    } else if (tag == 1) {
        if (self.repaymentTab == nil) {
            self.repaymentTab = [[MXAPPOrderTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            [self.hScrollView addSubview:self.repaymentTab];
            [self.repaymentTab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.top.mas_equalTo(self.applyTab);
                make.left.mas_equalTo(self.applyTab.mas_right);
            }];
            self.repaymentTab.selectDelegate = self;
            self.repaymentTab.refreshDelegate = self;
            self.repaymentTab.tag = 1006;
            [self.repaymentTab switchOrderListAndRefresh];
        }
        
        [self.hScrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
    } else {
        if (self.finishedTab == nil) {
            self.finishedTab = [[MXAPPOrderTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            [self.hScrollView addSubview:self.finishedTab];
            [self.finishedTab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.top.mas_equalTo(self.repaymentTab);
                make.left.mas_equalTo(self.repaymentTab.mas_right);
            }];
            self.finishedTab.selectDelegate = self;
            self.finishedTab.refreshDelegate = self;
            self.finishedTab.tag = 1005;
            [self.finishedTab switchOrderListAndRefresh];
        }
        
        [self.hScrollView setContentOffset:CGPointMake(ScreenWidth * tag, 0) animated:YES];
    }
}

#pragma mark - OrderTableRefreshProtocol
- (void)beginRefreshOrderData:(MXAPPOrderTableView *)tab {
    [MXNetRequestManager AFNReqeustType:AFNRequestType_Post reqesutUrl:@"secondary/figures" params:@{@"game": [NSString stringWithFormat:@"%ld", tab.tag - 1000]} success:^(NSURLSessionDataTask * _Nullable task, struct SuccessResponse responseObject) {
        [tab beginRefresh:NO];
        MXAPPOrderModel *orderModel = [MXAPPOrderModel modelWithDictionary:responseObject.jsonDict];
        [tab refreshOrderWithSource:orderModel.seals];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [tab beginRefresh:NO];
    }];
}

#pragma mark - OrderTableSelectedProtocol
- (void)didSelectedOrder:(MXAPPOrderItemModel *)order {
    if ([NSString isEmptyString:order.foxforce]) {
        return;
    }
    
    [[MXAPPRouting shared] pageRouter:order.foxforce backToRoot:[order.foxforce hasPrefix:@"http"] targetVC:nil];
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithHexString:@"#FFF5E4"];
    
    self.menuView.menuDelegate = self;
    self.applyTab.refreshDelegate = self;
    self.applyTab.selectDelegate = self;
    self.applyTab.tag = 1004;
    
    [self addSubview:self.menuView];
    [self addSubview:self.hScrollView];
    [self.hScrollView addSubview:self.applyTab];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
    }];
    
    [self.hScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.menuView.mas_bottom);
        make.bottom.mas_equalTo(self).offset(- [UIDevice currentDevice].app_tabbarAndSafeAreaHeight - PADDING_UNIT);
    }];
    
    [self.applyTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.left.top.mas_equalTo(self.hScrollView);
    }];
}

- (MXAPPOrderMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[MXAPPOrderMenuView alloc] initWithFrame:CGRectZero];
    }
    
    return _menuView;
}

- (UIScrollView *)hScrollView {
    if (!_hScrollView) {
        _hScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _hScrollView.pagingEnabled = YES;
        _hScrollView.scrollEnabled = NO;
        _hScrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    }
    
    return _hScrollView;
}

- (MXAPPOrderTableView *)applyTab {
    if (!_applyTab) {
        _applyTab = [[MXAPPOrderTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    
    return _applyTab;
}

@end
