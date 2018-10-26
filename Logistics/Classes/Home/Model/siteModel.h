//
//  siteModel.h
//  Logistics
//
//  Created by tulemos on 2018/10/26.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface siteModel : UIView

@property (nonatomic,copy) NSString *companyID;
@property (nonatomic,copy) NSString *companyName;
@property (nonatomic,copy) NSString *stockid;
@property (nonatomic,copy) NSString *stockname;
/*
"companyID": "8caac261-074d-4b0e-a65d-09dcc1a66d46",
"companyName": "莫斯科分公司"
*/
@end

NS_ASSUME_NONNULL_END
