//
//  MXAPPProcessBar.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPProcessBar.h"

@interface MXAPPProcessBar ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UIProgressView *processView;

@end

@implementation MXAPPProcessBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FDCE58"];
        self.layer.cornerRadius = 16;
        self.clipsToBounds = YES;
        
        [self addSubview:self.imgView];
        [self addSubview:self.titleLab];
        [self addSubview:self.numberLab];
        [self addSubview:self.processView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(PADDING_UNIT);
            make.top.mas_equalTo(self).offset(PADDING_UNIT * 2.5);
            make.bottom.mas_equalTo(self).offset(-PADDING_UNIT * 2.5);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgView).offset(PADDING_UNIT);
            make.left.mas_equalTo(self.imgView.mas_right).offset(PADDING_UNIT);
        }];
        
        [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLab);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 2.5);
        }];
        
        [self.processView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLab);
            make.right.mas_equalTo(self).offset(-PADDING_UNIT * 2.5);
            make.height.mas_equalTo(10);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 2);
        }];
    }
    return self;
}

- (void)updateProcess:(CGFloat)process {
    self.numberLab.text = [NSString stringWithFormat:@"%@%d", @"%", (int)ceil(process * 100)];
    [self.processView setProgress:process animated:YES];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"process_img"]];
    }
    
    return _imgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = BLACK_COLOR_333333;
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.text = [[MXAPPLanguage language] languageValue:@"certification_process_title"];
    }
    
    return _titleLab;
}

- (UILabel *)numberLab {
    if (!_numberLab) {
        _numberLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLab.textColor = BLACK_COLOR_666666;
        _numberLab.font = [UIFont systemFontOfSize:14];
    }
    
    return _numberLab;
}

- (UIProgressView *)processView {
    if (!_processView) {
        _processView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _processView.trackTintColor = [UIColor whiteColor];
        _processView.progressTintColor = ORANGE_COLOR_FA6603;
        _processView.layer.cornerRadius = 5;
        _processView.clipsToBounds = YES;
    }
    
    return _processView;
}

@end
