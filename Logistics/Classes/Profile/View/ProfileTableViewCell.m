//
//  ProfileTableViewCell.m
//  Logistics
//
//  Created by meng wang on 2018/4/22.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "ProfileTableViewCell.h"

@interface ProfileTableViewCell()

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *accessView;
@property (nonatomic, strong)UIView *redView;

@end

@implementation ProfileTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.icon = [[UIImageView alloc]init];
    self.titleLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x333333] text:nil];
    self.accessView = [UIButton buttonWithFont:12 normalColor:[UIColor colorWithHex:0x999999] selectedColor:nil title:nil];
    self.redView = [[UIView alloc]init];
    _redView.backgroundColor = [UIColor redColor];
    _redView.layer.cornerRadius = 3;
    _redView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.accessView];
    [self.contentView addSubview:self.redView];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(15);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_icon.mas_trailing).offset(15);
        make.centerY.mas_equalTo(_icon);
        make.trailing.mas_equalTo(self.contentView).offset(-80);
    }];
    [self.accessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(_accessView).offset(3);
        make.top.mas_equalTo(_accessView).offset(3);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
}

- (void)setupIcon:(NSString *)icon title:(NSString *)title accessView:(id)object {
    self.icon.image = [UIImage imageNamed:icon];
    self.titleLabel.text = title;
    if ([object isKindOfClass:[NSString class]]) {
        [self.accessView setTitle:object forState:UIControlStateNormal];
    }else if ([object isKindOfClass:[UIImage class]]) {
        [self.accessView setImage:object forState:UIControlStateNormal];
    }
}

- (void)showRedBadge:(BOOL)isShow {
    self.redView.hidden = !isShow;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
