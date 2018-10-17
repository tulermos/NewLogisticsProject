//
//  TextViewCell.h
//  Logistics
//
//  Created by tulemos on 2018/10/15.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSLimitText.h"
NS_ASSUME_NONNULL_BEGIN

@interface TextViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLab;//

@property (nonatomic,strong) HSLimitText *textView; //

@end

NS_ASSUME_NONNULL_END
