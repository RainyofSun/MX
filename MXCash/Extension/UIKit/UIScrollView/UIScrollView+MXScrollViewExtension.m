//
//  UIScrollView+MXScrollViewExtension.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/7.
//

#import "UIScrollView+MXScrollViewExtension.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (MXScrollViewExtension)

- (void)addMJRefresh:(BOOL)userFooter refreshCall:(void (^)(BOOL))callBlock {
    if (userFooter) {
        [self addMJFooter:^{
            callBlock(NO);
        }];
    }
    
    [self addMJHeader:^{
        callBlock(YES);
    }];
}

- (void)reload:(BOOL)isEmpty {
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tab = (UITableView *)self;
        [tab reloadData];
    }
    
    if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *coll = (UICollectionView *)self;
        [coll reloadData];
    }
    
    [self.mj_header endRefreshing];
    if (self.mj_footer != nil) {
        isEmpty ? [self.mj_footer endRefreshingWithNoMoreData] : [self.mj_footer endRefreshing];
        self.mj_footer.hidden = isEmpty;
    }
}

- (void)refresh:(BOOL)begin {
    if (begin) {
        [self.mj_header beginRefreshing];
    } else {
        if ([self.mj_header isRefreshing]) {
            [self.mj_header endRefreshing];
        }
    }
}

- (void)loadMore:(BOOL)begin {
    if (begin) {
        [self.mj_footer beginRefreshing];
    } else {
        if ([self.mj_footer isRefreshing]) {
            [self.mj_footer endRefreshing];
        }
    }
}

- (void)addMJHeader:(void(^)(void))callBlock {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:callBlock];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:[[MXAPPLanguage language] languageValue:@"refresh_pull_idle"] forState:MJRefreshStateIdle];
    [header setTitle:[[MXAPPLanguage language] languageValue:@"refresh_pulling"] forState:MJRefreshStatePulling];
    [header setTitle:[[MXAPPLanguage language] languageValue:@"refresh_refreshing"] forState:MJRefreshStateRefreshing];
    self.mj_header = header;
}

- (void)addMJFooter:(void(^)(void))callBlock {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:callBlock];
    [footer setTitle:[[MXAPPLanguage language] languageValue:@"refresh_footer_idle"] forState:MJRefreshStateIdle];
    [footer setTitle:[[MXAPPLanguage language] languageValue:@"refresh_footer_refreshing"] forState:MJRefreshStateRefreshing];
    [footer setTitle:[[MXAPPLanguage language] languageValue:@"refresh_footer_nomoredata"] forState:MJRefreshStateNoMoreData];
    
}

@end
