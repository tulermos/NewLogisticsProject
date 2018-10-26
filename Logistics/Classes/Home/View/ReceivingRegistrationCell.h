//
//  ReceivingRegistrationCell.h
//  Logistics
//
//  Created by tulemos on 2018/10/12.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReceivingRegistrationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReceivingRegistrationCell : UITableViewCell

@property (nonatomic,strong) UILabel *noteLabel;//单号

@property (nonatomic,strong) UILabel *dateLabel;//时间

@property (nonatomic,strong) UILabel *receiveLabel;//收货人

@property (nonatomic,strong) UILabel *receiveStateLabel;//收货状态

@property (nonatomic,strong)ReceivingRegistrationModel *RRModel;

@end

NS_ASSUME_NONNULL_END
