//
//  JPushManager.h
//  Logistics
//
//  Created by meng wang on 2018/4/27.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JPushModel;
@interface JPushManager : NSObject

+ (void)addAlias;

+ (void)removeAlias;

//获取所有的推送对象
+ (NSArray *)getJPushObjects;
//添加推送对象
+ (void)addJPushObject:(JPushModel *)model;
//移除某个推送对象
+ (void)removeJPushObject:(JPushModel *)model;
//移除推送
+ (void)removeJPushObjectForIndex:(NSInteger)index;
//修改model
+ (void)updateJPushObject:(JPushModel *)model;

@end
