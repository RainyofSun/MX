//
//  MXAPPMineSettingItem.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/9.
//

#import "MXAPPMineSettingItem.h"

@interface MXAPPMineSettingItem ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subLab;
@property (nonatomic, strong) UIImageView *arrowImgView;

@end

@implementation MXAPPMineSettingItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.subLab];
        [self addSubview:self.arrowImgView];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 5);
            make.bottom.mas_equalTo(self).offset(-PADDING_UNIT * 5);
        }];
        
        [self.subLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4);
        }];
        
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.mas_equalTo(self.subLab);
        }];
    }
    return self;
}

- (void)setSettingItemTitle:(NSString *)title titleImage:(NSString *)image hideArrow:(BOOL)hide {
    self.titleLab.attributedText = [NSAttributedString attachmentImage:image afterText:NO imagePosition:-3 attributeString:title textColor:BLACK_COLOR_333333 textFont:[UIFont systemFontOfSize:14]];
    self.subLab.hidden = !hide;
    self.arrowImgView.hidden = hide;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    return _titleLab;
}

- (UILabel *)subLab {
    if (!_subLab) {
        _subLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _subLab.textColor = ORANGE_COLOR_FA6603;
        _subLab.font = [UIFont systemFontOfSize:15];
        _subLab.text = [NSString stringWithFormat:@"V%@", [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
        _subLab.hidden = YES;
    }
    
    return _subLab;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_arrow_img"]];
    }
    
    return _arrowImgView;
}

@end
