//
//  NSDate+category.h
//  风车医生
//
//  Created by meng wang on 2017/5/26.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (category)

+ (NSString *)scheduleDateFormat:(NSTimeInterval)timeInterval;

//yyyy-MM-dd HH:mm
+ (NSString *)dateStrForHHMMInterval:(NSTimeInterval)timeInterval;

///yyyy年MM月dd日
+ (NSString *)dateStrWithInterval:(NSTimeInterval)timeInterval;
//*岁*月*天
+ (NSString *)birthStrWithInterval:(NSTimeInterval)timeInterval;
//MM-DD HH:mm
+ (NSString *)dateStrForMMDD:(NSTimeInterval)timeInterval;
///yyyy-MM-dd HH:mm:ss
+ (NSString *)dateStrForTimeInterval:(NSTimeInterval)timeInterval;

///forinterval 是否超出了forinterval
+ (BOOL)timeOutFromTime:(NSTimeInterval)fromInterval forTime:(NSTimeInterval)forInterval;


@end
