//
//  CustomerStatisticsModel.h
//  Logistics
//
//  Created by tulemos on 2018/10/14.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerStatisticsModel : NSObject

@property (nonatomic, copy)NSString *CusCode;
@property (nonatomic, copy)NSString *CusUniqueMarker;
@property (nonatomic, copy)NSString *CusName;
@property (nonatomic, copy)NSString *CusTel;
@property (nonatomic, copy)NSString *CasFee;
@property (nonatomic, copy)NSString *CusNumber;
@property (nonatomic, copy)NSString *Qty;
@property (nonatomic, copy)NSString *CQty;
@property (nonatomic, copy)NSString *Cube;
@property (nonatomic, copy)NSString *Weight;
@property (nonatomic, copy)NSString *DSum;
@property (nonatomic, copy)NSString *Sum;
@property (nonatomic, copy)NSString *Total;


@end
/*
"CusCode": "客户编号",
"CusUniqueMarker": "客户唯一编号",
"CusName": "客户名称",
"CusTel": "客户电话",
"CusNumber": "客户货号",
"Qty": "单据数量",
"CQty": "总包数",
"Cube": "体积",
"Weight": "重量",
"DSum": "应收合计$",
"Sum": "应收合计￥",
"DTotal": "货物总价值$",
"Total": "货物总价值￥",
 */

NS_ASSUME_NONNULL_END
