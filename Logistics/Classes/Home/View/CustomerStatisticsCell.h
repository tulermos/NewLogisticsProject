//
//  CustomerStatisticsCell.h
//  Logistics
//
//  Created by tulemos on 2018/10/14.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerStatisticsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomerStatisticsCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLabel;//
@property (nonatomic,strong) UILabel *numLabel;//
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *baoLabel;//
@property (nonatomic,strong) UILabel *weightLabel;//
@property (nonatomic,strong) UILabel *totalLabel;//
@property (nonatomic,strong) UILabel *CubeLabel;//
@property (nonatomic,strong) UIButton *seeBtn;//
@property (nonatomic,strong) CustomerStatisticsModel*model;
@end

NS_ASSUME_NONNULL_END
