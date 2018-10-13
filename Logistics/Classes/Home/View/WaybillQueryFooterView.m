//
//  WaybillQueryFooterView.m
//  Logistics
//
//  Created by meng wang on 2018/4/25.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WaybillQueryFooterView.h"

@interface WaybillQueryFooterView ()
@property (weak, nonatomic) IBOutlet UILabel *yfLabel;
@property (weak, nonatomic) IBOutlet UILabel *jsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dsfLabel;
@property (weak, nonatomic) IBOutlet UILabel *zlLabel;
@property (weak, nonatomic) IBOutlet UILabel *dsyfLabel;
@property (weak, nonatomic) IBOutlet UILabel *tjLabel;

@end

@implementation WaybillQueryFooterView

+ (instancetype)footerView {
    return [[[NSBundle mainBundle]loadNibNamed:@"WaybillQueryFooterView" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
}

- (void)setYf:(CGFloat)yf {
    _yf = yf;
    self.yfLabel.text = [NSString stringWithFormat:@"%@%.2lf",NSLocalizedString(@"Home_footer_yf", nil),yf];
}
- (void)setJs:(CGFloat)js {
    _js = js;
    self.jsLabel.text = [NSString stringWithFormat:@"%@%.2lf%@",NSLocalizedString(@"Home_footer_js", nil),js,NSLocalizedString(@"Home_jianshu_units", nil)];
}
- (void)setDsf:(CGFloat)dsf {
    _dsf = dsf;
    self.dsfLabel.text = [NSString stringWithFormat:@"%@%.2lf",NSLocalizedString(@"Home_footer_dsk", nil),dsf];
}
- (void)setZl:(CGFloat)zl {
    _zl = zl;
    self.zlLabel.text = [NSString stringWithFormat:@"%@%.2lf%@",NSLocalizedString(@"Home_footer_zl", nil),zl,NSLocalizedString(@"Home_weight_units", nil)];
}
- (void)setDsyf:(CGFloat)dsyf {
    _dsyf = dsyf;
    self.dsyfLabel.text = [NSString stringWithFormat:@"%@%.2lf",NSLocalizedString(@"Home_footer_dsyf", nil),dsyf];
}
- (void)setTj:(CGFloat)tj {
    _tj = tj;
    self.tjLabel.text = [NSString stringWithFormat:@"%@%.3lf%@",NSLocalizedString(@"Home_footer_tj", nil),tj,NSLocalizedString(@"Home_lifang_units", nil)];
}

@end
