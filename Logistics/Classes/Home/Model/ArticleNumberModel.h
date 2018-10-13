//
//  ArticleNumberModel.h
//  Logistics
//
//  Created by tulemos on 2018/10/13.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleNumberModel : NSObject

@property (nonatomic, strong)NSString *CasNo;
@property (nonatomic, strong)NSString *CasStartDate;
@property (nonatomic, strong)NSString *CasGoods;
@property (nonatomic, strong)NSString *CasStyle;
@property (nonatomic, strong)NSString *CasFee;
@property (nonatomic, strong)NSString *FactFee;
@property (nonatomic, strong)NSString *CasPackFee;
@property (nonatomic, strong)NSString *CasRemark;
@property (nonatomic, strong)NSString *AddID;
@property (nonatomic, strong)NSString *EntRecID;
@end

NS_ASSUME_NONNULL_END
