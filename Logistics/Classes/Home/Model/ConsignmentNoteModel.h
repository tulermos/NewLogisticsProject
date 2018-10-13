//
//  ConsignmentNoteModel.h
//  Logistics
//
//  Created by tulemos on 2018/10/12.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConsignmentNoteModel : NSObject

@property (nonatomic, strong)NSString *ShiNumber;
@property (nonatomic, strong)NSString *ShiTime;
@property (nonatomic, strong)NSString *DelName;
@property (nonatomic, strong)NSString *EntRecName;
@property (nonatomic, strong)NSString *EntStartID;
@property (nonatomic, strong)NSString *EntEndID;
@property (nonatomic, strong)NSString *SdNumber;
@property (nonatomic, strong)NSString *EntPathType;
@property (nonatomic, strong)NSString *SdCube;
@property (nonatomic, strong)NSString *SdWeight;
@property (nonatomic, strong)NSString *ShiRate;
@property (nonatomic, strong)NSString *ShiSum;
@property (nonatomic, strong)NSString *ShiInsurance;
@property (nonatomic, strong)NSString *ShiRemark;
@property (nonatomic, strong)NSString *Company;
@property (nonatomic, strong)NSString *Stockname;
/*
"ShiNumber": "BJ-20181005-0125-2",
"ShiTime": "20181005",
"DelName": "发货人",
"EntRecName": "收货人",
"EntStartID": "北京分公司",
"EntEndID": "莫斯科",
“SdNumber”:”件数”,
“EntPathType”:”货运方式”,
“SdCube”:”立方”,
“SdWeight”:”重量”,
"ShiRate": "美元汇率",
"ShiSum": "合计金额",
 "ShiInsurance": "保险费",
 "ShiRemark": "别压坏",
 "Company": "北京分公司",
 "Stockname": "833库房"
 */
@end

NS_ASSUME_NONNULL_END
