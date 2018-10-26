//
//  ReceivingRegistrationModel.h
//  Logistics
//
//  Created by tulemos on 2018/10/12.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceivingRegistrationModel : NSObject

@property (nonatomic, copy)NSString *EntNumber;
@property (nonatomic, copy)NSString *EntTime;
@property (nonatomic, copy)NSString *DelName;
@property (nonatomic, copy)NSString *EntRecName;
@property (nonatomic, copy)NSString *EntStartID;
@property (nonatomic, copy)NSString *EntEndID;
@property (nonatomic, copy)NSString *EntState;
@property (nonatomic, copy)NSString *EntType;
@property (nonatomic, copy)NSString *EntRemark;
/*
"EntNumber": "G106M2-171215-12",
"EntTime": "2018-01-01 04:41:40",
"DelName": "孟祥丽",
"EntRecName": "孟祥丽",
"EntStartID": "广州分公司",
"EntEndID": "叶卡捷琳堡分公司",
"EntState": "未受理",
"EntType": "正常",
"EntRemark": "压  男冲锋衣服装 尹自新垫付520  12月31号打包",
 */


@end

NS_ASSUME_NONNULL_END
