//
//  CustomerStatisiticsDetailViewController.h
//  Logistics
//
//  Created by tulemos on 2018/10/26.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsignmentNoteCell.h"
#import "ConsignmentNoteModel.h"
#import "WaybillTableViewCell.h"
#import "WaybillModel.h"
#import "WaybillDetailViewController.h"
#import "WaybillQueryHeaderView.h"
#import "ReceivingRegistrationModel.h"
#import "WaybillQueryFooterView.h"
#import "AdvancedQueryViewController.h"
#import "ViewController.h"
#define ktableViewKey  @"ktableViewKey"
NS_ASSUME_NONNULL_BEGIN

@interface CustomerStatisiticsDetailViewController : ViewController

@property (nonatomic,copy) NSString *cusId;

@end

NS_ASSUME_NONNULL_END
