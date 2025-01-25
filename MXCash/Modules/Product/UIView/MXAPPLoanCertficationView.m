//
//  MXAPPLoanCertficationView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPLoanCertficationView.h"

@interface MXAPPLoanCertficationView ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UIImageView *arrowImgView;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, copy, readwrite) NSString *jumpUrl;
@property (nonatomic, assign, readwrite) BOOL hasComplete;

@end

@implementation MXAPPLoanCertficationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLab];
        [self addSubview:self.logoImgView];
        [self addSubview:self.arrowImgView];
        [self addSubview:self.lineView];
        
        [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self).offset(PADDING_UNIT * 4);
            make.size.mas_equalTo(30);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.logoImgView);
            make.left.mas_equalTo(self.logoImgView.mas_right).offset(PADDING_UNIT * 2.5);
        }];
        
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 4);
            make.size.mas_equalTo(20);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(PADDING_UNIT * 4);
            make.bottom.mas_equalTo(self);
        }];
    }
    
    return self;
}

- (void)reloadCertificationView:(MXAPPCertificationModel *)model showLine:(BOOL)show {
    self.titleLab.text = model.coined;
    self.hasComplete = model.ssn;
    self.arrowImgView.image = model.ssn ? [UIImage imageNamed:@"certification_complete"] : [UIImage imageNamed:@"certification_arrow"];
    if (![NSString isEmptyString:model.dance]) {
        [self.logoImgView setImageWithURL:[NSURL URLWithString:model.dance] options:YYWebImageOptionProgressiveBlur];
    }
    self.lineView.hidden = !show;
    self.type = model.type;
    self.jumpUrl = model.figures;
}

- (NSString *)citificationTitle {
    return self.titleLab.text;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:14];
    }
    
    return _titleLab;
}

- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _logoImgView;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_arrow_img"]];
    }
    
    return _arrowImgView;
}

- (UIImageView *)lineView {
    if (!_lineView) {
        _lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_line_img"]];
    }
    
    return _lineView;
}

@end
