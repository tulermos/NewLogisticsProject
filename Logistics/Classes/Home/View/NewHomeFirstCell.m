//
//  NewHomeFirstCell.m
//  Logistics
//
//  Created by tulemos on 2018/10/12.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "NewHomeFirstCell.h"

@implementation NewHomeFirstCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    NSArray *titleArr = @[@"收货单据",@"打包单据",@"计量单据",@"托运单"];
    NSArray *imgArr =  @[@"收货单据",@"打包单据",@"计量单据",@"托运单"];
    for (int i = 0; i < titleArr.count; i++)
    {
        NSInteger column = (i%6)%3;
        NSInteger r = (i%6/3);
//        _btn = [[FL_Button alloc] initWithFrame:CGRectMake(FCWidth/3*b, 85*a, FCWidth/3, 85)];
        _btn = [FL_Button fl_shareButton];
        _btn.frame = CGRectMake(FCWidth/3*column, 85*r, FCWidth/3, 85);
        _btn.status =FLAlignmentStatusTop;
        _btn.layer.borderColor =[UIColor colorWithHexString:@"0xf1f1f1"].CGColor;
        _btn.layer.borderWidth = 1;
        _btn.tag = i+100;
        _btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor colorWithHexString:@"0xf1f1f1"] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(tagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];
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
