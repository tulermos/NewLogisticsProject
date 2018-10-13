//
//  ReceivingRegistrationCell.m
//  Logistics
//
//  Created by tulemos on 2018/10/12.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "ReceivingRegistrationCell.h"

@implementation ReceivingRegistrationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{

    _noteLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x333333] text:nil];
    [self.contentView addSubview:_noteLabel];
    _dateLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x666666] text:nil];
    [self.contentView addSubview:_dateLabel];
    _receiveLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    [self.contentView addSubview:_receiveLabel];
    _receiveStateLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    [self.contentView addSubview:_receiveStateLabel];
    [self makeConstraint];
    
}

-(void)makeConstraint
{
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(234);
        make.height.mas_equalTo(21);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(234);
        make.height.mas_equalTo(18);
        make.top.equalTo(self.contentView.mas_top).offset(16);
    }];
    [_receiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(234);
        make.height.mas_equalTo(18);
        make.top.equalTo(self.noteLabel.mas_bottom).offset(4);
    }];
    [_receiveStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-70);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(18);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
