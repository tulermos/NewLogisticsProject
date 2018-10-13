//
//  NSDate+category.m
//  风车医生
//
//  Created by meng wang on 2017/5/26.
//  Copyright © 2017年 FC. All rights reserved.
//

#import "NSDate+category.h"
#import "NSDate+Extension.h"

@implementation NSDate (category)

+ (NSString *)scheduleDateFormat:(NSTimeInterval)timeInterval {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSString *dateStr = [NSString stringWithFormat:@"%@ %@",[self dateStrWithInterval:timeInterval],[date weekdayChinses]];
    
    if ([date isToday]) {
        dateStr = [dateStr stringByAppendingString:@"(今天)"];
    }
    return dateStr;
}

+ (BOOL)timeOutFromTime:(NSTimeInterval)fromInterval forTime:(NSTimeInterval)forInterval {
    
    NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:fromInterval];
    NSDate *forDate = [NSDate dateWithTimeIntervalSince1970:forInterval];
    if ([fromDate compare:forDate] == NSOrderedAscending) {
        return YES;
    }else {
        return NO;
    }
}

+ (NSString *)dateStrForTimeInterval:(NSTimeInterval)timeInterval {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [format stringFromDate:date];
}

+ (NSString *)dateStrForHHMMInterval:(NSTimeInterval)timeInterval {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm";
    return [format stringFromDate:date];
}

+ (NSString *)dateStrWithInterval:(NSTimeInterval)timeInterval {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy年MM月dd日";
    return [format stringFromDate:date];
}

//MM-DD HH:mm
+ (NSString *)dateStrForMMDD:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"MM-dd HH:mm";
    return [format stringFromDate:date];
}

+ (NSString *)birthStrWithInterval:(NSTimeInterval)timeInterval {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDate *nowDate = [NSDate date];
    NSDate *birthDay = [NSDate dateWithTimeIntervalSinceNow:timeInterval * (-1)/1000];
    
    //用来得到详细的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthDay toDate:nowDate options:0];
    
    NSMutableString *birthDayStr = [NSMutableString string];
    if([date year] >0){
        [birthDayStr appendFormat:@"%ld岁",(long)[date year]];
    }
    if([date month] >0) {
        [birthDayStr appendFormat:@"%ld月",(long)[date month]];
    }
    if([date day] >0) {
        [birthDayStr appendFormat:@"%ld天",(long)[date day]];
    }
    return birthDayStr;
}

@end
