//
//  WLHomeCollectionViewCell.m
//  Logistics
//
//  Created by meng wang on 2018/4/21.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WLHomeCollectionViewCell.h"
@interface WLHomeCollectionViewCell ()

@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation WLHomeCollectionViewCell

- (void)setUpIcon:(NSString *)icon title:(NSString *)title {
    self.iconImageView.image = [UIImage imageNamed:icon];
    self.titleLabel.text = title;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(15);
        make.centerX.mas_equalTo(self.contentView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(10);
        make.leading.mas_equalTo(self.contentView).offset(8);
        make.trailing.mas_equalTo(self.contentView).offset(-8);
    }];
}

#pragma mark - lazy
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFont:14 textColor:[UIColor colorWithHex:0x333333] text:nil];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return  _titleLabel;
}

@end
