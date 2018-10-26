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
     _locationLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    [self.contentView addSubview:_locationLabel];
     _kindLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    [self.contentView addSubview:_kindLabel];
     _statusLabel = [UILabel labelWithFont:13 textColor:[UIColor colorWithHex:0x999999] text:nil];
    [self.contentView addSubview:_statusLabel];
    _ModifyBtn = [UIButton buttonWithType:0];
    _ModifyBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:237/255.0 blue:251/255.0 alpha:1/1.0];
    [_ModifyBtn setTitle:@"修改" forState:0];
    [_ModifyBtn setTitleColor:[UIColor colorWithRed:86/255.0 green:124/255.0 blue:212/255.0 alpha:1/1.0] forState:0];
    _ModifyBtn.layer.cornerRadius = 15;
    _ModifyBtn.layer.masksToBounds = YES;
    [_ModifyBtn addTarget:self action:@selector(ModifyBtnAction:) forControlEvents:1<<6];
    _ModifyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [self.contentView addSubview:_ModifyBtn];
}

-(void)makeConstraint
{
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.height.mas_equalTo(16.2);
        make.top.equalTo(self.contentView.mas_top).offset(39);
    }];
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(45);
        make.width.mas_equalTo(151);
        make.height.mas_equalTo(21);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(18);
        make.top.equalTo(self.contentView.mas_top).offset(16);
    }];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectBtn.mas_right).offset(11);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(18);
        make.top.equalTo(self.noteLabel.mas_bottom).offset(5);
    }];
    [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(45);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(18);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
    }];
    
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_kindLabel.mas_right).offset(40);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(18);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
    }];
}







-(void)setModel:(ConsignmentNoteModel *)model
{
    _model = model;
    _noteLabel.text = model.ShiNumber;
    _dateLabel.text = model.ShiTime;
    _locationLabel.text =[NSString stringWithFormat:@"%@%@",model.Company,model.Stockname];
   
    
}

-(void)setAnModel:(ArticleNumberModel *)anModel
{
    _anModel = anModel;
    _noteLabel.text = anModel.CasNo;
    _dateLabel.text = anModel.CasTime;
    _locationLabel.text =anModel.StoID;
    _kindLabel.text =[NSString stringWithFormat:@"货物:%@",anModel.CasGoods];
    _statusLabel.text = [NSString stringWithFormat:@"打包方式:%@",anModel.CasStyle];
}

-(void)setStatus:(NSInteger)status
{
    _status = status;
    if (status == 1) {
        [self makeConstraint];
         _ModifyBtn.hidden = YES;
        _selectBtn.hidden = NO;
    }else{
         [self makeMeaConstraint];
        _ModifyBtn.hidden = NO;
        _selectBtn.hidden = YES;
    }
}

-(void)setMeaModel:(MeaModel *)meaModel
{

    _meaModel = meaModel;
    _noteLabel.text = meaModel.MeaNo;
    _dateLabel.text = meaModel.MeaPackTime;
    _locationLabel.text = [NSString stringWithFormat:@"货物：%@",meaModel.CasGoods];
    
    _kindLabel.text =meaModel.StoID;
    
}


-(void)makeMeaConstraint
{
//    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(15);
//        make.width.height.mas_equalTo(16.2);
//        make.top.equalTo(self.contentView.mas_top).offset(39);
//    }];
    
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(151);
        make.height.mas_equalTo(21);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(18);
        make.top.equalTo(self.contentView.mas_top).offset(16);
    }];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(18);
        make.top.equalTo(self.noteLabel.mas_bottom).offset(5);
    }];
    [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(18);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
    }];

  
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_kindLabel.mas_right).offset(40);
        make.width.mas_equalTo(150);
         make.height.mas_equalTo(18);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
    }];
    [_ModifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.contentView.mas_top).offset(50);
    }];
}

-(void)ModifyBtnAction:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(ModifyOprateWithEntNum:)]) {
        if (_anModel) {
            [_delegate ModifyOprateWithEntNum:_anModel.EntNumber];
        }else{
            [_delegate ModifyOprateWithEntNum:_meaModel.MeaNo];
        }
        
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end

