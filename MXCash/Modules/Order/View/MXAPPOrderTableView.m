//
//  MXAPPOrderTableView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/8.
//

#import "MXAPPOrderTableView.h"
#import "MXAPPOrderTableViewCell.h"
#import "MXAPPOrderModel.h"
#import "MXAPPEmptyView.h"

static NSString *CELL_ID = @"MXAPPOrderTableViewCell";

@interface MXAPPOrderTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <MXAPPOrderItemModel *>*order_models;
@property (nonatomic, strong) MXAPPEmptyView *emptyView;

@end

@implementation MXAPPOrderTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.delegate = self;
        self.dataSource = self;
        [self addSubview:self.emptyView];
        WeakSelf;
        self.emptyView.tryBlcok = ^{
            [weakSelf.refreshDelegate gotoHomePage];
        };
        
        [self registerClass:[MXAPPOrderTableViewCell class] forCellReuseIdentifier:CELL_ID];
        [self addMJRefresh:NO refreshCall:^(BOOL refresh) {
            [weakSelf.refreshDelegate beginRefreshOrderData:weakSelf];
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.emptyView.frame = self.bounds;
}

- (void)refreshOrderWithSource:(NSArray<MXAPPOrderItemModel *> *)source {
    [self.order_models removeAllObjects];
    [self.order_models addObjectsFromArray:source];
    [self reload:source.count == 0];
}

- (void)beginRefresh:(BOOL)begin {
    [self refresh:begin];
}

- (void)switchOrderListAndRefresh {
    if (self.order_models.count != 0) {
        return;
    }
    
    [self refresh:YES];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.emptyView.hidden = self.order_models.count != 0;
    return self.order_models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXAPPOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    [cell reloadOrderCell:self.order_models[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectDelegate didSelectedOrder:self.order_models[indexPath.row]];
}

- (NSMutableArray<MXAPPOrderItemModel *> *)order_models {
    if (!_order_models) {
        _order_models = [NSMutableArray array];
    }
    
    return _order_models;
}

- (MXAPPEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[MXAPPEmptyView alloc] initWithFrame:CGRectZero];
        _emptyView.hidden = YES;
    }
    
    return _emptyView;
}

@end
