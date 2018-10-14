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

@property (nonatomic, copy)NSString *ShiNumber;
@property (nonatomic, copy)NSString *ShiTime;
@property (nonatomic, copy)NSString *DelName;
@property (nonatomic, copy)NSString *EntRecName;
@property (nonatomic, copy)NSString *EntStartID;
@property (nonatomic, copy)NSString *EntEndID;
@property (nonatomic, copy)NSString *SdNumber;
@property (nonatomic, copy)NSString *EntPathType;
@property (nonatomic, copy)NSString *SdCube;
@property (nonatomic, copy)NSString *SdWeight;
@property (nonatomic, copy)NSString *ShiRate;
@property (nonatomic, copy)NSString *ShiSum;
@property (nonatomic, copy)NSString *ShiInsurance;
@property (nonatomic, copy)NSString *ShiRemark;
@property (nonatomic, copy)NSString *Company;
@property (nonatomic, copy)NSString *Stockname;
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
