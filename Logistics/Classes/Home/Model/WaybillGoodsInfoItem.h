//
//  WaybillGoodsInfoItem.h
//  Logistics
//
//  Created by meng wang on 2018/4/23.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaybillGoodsInfoItem : NSObject

@property (nonatomic, strong)NSString *GoodsName;
@property (nonatomic, strong)NSString *Brand;
@property (nonatomic, strong)NSString *Texture;
@property (nonatomic, strong)NSString *Qty;
@property (nonatomic, strong)NSString *Cube;
@property (nonatomic, strong)NSString *Weight;
@property (nonatomic, strong)NSString *Number;
@property (nonatomic, strong)NSString *State;
@property (nonatomic, strong)NSString *dstate;
@property (nonatomic, strong)NSString *disstate;
@property (nonatomic, strong)NSString *ETA;
@property (nonatomic, strong)NSString *ShiCurrOrganizition;

//custom 
@property (nonatomic, assign)BOOL isLastObj;

@end
