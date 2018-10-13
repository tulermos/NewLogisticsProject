//
//  ConsignmentNoteCell.h
//  Logistics
//
//  Created by tulemos on 2018/10/12.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsignmentNoteModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ConsignmentNoteCell : UITableViewCell

@property (nonatomic,strong) UILabel *noteLabel;//单号

@property (nonatomic,strong) UILabel *dateLabel;//时间

@property (nonatomic,strong) UILabel *receiveInfoLabel;//物流信息

@property (nonatomic,strong) UILabel *countLabel;//收货状态

@property (nonatomic,strong) UILabel *weightLabel;//重量

@property (nonatomic,strong) UILabel *sizeLabel;//大小

@property (nonatomic,strong) ConsignmentNoteModel *model;

@end

NS_ASSUME_NONNULL_END
