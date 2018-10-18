//
//  ArticleNumberCell.h
//  Logistics
//
//  Created by tulemos on 2018/10/13.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsignmentNoteModel.h"
#import "MeaModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ArticleNumberCell : UITableViewCell
@property (nonatomic,strong) UILabel *noteLabel;//单号
@property (nonatomic,strong) UILabel *dateLabel;//时间
@property (nonatomic,strong) UILabel *locationLabel;//位置
@property (nonatomic,strong) UILabel *kindLabel;//种类
@property (nonatomic,strong) UILabel *statusLabel;//方式
@property (nonatomic,strong) UIButton *selectBtn;//选择按钮
@property (nonatomic,strong) ConsignmentNoteModel *model;
@property (nonatomic,strong) MeaModel *meaModel;
@end

NS_ASSUME_NONNULL_END
