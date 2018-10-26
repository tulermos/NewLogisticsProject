//
//  WaybillTableViewCell.m
//  Logistics
//
//  Created by meng wang on 2018/4/21.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WaybillTableViewCell.h"
#import "WaybillModel.h"
#import "ConsignmentNoteModel.h"
@interface WaybillTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceTitle;
@property (weak, nonatomic) IBOutlet UILabel *sumTitle;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

@end

@implementation WaybillTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
}

- (void)setModel:(WaybillModel *)model {
    _model = model;
    self.noLabel.text = model.EntNumber;
    self.timeLabel.text = model.EntTime;
    self.locationLabel.text = [NSString stringWithFormat:@"%@-%@",model.EntStartID,model.EntEndID];
    self.countLabel.text = [NSString stringWithFormat:@"%@:%@%@",NSLocalizedString(@"Home_jianshu", nil),model.Number,NSLocalizedString(@"Home_jianshu_units", nil)];
    self.weightLabel.text = [NSString stringWithFormat:@"%@:%@%@",NSLocalizedString(@"Home_weight", nil),model.Weight,NSLocalizedString(@"Home_weight_units", nil)];
    self.volumeLabel.text = [NSString stringWithFormat:@"%@:%@%@",NSLocalizedString(@"Home_lifang", nil),model.Cube,NSLocalizedString(@"Home_lifang_units", nil)];
    self.priceTitle.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"Home_zongfeiyong", nil)];
    self.priceLabel.text = [NSString stringWithFormat:@"$%@",model.Sum];
    self.sumTitle.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"Home_feiyong_price", nil)];
    self.sumLabel.text = [NSString stringWithFormat:@"$%@",model.DShiSum];
}

- (void)setCNModel:(ConsignmentNoteModel *)CNModel {
    _CNModel = CNModel;
    self.noLabel.text = CNModel.EntNumber;
    self.timeLabel.text = CNModel.EntTime;
    self.locationLabel.text = [NSString stringWithFormat:@"%@-%@",CNModel.EntStartID,CNModel.EntEndID];
    self.countLabel.text = [NSString stringWithFormat:@"%@:%@%@",NSLocalizedString(@"Home_jianshu", nil),CNModel.SdNumber,NSLocalizedString(@"Home_jianshu_units", nil)];
    self.weightLabel.text = [NSString stringWithFormat:@"%@:%@%@",NSLocalizedString(@"Home_weight", nil),CNModel.SdWeight,NSLocalizedString(@"Home_weight_units", nil)];
    self.volumeLabel.text = [NSString stringWithFormat:@"%@:%@%@",NSLocalizedString(@"Home_lifang", nil),CNModel.SdCube,NSLocalizedString(@"Home_lifang_units", nil)];
    self.priceTitle.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"Home_zongfeiyong", nil)];
    self.priceLabel.text = [NSString stringWithFormat:@"$%@",CNModel.ShiSum];
    self.sumTitle.text = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"Home_feiyong_price", nil)];
//    self.sumLabel.text = [NSString stringWithFormat:@"$%@",CNModel.DShiSum];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
