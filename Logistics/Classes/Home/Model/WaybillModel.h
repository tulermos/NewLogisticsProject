//
//  WaybillModel.h
//  Logistics
//
//  Created by meng wang on 2018/4/21.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaybillModel : NSObject

@property (nonatomic, strong)NSString *Cube;
@property (nonatomic, strong)NSString *CusCall1;
@property (nonatomic, strong)NSString *CusTel1;
@property (nonatomic, strong)NSString *CusUniqueMarker;
@property (nonatomic, strong)NSString *DShiSum;
@property (nonatomic, strong)NSString *DelName;
@property (nonatomic, strong)NSString *EntEndID;
@property (nonatomic, strong)NSString *EntNumber;
@property (nonatomic, strong)NSString *EntStartID;
@property (nonatomic, strong)NSString *EntTime;
@property (nonatomic, strong)NSString *Number;
@property (nonatomic, assign)CGFloat Qty;
@property (nonatomic, strong)NSString *ShiNumber;
@property (nonatomic, strong)NSString *ShiRate;
@property (nonatomic, strong)NSString *ShiSum;
@property (nonatomic, strong)NSString *Sum;
@property (nonatomic, assign)NSInteger SumType;
@property (nonatomic, strong)NSString *Weight;

@end
