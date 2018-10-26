//
//  AnnouncementModel.h
//  Logistics
//
//  Created by tulemos on 2018/10/24.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnouncementModel : NSObject
@property (nonatomic, strong)NSString *NewsId;
@property (nonatomic, strong)NSString *NewTimes;
@property (nonatomic, strong)NSString *Introduction;
@property (nonatomic, strong)NSString *Contents;
/*
"NewsId":  "22e3dffa2c1-45ce-bdf-efd8a403af1b",
"NewTimes":  "2018-10-12",
"Introduction": "物流系统测试通知",
"Contents": "各位忠佳总公司、分公司的领导、朋友们"
 */

@end

NS_ASSUME_NONNULL_END
