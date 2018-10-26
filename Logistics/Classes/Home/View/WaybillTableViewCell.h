//
//  WaybillTableViewCell.h
//  Logistics
//
//  Created by meng wang on 2018/4/21.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaybillModel;

@class ConsignmentNoteModel;

@interface WaybillTableViewCell : UITableViewCell

@property (nonatomic, strong)WaybillModel *model;

@property (nonatomic, strong)ConsignmentNoteModel *CNModel;

@end
