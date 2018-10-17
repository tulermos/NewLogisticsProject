//
//  pickerCell.m
//  Logistics
//
//  Created by tulemos on 2018/10/15.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "pickerCell.h"

@implementation pickerCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    _titleLab = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x666666] text:nil];
    _titleLab.frame =CGRectMake(15, 12, 64, 26);
    [self.contentView addSubview:_titleLab];
    _subTitleLab = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x666666] text:nil];
    _subTitleLab.frame =CGRectMake(CGRectGetMaxX(_titleLab.frame)+12, 12,200, 26);
    [self.contentView addSubview:_subTitleLab];
    _bottomArrow = [[UIImageView alloc]initWithFrame:CGRectMake(FCWidth-33, 12, 13, 9)];
    _bottomArrow.image = [UIImage imageNamed:@"向下箭头"];
    _bottomArrow.centerY = _subTitleLab.centerY;
    [_bottomArrow sizeToFit];
    [self.contentView addSubview:_bottomArrow];
    
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
