//
//  MeaModel.h
//  Logistics
//
//  Created by tulemos on 2018/10/18.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeaModel : NSObject

@property (nonatomic,copy) NSString *MeaNo;

@property (nonatomic,copy) NSString *MeaPackTime;

@property (nonatomic,copy) NSString *CasGoods;

@property (nonatomic,copy) NSString *MeaWeight;

@property (nonatomic,copy) NSString *MeaLong;

@property (nonatomic,copy) NSString *MeaWide;

@property (nonatomic,copy) NSString *MeaHigh;

@property (nonatomic,copy) NSString *MeaCuic;

@property (nonatomic,copy) NSString *MeaDensity;

@property (nonatomic,copy) NSString *Seal;

@property (nonatomic,copy) NSString *MeaRemark;

@end
/*
MeaNo    时间
MeaPackTime    包号
CasGoods    货物
MeaWeight    重
MeaLong    长
MeaWide    宽
MeaHigh    高
MeaCuic    立方
MeaDensity    密度
Seal    封签
MeaRemark    备注
 */
NS_ASSUME_NONNULL_END
