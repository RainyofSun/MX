//
//  MXAPPQuestionItemControl.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import "MXAPPQuestionItemControl.h"

@interface MXAPPQuestionItemControl ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *markImgView;

@end

@implementation MXAPPQuestionItemControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectTag = @(-1);
        self.backgroundColor = [UIColor colorWithHexString:@"#FFF5E4"];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        
        [self addSubview:self.titleLab];
        [self addSubview:self.markImgView];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
        [self.markImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 3);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 3);
        }];
    }
    return self;
}

-  (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.markImgView.image = selected ? [UIImage imageNamed:@"login_protocol_sel"] : [UIImage imageNamed:@"login_protocol_normal"];
}

- (void)setControlTitle:(NSString *)title {
    self.titleLab.text = title;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    
    return _titleLab;
}

- (UIImageView *)markImgView {
    if (!_markImgView) {
        _markImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _markImgView;
}

- (NSMutableDictionary *)value {
    if (!_value) {
        _value = [NSMutableDictionary dictionary];
    }
    
    return _value;
}

@end
