//
//  WaybillDetailHeaderView.m
//  Logistics
//
//  Created by meng wang on 2018/4/23.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WaybillDetailHeaderView.h"

@interface WaybillDetailHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@end

@implementation WaybillDetailHeaderView

+ (instancetype)headerView {
    return [[NSBundle mainBundle]loadNibNamed:@"WaybillDetailHeaderView" owner:nil options:nil].lastObject;
}
- (void)setupWithStart:(NSString *)start end:(NSString *)end {
    self.startLabel.text = start;
    self.endLabel.text = end;
}

@end
