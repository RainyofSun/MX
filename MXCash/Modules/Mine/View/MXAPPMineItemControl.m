//
//  MXAPPMineItemControl.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/9.
//

#import "MXAPPMineItemControl.h"

@interface MXAPPMineItemControl ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation MXAPPMineItemControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.imgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 5);
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgView.mas_bottom);
            make.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-PADDING_UNIT);
        }];
    }
    return self;
}

- (void)setItemTitle:(NSString *)title andImage:(NSString *)image {
    self.titleLab.text = title;
    if (![NSString isEmptyString:image]) {
        [self.imgView setImageWithURL:[NSURL URLWithString:image] options:YYWebImageOptionProgressiveBlur];
    }
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 0;
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
