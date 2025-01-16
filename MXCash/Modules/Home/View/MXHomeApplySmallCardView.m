//
//  MXHomeApplySmallCardView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import "MXHomeApplySmallCardView.h"
#import "MXHomeProductTableViewCell.h"
#import "MXAPPHomeModel.h"

static NSString *CELL_ID = @"MXHomeProductTableViewCell";

@interface MXHomeApplySmallCardView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITableView *productView;

@property (nonatomic, strong) NSMutableArray<MXAPPProductModel *>* productArray;

@end

@implementation MXHomeApplySmallCardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)reloadSmallCardProducts:(NSArray<MXAPPProductModel *> *)products {
    [self.productArray removeAllObjects];
    [self.productArray addObjectsFromArray:products];
    [self.productView reload:self.productArray.count == 0];
}

- (void)setupUI {
    self.hidden = YES;
    
    self.productView.delegate = self;
    self.productView.dataSource = self;
    [self.productView registerClass:[MXHomeProductTableViewCell class] forCellReuseIdentifier:CELL_ID];
    
    self.titleLab.text = [[MXAPPLanguage language] languageValue:@"home_product_title"];
    [self addSubview:self.titleLab];
    [self addSubview:self.productView];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(PADDING_UNIT * 3);
        make.top.mas_equalTo(self).offset(PADDING_UNIT * 3.5);
    }];
    
    CGFloat height = ScreenHeight - [UIDevice currentDevice].app_tabbarAndSafeAreaHeight - PADDING_UNIT * 2.5 - 620;
    if (height < 0) {
        height = 350;
    }
    [self.productView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT);
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(self);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXHomeProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    [cell reloadProduct:self.productArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MXHomeProductTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.smallCardDelegate didSelectedProduct:self.productArray[indexPath.row] sender:cell.applyBtn];
}

- (NSMutableArray<MXAPPProductModel *> *)productArray {
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    
    return _productArray;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    
    return _titleLab;
}

- (UITableView *)productView {
    if (!_productView) {
        _productView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _productView.showsVerticalScrollIndicator = NO;
        _productView.backgroundColor = [UIColor clearColor];
        _productView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _productView;
}

@end
