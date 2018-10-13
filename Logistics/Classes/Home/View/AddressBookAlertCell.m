//
//  AddressBookAlertCell.m
//  Logistics
//
//  Created by meng wang on 2018/4/25.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "AddressBookAlertCell.h"

@interface AddressBookAlertCell()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *detailLabel;

@end

@implementation AddressBookAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.leading.mas_equalTo(self.contentView).offset(10);
        make.width.mas_equalTo((FCWidth - 50) * 0.5 - 20);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.leading.mas_equalTo(_titleLabel.mas_trailing);
        make.trailing.mas_equalTo(self.contentView).offset(-10);
        make.bottom.mas_equalTo(self.contentView).offset(-5);
    }];
}

- (void)setTitle:(NSString *)title detail:(NSString *)detail {
    self.titleLabel.text = title;
    self.detailLabel.text = detail;
}

+ (CGFloat)heightForCell:(NSString *)title detail:(NSString *)detail {
    CGFloat detailHeight = ceilf([NSString sizeWithText:detail font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake((FCWidth - 50) * 0.5 + 20, MAXFLOAT)].height);
    return detailHeight + 11;
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHex:0x999999];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}
@end
