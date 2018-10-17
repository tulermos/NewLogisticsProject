//
//  AddressBookTableViewCell.m
//  Logistics
//
//  Created by meng wang on 2018/4/24.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "AddressBookTableViewCell.h"

@interface AddressBookTableViewCell()

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *telLabel;
@property (nonatomic, strong)UIImageView *telIcon;

@end

@implementation AddressBookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.nameLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:333333] text:nil];
    self.telLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    self.telIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dianhua"]];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.telLabel];
    [self.contentView addSubview:self.telIcon];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(15);
        make.leading.mas_equalTo(self.contentView).offset(20);
        make.trailing
        .mas_lessThanOrEqualTo(_telIcon.mas_leading).offset(-20);
    }];
    [_telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(_nameLabel);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(6);
    }];
    [_telIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).offset(-45);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
}

- (void)setupName:(NSString *)name tel:(NSString *)tel {
    if (name.length) {
         self.nameLabel.text = name;
    }else{
        self.nameLabel.text = @"";
    }
    if (tel.length) {
        self.telLabel.text = tel;
    }else{
        self.telLabel.text = @"";
    }
   
   
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
