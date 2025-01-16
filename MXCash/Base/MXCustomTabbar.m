//
//  MXCustomTabbar.m
//  MXCash
//
//  Created by Yu Chen  on 2024/12/31.
//

#import "MXCustomTabbar.h"

@interface MXCustomTabbar ()

@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, assign) CGSize originSize;

@end

@implementation MXCustomTabbar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.originSize = CGSizeMake(0, 0);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.originSize = frame.size;
        [self addSubview:self.cornerView];
        
        [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4);
            make.height.mas_equalTo([UIDevice currentDevice].app_tabbarHeight);
        }];
    }
    return self;
}

- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated {
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (!CGSizeEqualToSize(self.originSize, CGSizeMake(0, 0))) {
        return self.originSize;
    }
    
    return [super sizeThatFits:size];
}

- (void)setTabbarWithTitles:(NSArray<NSString *> *)titles barItemImages:(NSArray<NSString *> *)normalImgs barSelectedImgages:(NSArray<NSString *> *)selectedImages {
    if (selectedImages.count != normalImgs.count) {
        return;
    }
    
    CGFloat item_width = ([UIScreen mainScreen].bounds.size.width - PADDING_UNIT * 8)/normalImgs.count;
    CGFloat item_height = 40;
    
    [normalImgs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        if (titles.count != 0) {
            [item setTitle:titles[idx] forState:UIControlStateNormal];
            [item setTitle:titles[idx] forState:UIControlStateHighlighted];
            [item setTitleColor:[UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1] forState:UIControlStateNormal];
            [item setTitleColor:[UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1] forState:UIControlStateHighlighted];
        }
        [item setImage:[UIImage imageNamed:normalImgs[idx]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:selectedImages[idx]] forState:UIControlStateSelected];
        item.frame = CGRectMake(item_width * idx, ([[UIDevice currentDevice] app_tabbarHeight] - item_height) * 0.5, item_width, item_height);
        item.tag = 100 + idx;
        [item addTarget:self action:@selector(clickTabbarItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.cornerView addSubview:item];
    }];
}

- (void)selectedTabbarItem:(NSInteger)index {
    UIView *tagView = [self viewWithTag:(100 + index)];
    if (tagView != nil && [tagView isKindOfClass:[UIButton class]]) {
        UIButton *item = (UIButton *)tagView;
        [self resetTabbarItemState];
        item.selected = !item.selected;
    }
}

- (void)resetTabbarItemState {
    [self.cornerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *item = (UIButton *)obj;
            if (item.isSelected) {
                item.selected = NO;
                *stop = YES;
            }
        }
    }];
}

- (void)clickTabbarItem:(UIButton *)sender {
    if (![self.barDelegate canSelected: (sender.tag - 100)]) {
        return;
    }
    
    [self resetTabbarItemState];
    sender.selected = !sender.selected;
    [self.barDelegate didSelectedItem:self item:sender selectedIndex:(sender.tag - 100)];
}

#pragma mark - setter
- (UIView *)cornerView {
    if (!_cornerView) {
        _cornerView = [[UIView alloc] init];
        _cornerView.layer.cornerRadius = [[UIDevice currentDevice] app_tabbarHeight] * 0.5;
        _cornerView.clipsToBounds = YES;
        _cornerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _cornerView;
}

@end
