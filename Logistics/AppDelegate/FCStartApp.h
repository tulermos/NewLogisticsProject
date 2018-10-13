//
//  FCStartApp.h
//  风车医生基础版
//
//  Created by meng wang on 2018/3/13.
//  Copyright © 2018年 FC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCStartApp : NSObject

+ (instancetype)sharedInstance;

//获取试图的根控制器
- (UIViewController *)fc_rootViewController;
+ (void)appVersionUpdate;
@end
