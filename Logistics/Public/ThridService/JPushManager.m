//
//  JPushManager.m
//  Logistics
//
//  Created by meng wang on 2018/4/27.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "JPushManager.h"
#import <JPush/JPUSHService.h>
#import "JPushModel.h"

@implementation JPushManager

+ (void)addAlias {
    if ([[UserManager sharedManager].user.cusAlias length] == 0) return;
    [JPUSHService setAlias:[UserManager sharedManager].user.cusAlias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"绑定别名Alias:%@ state:%@",iAlias,!iResCode?@"成功":@"失败");
    } seq:0];
}

+ (void)removeAlias {
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
         NSLog(@"删除别名Alias:%@ state:%@",iAlias,!iResCode?@"成功":@"失败");
    } seq:0];
}

+ (void)addJPushObject:(JPushModel *)model {
    NSString *key = [self JPushDataKey];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self getJPushObjects]];
    if (!array) {
        array = [NSMutableArray array];
    }
    [array addObject:model];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationNameJpushChange object:nil];
}

+ (void)removeJPushObject:(JPushModel *)model {
    NSString *key = [self JPushDataKey];
    NSMutableArray *array =  [NSMutableArray arrayWithArray:[self getJPushObjects]];
    [array removeObject:model];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (void)removeJPushObjectForIndex:(NSInteger)index {
    NSString *key = [self JPushDataKey];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self getJPushObjects]];
    [array removeObjectAtIndex:index];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (void)updateJPushObject:(JPushModel *)model {
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self getJPushObjects]];
    for (JPushModel *dataModel in array) {
        if ([model.id isEqualToString:dataModel.id]) {
            dataModel.isRead = model.isRead;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
            [[NSUserDefaults standardUserDefaults]setObject:data forKey:[self JPushDataKey]];
            [[NSUserDefaults standardUserDefaults]synchronize];
            return;
        }
    }
}

+ (NSArray *)getJPushObjects {
    NSString *key = [self JPushDataKey];
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array;
}

+ (NSString *)JPushDataKey {
    return [NSString stringWithFormat:@"%@.archive",[UserManager sharedManager].user.cusAlias];
}

@end
