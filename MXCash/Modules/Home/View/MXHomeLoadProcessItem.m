//
//  MXHomeLoadProcessItem.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import "MXHomeLoadProcessItem.h"

@interface MXHomeLoadProcessItem ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation MXHomeLoadProcessItem

- (instancetype)initWithFrame:(CGRect)frame imgViewSize:(CGSize)size {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.imgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.mas_equalTo(self);
            make.size.mas_equalTo(size);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgView.mas_bottom).offset(PADDING_UNIT);
            make.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-PADDING_UNIT);
        }];
    }
    return self;
}

- (void)setItemTitle:(NSString *)title andImage:(NSString *)image {
    self.titleLab.text = title;
    self.imgView.image = [UIImage imageNamed:image];
}

- (void)setTitleColor:(UIColor *)color {
    self.titleLab.textColor = color;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLab;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    
    return _imgView;
}

@end
