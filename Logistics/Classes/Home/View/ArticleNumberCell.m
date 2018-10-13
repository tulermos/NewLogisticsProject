//
//  ArticleNumberCell.m
//  Logistics
//
//  Created by tulemos on 2018/10/13.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "ArticleNumberCell.h"

@implementation ArticleNumberCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    _selectBtn = [UIButton buttonWithType:0];
    [_selectBtn setImage:[UIImage imageNamed:@"待开单未选中"] forState:0];
    [_selectBtn setImage:[UIImage imageNamed:@"待开单选中"] forState:1<<2];
    [self.contentView addSubview:_selectBtn];
    _noteLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x333333] text:nil];
    [self.contentView addSubview:_noteLabel];
     _dateLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x666666] text:nil];
    [self.contentView addSubview:_dateLabel];
     _locationLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x333333] text:nil];
    [self.contentView addSubview:_locationLabel];
     _kindLabel = [UILabel labelWithFont:14 textColor:[UIColor colorWithHex:0x999999] text:nil];
    [self.contentView addSubview:_kindLabel];
     _statusLabel = [UILabel labelWithFont:14 textColor:[UIColor colorWithHex:0x999999] text:nil];
    [self.contentView addSubview:_statusLabel];
    [self makeConstraint];
}

-(void)makeConstraint
{
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.height.mas_equalTo(16.2);
        make.top.equalTo(self.contentView.mas_top).offset(39);
    }];
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(234);
        make.height.mas_equalTo(21);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(118);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectBtn.mas_right).offset(11);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(18);
        make.top.equalTo(self.noteLabel.mas_bottom).offset(5);
    }];
    [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(145);
        make.width.mas_equalTo(150);
        make.top.equalTo(_noteLabel.mas_bottom).offset(26);
    }];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.height.mas_equalTo(16.2);
        make.top.equalTo(self.contentView.mas_top).offset(39);
    }];
}
//- (UIButton *)selectBtn {
//    if (!_selectBtn) {
//        _selectBtn = [UIButton buttonWithType:0];
//        [_selectBtn setImage:[UIImage imageNamed:@"待开单未选中"] forState:0];
//        [_selectBtn setImage:[UIImage imageNamed:@"待开单选中"] forState:1<<2];
//    }
//    return  _selectBtn;
//}
//
//- (UILabel *)noteLabel {
//    if (!_noteLabel) {
//        _noteLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x333333] text:nil];
//        _noteLabel.textAlignment = NSTextAlignmentCenter;
//        _noteLabel.numberOfLines = 0;
//    }
//    return  _noteLabel;
//}
//- (UILabel *)dateLabel {
//    if (!_dateLabel) {
//        _dateLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x666666] text:nil];
//
//        _dateLabel.numberOfLines = 0;
//    }
//    return  _dateLabel;
//}
//- (UILabel *)locationLabel {
//    if (!_locationLabel) {
//        _locationLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x333333] text:nil];
//
//        _locationLabel.numberOfLines = 0;
//    }
//    return  _locationLabel;
//}
//- (UILabel *)kindLabel {
//    if (!_kindLabel) {
//        _kindLabel = [UILabel labelWithFont:14 textColor:[UIColor colorWithHex:0x999999] text:nil];
//        _kindLabel.numberOfLines = 0;
//    }
//    return  _kindLabel;
//}
//- (UILabel *)statusLabel {
//    if (!_statusLabel) {
//        _statusLabel = [UILabel labelWithFont:14 textColor:[UIColor colorWithHex:0x999999] text:nil];
//
//        _statusLabel.numberOfLines = 0;
//    }
//    return  _statusLabel;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

