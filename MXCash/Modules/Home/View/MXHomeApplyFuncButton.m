//
//  MXHomeApplyFuncButton.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/6.
//

#import "MXHomeApplyFuncButton.h"

@interface MXHomeApplyFuncButton ()

@property (nonatomic, strong) MXAPPGradientView *gradientView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MXHomeApplyFuncButton

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 15;
        self.clipsToBounds = YES;
        [self addSubview:self.gradientView];
        [self addSubview:self.titleLab];
        [self addSubview:self.imageView];
        
        [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
     
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gradientView).offset(PADDING_UNIT * 3.5);
            make.top.mas_equalTo(self.gradientView).offset(PADDING_UNIT * 6);
            make.width.mas_lessThanOrEqualTo(90);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.gradientView).offset(PADDING_UNIT * 4);
            make.right.mas_equalTo(self.gradientView).offset(-PADDING_UNIT * 1.5);
            make.bottom.mas_equalTo(self.gradientView).offset(-PADDING_UNIT * 3);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title titleColor:(UIColor *)color andImage:(NSString *)image andColors:(NSArray<UIColor *> *)colors {
    self.titleLab.text = title;
    self.titleLab.textColor = color;
    self.imageView.image = [UIImage imageNamed:image];
    [self.gradientView buildGradientWithColors:colors gradientStyle:LeftToRight];
}

- (MXAPPGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[MXAPPGradientView alloc] init];
        _gradientView.userInteractionEnabled = NO;
    }
    
    return _gradientView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont boldSystemFontOfSize:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLab;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

@end
