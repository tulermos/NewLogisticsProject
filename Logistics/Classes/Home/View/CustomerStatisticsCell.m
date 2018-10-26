//
//  CustomerStatisticsCell.m
//  Logistics
//
//  Created by tulemos on 2018/10/14.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "CustomerStatisticsCell.h"

@implementation CustomerStatisticsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    _nameLabel = [UILabel labelWithFont:15 textColor:[UIColor colorWithHex:0x333333] text:nil];
    _nameLabel.frame = CGRectMake(15, 15, 200, 21);
    [self.contentView addSubview:_nameLabel];
    _numLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x666666] text:nil];
    _numLabel.frame = CGRectMake(FCWidth-97, 15, 97, 18);
    [self.contentView addSubview:_numLabel];
    _countLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    _countLabel.frame = CGRectMake(15, CGRectGetMaxY(_nameLabel.frame)+4,(FCWidth-97)/3, 18);
    [self.contentView addSubview:_countLabel];
    _baoLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    _baoLabel.frame = CGRectMake(15+(FCWidth-97)/3, CGRectGetMaxY(_nameLabel.frame)+4,(FCWidth-97)/3, 18);
    [self.contentView addSubview:_baoLabel];
    _CubeLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    _CubeLabel.frame = CGRectMake(15+(FCWidth-97)/3*2, CGRectGetMaxY(_nameLabel.frame)+4,(FCWidth-97)/3, 18);
    [self.contentView addSubview:_CubeLabel];
    _weightLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    _weightLabel.frame = CGRectMake(15, 62,FCWidth-215, 18);
    [self.contentView addSubview:_weightLabel];
    _totalLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    _totalLabel.frame = CGRectMake(CGRectGetMaxX(_weightLabel.frame), 62,200, 18);
    [self.contentView addSubview:_totalLabel];
    
    _seeBtn = [UIButton buttonWithType:0];
    _seeBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:237/255.0 blue:251/255.0 alpha:1/1.0];
    _seeBtn.frame = CGRectMake(FCWidth-65, 50, 50, 30);
    [_seeBtn setTitle:@"查看" forState:0];
    [_seeBtn setTitleColor:[UIColor colorWithRed:86/255.0 green:124/255.0 blue:212/255.0 alpha:1/1.0] forState:0];
    _seeBtn.layer.cornerRadius = _seeBtn.height/2;
    _seeBtn.layer.masksToBounds = YES;
    [_seeBtn addTarget:self action:@selector(seeBtnAction:) forControlEvents:1<<6];
    _seeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [self.contentView addSubview:_seeBtn];
    
    
}
-(void)setModel:(CustomerStatisticsModel *)model
{
    _model = model;
    _nameLabel.text = model.CusName;
    _numLabel.text =[NSString stringWithFormat:@"货号:%@",model.CusNumber];
    _countLabel.text = [NSString stringWithFormat:@"单据数量:%@",model.CQty];
    _baoLabel.text = [NSString stringWithFormat:@"单据数量:%@",model.Qty];
    _CubeLabel.text = [NSString stringWithFormat:@"总体积:%@",model.Cube];
    _weightLabel.text = [NSString stringWithFormat:@"总重量:%@",model.Weight];
    _totalLabel.text =[NSString stringWithFormat:@"应收合计:￥:%@",model.Total];
    
}

-(void)seeBtnAction:(UIButton *)btn
{
    
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
