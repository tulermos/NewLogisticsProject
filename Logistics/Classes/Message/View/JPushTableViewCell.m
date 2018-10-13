//
//  JPushTableViewCell.m
//  Logistics
//
//  Created by meng wang on 2018/5/2.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "JPushTableViewCell.h"
#import "JPushModel.h"

@interface JPushTableViewCell ()

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *timeLabel;

@end

@implementation JPushTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.leading.mas_equalTo(15);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(_icon.mas_trailing).offset(15);
        make.trailing
        .mas_lessThanOrEqualTo(_timeLabel.mas_leading).offset(-10);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(80);
    }];
}

- (void)setModel:(JPushModel *)model {
    _model = model;
    self.icon.image = [UIImage imageNamed:model.type?@"xiaoxi_moren":@"gonggao_moren"];
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.time;
    self.contentLabel.textColor = model.isRead?[UIColor colorWithHex:0x999999]:[UIColor colorWithHex:0x333333];
}

#pragma mark - lazy
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:333333] text:nil];
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x333333] text:nil];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

@end
