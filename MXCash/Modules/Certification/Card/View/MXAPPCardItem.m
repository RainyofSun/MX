//
//  MXAPPCardItem.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import "MXAPPCardItem.h"

@interface MXAPPCardItem ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *imgBtn;

@end

@implementation MXAPPCardItem

- (instancetype)initWithFrame:(CGRect)frame isFront:(BOOL)front {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.imgBtn setImage:[UIImage imageNamed:@"certification_id_add"] forState:UIControlStateNormal];
        [self.imgBtn setBackgroundImage:[UIImage imageNamed:(front ? @"certification_id_front" : @"certification_id_back")] forState:UIControlStateNormal];
        self.imgBtn.layer.cornerRadius = 12;
        self.imgBtn.clipsToBounds = YES;
        self.imgBtn.enabled = NO;
        self.imgBtn.adjustsImageWhenDisabled = NO;
        
        [self addSubview:self.titleLab];
        [self addSubview:self.imgBtn];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.top.mas_equalTo(self);
        }];
        
        [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 4.5);
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.57, ScreenWidth * 0.36));
            make.bottom.mas_equalTo(self).offset(-PADDING_UNIT * 2);
        }];
    }
    return self;
}

- (void)updateCardItemTitle:(NSString *)title cardImg:(nonnull NSString *)imgUrl {
    if (![NSString isEmptyString:title]) {
        self.titleLab.text = title;
    }
    
    if (![NSString isEmptyString:imgUrl] && self.imgBtn.currentImage != nil) {
        [self.imgBtn setImage:nil forState:UIControlStateNormal];
        [self.imgBtn setBackgroundImageWithURL:[NSURL URLWithString:imgUrl] forState:UIControlStateNormal options:YYWebImageOptionProgressiveBlur];
    }
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:16];
    }
    
    return _titleLab;
}

- (UIButton *)imgBtn {
    if (!_imgBtn) {
        _imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    return _imgBtn;
}

@end
