//
//  MXAPPQuestionTableViewCell.m
//  MXCash
//
//  Created by Yu Chen  on 2025/1/12.
//

#import "MXAPPQuestionTableViewCell.h"
#import "MXAPPQuestionModel.h"
#import "MXAPPQuestionItemControl.h"

@interface MXAPPQuestionTableViewCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSIndexPath *indexpath;

@end

@implementation MXAPPQuestionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.titleLab];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgView).offset(PADDING_UNIT * 4);
            make.right.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 4);
            make.top.mas_equalTo(self.bgView).offset(PADDING_UNIT * 3);
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.indexpath.row == 0) {
        [self.bgView cutViewRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:16];
    }
}

- (void)reloadQuestionCell:(MXAPPQuestionModel *)cellModel indexPath:(NSIndexPath *)cellIndex {
    self.indexpath = cellIndex;
    self.titleLab.attributedText = [NSAttributedString attributeText1:[NSString stringWithFormat:@"*%ld. ", cellIndex.row + 1] text1Color:ORANGE_COLOR_FA6603 text1Font:[UIFont systemFontOfSize:16] text2:cellModel.coined text2Color:BLACK_COLOR_333333 text1Font:[UIFont systemFontOfSize:16] paramDistance:-1 paraAlign:NSTextAlignmentLeft];
    NSInteger selectedIndex = [NSString isEmptyString:cellModel.tartan] ? -1 : cellModel.tartan.integerValue;
    if (self.bgView.subviews.count >= 2) {
        [self refreshItem:selectedIndex];
    } else {
        [self buildChoiseItem:cellModel.fish selectedIndex:selectedIndex keyString:cellModel.nekita];
    }
}

- (void)clickChoiseItem:(MXAPPQuestionItemControl *)sender {
    for (UIView *view in self.bgView.subviews) {
        if ([view isKindOfClass:[MXAPPQuestionItemControl class]]) {
            MXAPPQuestionItemControl *item = (MXAPPQuestionItemControl *)view;
            if (item.isSelected) {
                item.selected = NO;
                break;
            }
        }
    }
    
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [self.cellDelegate didSelectedChoise:sender.value cellIndex:self.indexpath];
    }
}

- (void)refreshItem:(NSInteger)selected {
    for (UIView *tempView in self.bgView.subviews) {
        if ([tempView isKindOfClass:[MXAPPQuestionItemControl class]]) {
            MXAPPQuestionItemControl *tempControl = (MXAPPQuestionItemControl *)tempView;
            tempControl.selected = tempControl.selectTag.integerValue == selected;
            break;
        }
    }
}

- (void)buildChoiseItem:(NSArray <MXAPPQuestionChoiseModel *>*)choiseModels selectedIndex:(NSInteger)selectIndex keyString:(NSString *)key {
    MXAPPQuestionItemControl *temp_top_item = nil;
    MXAPPQuestionItemControl *temp_left_item = nil;
    NSInteger row = choiseModels.count%2 == 0 ? choiseModels.count/2 : (choiseModels.count/2 + 1);
    CGFloat item_width = (ScreenWidth - PADDING_UNIT * 11)/2;
    
    NSInteger index = 0;
    for (int i = 0; i < row; i ++) {
        for (int j = 0; j < 2; j ++) {
            if (index >= choiseModels.count) {
                return;
            }
            MXAPPQuestionChoiseModel *infoModel = choiseModels[index];
            MXAPPQuestionItemControl *item = [[MXAPPQuestionItemControl alloc] initWithFrame:CGRectZero];
            [item setControlTitle:infoModel.robin];
            item.selectTag = [NSNumber numberWithInteger:infoModel.sites];
            item.value[key] = item.selectTag;
            if (selectIndex >= 0) {
                item.selected = index == selectIndex;
            } else {
                item.selected = NO;
            }
            [item addTarget:self action:@selector(clickChoiseItem:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.bgView addSubview:item];
            
            if (temp_top_item != nil) {
                if (temp_left_item != nil) {
                    if (index == choiseModels.count - 1) {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(temp_left_item.mas_right).offset(PADDING_UNIT * 3);
                            make.size.top.mas_equalTo(temp_left_item);
                            make.bottom.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 2);
                        }];
                    } else {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(temp_left_item.mas_right).offset(PADDING_UNIT * 3);
                            make.size.top.mas_equalTo(temp_left_item);
                        }];
                    }
                } else {
                    if (index == choiseModels.count - 1) {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(temp_top_item.mas_bottom).offset(PADDING_UNIT * 2.5);
                            make.size.left.mas_equalTo(temp_top_item);
                            make.bottom.mas_equalTo(self.bgView).offset(-PADDING_UNIT * 2);
                        }];
                    } else {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(temp_top_item.mas_bottom).offset(PADDING_UNIT * 2.5);
                            make.size.left.mas_equalTo(temp_top_item);
                        }];
                    }
                }
            } else {
                if (temp_left_item != nil) {
                    if (index == choiseModels.count - 1) {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(temp_left_item.mas_right).offset(PADDING_UNIT * 3);
                            make.size.top.mas_equalTo(temp_left_item);
                            make.bottom.mas_equalTo(self.bgView);
                        }];
                    } else {
                        [item mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(temp_left_item.mas_right).offset(PADDING_UNIT * 3);
                            make.size.top.mas_equalTo(temp_left_item);
                        }];
                    }
                } else {
                    [item mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(self.bgView).offset(PADDING_UNIT * 4);
                        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(PADDING_UNIT * 2.5);
                        make.size.mas_equalTo(CGSizeMake(item_width, 99));
                    }];
                }
            }
            
            if (j == 0) {
                temp_top_item = item;
            }
            if (j == 1) {
                temp_left_item = nil;
            } else {
                temp_left_item = item;
            }
            index ++;
        }
    }
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.numberOfLines = 0;
    }
    
    return _titleLab;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    
    return _bgView;
}

@end
