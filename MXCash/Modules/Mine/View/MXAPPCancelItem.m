//
//  MXAPPCancelItem.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/10.
//

#import "MXAPPCancelItem.h"

@interface MXAPPCancelItem ()

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *contentLab;

@end

@implementation MXAPPCancelItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dotView];
        [self addSubview:self.contentLab];
        
        [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 3.5);
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 2);
            make.size.mas_equalTo(6);
        }];
        
        [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dotView.mas_right).offset(PADDING_UNIT);
            make.top.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4);
        }];
    }
    return self;
}

- (void)setContentText:(NSString *)content {
    self.contentLab.text = content;
}

- (UIView *)dotView {
    if (!_dotView) {
        _dotView = [[UIView alloc] initWithFrame:CGRectZero];
        _dotView.backgroundColor = BLACK_COLOR_666666;
        _dotView.layer.cornerRadius = 3;
        _dotView.clipsToBounds = YES;
    }
    
    return _dotView;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLab.numberOfLines = 0;
    }
    
    return _contentLab;
}

@end
