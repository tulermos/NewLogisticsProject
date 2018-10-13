//
//  ConsignmentNoteCell.m
//  Logistics
//
//  Created by tulemos on 2018/10/12.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "ConsignmentNoteCell.h"

@implementation ConsignmentNoteCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
     [self.contentView addSubview:_noteLabel];
     [self.contentView addSubview:_dateLabel];
     [self.contentView addSubview:_receiveInfoLabel];
     [self.contentView addSubview:_countLabel];
     [self.contentView addSubview:_weightLabel];
     [self.contentView addSubview:_sizeLabel];
    
}
-(void)setModel:(ConsignmentNoteModel *)model
{
    _model = model;
    _noteLabel.text = model.ShiNumber;
    _dateLabel.text = model.ShiTime;
    _receiveInfoLabel.text = model.ShiNumber;
    _countLabel.text = model.SdNumber;
    _weightLabel.text = model.SdWeight;
    _sizeLabel.text = model.SdCube;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x333333] text:nil];
        _noteLabel.frame = CGRectMake(15, 15, FCWidth/2, 21);
        _noteLabel.numberOfLines = 0;
    }
    return  _noteLabel;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x666666] text:nil];
        _dateLabel.frame = CGRectMake(15, CGRectGetMaxY(_noteLabel.frame)+6, FCWidth, 18);
        _dateLabel.numberOfLines = 0;
    }
    return  _dateLabel;
}
- (UILabel *)receiveInfoLabel {
    if (!_receiveInfoLabel) {
        _receiveInfoLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x333333] text:nil];
        _receiveInfoLabel.frame = CGRectMake(15, CGRectGetMaxY(_dateLabel.frame)+6, FCWidth, 18);
        _receiveInfoLabel.numberOfLines = 0;
    }
    return  _receiveInfoLabel;
}
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel labelWithFont:14 textColor:[UIColor colorWithHex:0x999999] text:nil];
         _countLabel.frame = CGRectMake(15, CGRectGetMaxY(_receiveInfoLabel.frame)+6,(FCWidth-30)/3, 18);
        _countLabel.numberOfLines = 0;
    }
    return  _countLabel;
}
- (UILabel *)weightLabel {
    if (!_weightLabel) {
        _weightLabel = [UILabel labelWithFont:14 textColor:[UIColor colorWithHex:0x999999] text:nil];
         _weightLabel.frame = CGRectMake(15, CGRectGetMaxY(_receiveInfoLabel.frame)+6,(FCWidth-30)/3, 18);
        _weightLabel.numberOfLines = 0;
    }
    return  _weightLabel;
}
- (UILabel *)sizeLabel {
    if (!_sizeLabel) {
        _sizeLabel = [UILabel labelWithFont:14 textColor:[UIColor colorWithHex:0x999999] text:nil];
        _sizeLabel.frame = CGRectMake(15, CGRectGetMaxY(_receiveInfoLabel.frame)+6,(FCWidth-30)/3, 18);
        _sizeLabel.numberOfLines = 0;
    }
    return  _sizeLabel;
}
@end
