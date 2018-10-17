//
//  TextViewCell.m
//  Logistics
//
//  Created by tulemos on 2018/10/15.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    _titleLab = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x666666] text:nil];
    _titleLab.text = @"开始时间:";
    _titleLab.frame =CGRectMake(15, 12, 79, 26);
    [self.contentView addSubview:_titleLab];
    
//    HSLimitText *textView = [[HSLimitText alloc] initWithFrame:CGRectMake(cgrect, 27+TB_StatusBarHeightSegment, FCWidth-71, 28) type:TextInputTypeTextfield];
//    textView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
//    textView.labPlaceHolder.textColor = [UIColor colorWithHexString:@"0x999999"];
//    textView.labPlaceHolder.font = [UIFont systemFontOfSize:15];
//    textView.textField.textColor = [UIColor blackColor];
//    textView.textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
//    textView.textField.returnKeyType = UIReturnKeySearch;
//    textView.delegate = self;
//    textView.textField.delegate = self;
    
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
