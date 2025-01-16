//
//  MXAPPLoadingButton.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/4.
//

#import "MXAPPLoadingButton.h"

@interface MXAPPLoadingButton ()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, copy) NSString *btnTitle;
@property (nonatomic, strong) UIImage *btnImg;

@end

@implementation MXAPPLoadingButton

- (void)startAnimation {
    self.btnTitle = self.currentTitle;
    [self setTitle:nil forState:UIControlStateNormal];
    self.btnImg = self.currentImage;
    [self setImage:nil forState:UIControlStateNormal];
    
    if (self.activityView.superview == nil) {
        [self addSubview:self.activityView];
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(self);
        }];
    }
    
    [self.activityView startAnimating];
    self.enabled = NO;
}

- (void)stopAnimation {
    if (self.activityView.superview != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.activityView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.activityView stopAnimating];
            [self.activityView removeFromSuperview];
        }];
    }
    
    [self setTitle:self.btnTitle forState:UIControlStateNormal];
    [self setImage:self.btnImg forState:UIControlStateNormal];
    self.enabled = YES;
}

- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.hidesWhenStopped = YES;
    }
    
    return _activityView;
}

@end
