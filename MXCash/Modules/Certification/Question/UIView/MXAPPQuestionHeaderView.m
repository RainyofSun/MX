//
//  MXAPPQuestionHeaderView.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/11.
//

#import "MXAPPQuestionHeaderView.h"

@interface MXAPPQuestionHeaderView ()

@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) MXAPPProcessBar *processBar;

@end

@implementation MXAPPQuestionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.processBar];
        [self.contentView addSubview:self.tipLab];
        [self.contentView addSubview:self.topImgView];
        
        [self.processBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(PADDING_UNIT * 2.5);
            make.left.mas_equalTo(self.contentView).offset(PADDING_UNIT * 4);
            make.right.mas_equalTo(self.contentView).offset(-PADDING_UNIT * 4);
        }];
        
        [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.processBar.mas_bottom).offset(PADDING_UNIT * 5.5);
            make.left.mas_equalTo(self.processBar);
            make.width.mas_equalTo(self.contentView).multipliedBy(0.6);
        }];
        
        [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.processBar);
            make.top.mas_equalTo(self.processBar.mas_bottom);
        }];
    }
    return self;
}

- (void)updateCertificationProcess:(CGFloat)process {
    [self.processBar updateProcess:process];
}

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLab.textColor = [UIColor colorWithHexString:@"#F14857"];
        _tipLab.font = [UIFont boldSystemFontOfSize:18];
        _tipLab.numberOfLines = 0;
        _tipLab.text = [[MXAPPLanguage language] languageValue:@"certification_question_tip"];
    }
    
    return _tipLab;
}

- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"certification_ques_top_img"]];
    }
    
    return _topImgView;
}

- (MXAPPProcessBar *)processBar {
    if (!_processBar) {
        _processBar = [[MXAPPProcessBar alloc] initWithFrame:CGRectZero];
    }
    
    return _processBar;
}

@end
