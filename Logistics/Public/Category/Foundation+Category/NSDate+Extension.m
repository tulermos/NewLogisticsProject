//
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

- (BOOL)isTimeOutIndexDayWith:(NSInteger)index{
    
    NSTimeInterval time_interval = [self timeIntervalSinceNow];
    if (time_interval < 0) {
        if (ABS(time_interval) > 60 * 60 * 24 * index ) {
            return YES;
        }
    }
    return NO;
}

-(NSString *)stringWithyyyyBarMMBarddfmt{
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
    });

    return [formatter stringFromDate:self];
}
-(NSString *)stringWithyyBarMMBarddfmt{
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yy/MM/dd";
    });
    
    return [formatter stringFromDate:self];

}
-(NSString *)stringWithyyyyBarMMBarddHHmmssfmt{
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    
    return [formatter stringFromDate:self];
    
}
+ (NSDate *)dateWithyyyyBarMMBarddHHmmssfmtormatString:(NSString *)dateString {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return [formatter dateFromString:dateString];
}

-(NSString *)stringWithMMBarddfmt{
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM/dd";
    });
    
    return [formatter stringFromDate:self];
}
+ (NSMutableArray *)stringChartsArrayWithArrayDate:(NSArray <NSDate *>*)arrayDate{
    
    if (arrayDate.count == 0)return [NSMutableArray array];
    
    NSMutableArray * array_m = [NSMutableArray arrayWithCapacity:arrayDate.count];
    
    for (int i = 0; i < arrayDate.count; i++) {
        
        NSDate * date = arrayDate[i];
        
        [array_m addObject:date.stringWithyyBarMMBarddfmt];
        
    }
    
    
    return array_m;
}


- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}
-(NSString *)weekdayChinses{
    
    NSInteger index = self.weekday;
        switch (index) {
            case 1:
                return @"周日";
                break;
            case 2:
                return @"周一";
                break;
            case 3:
                return @"周二";
                break;
            case 4:
                return @"周三";
                break;
            case 5:
                return @"周四";
                break;
            case 6:
                return @"周五";
                break;
            case 7:
                return @"周六";
                break;
            default:
//                CHLog(@"swith星期错误");
                break;
        }
        return @"";
}


-(NSInteger)weekdayChinsesIndex{
    
    NSInteger index = self.weekday;
    switch (index) {
        case 1:
            return 7;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 3;
            break;
        case 5:
            return 4;
            break;
        case 6:
            return 5;
            break;
        case 7:
            return 6;
            break;
        default:
//            CHLog(@"swith星期错误");
            break;
    }
    return 1;
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (BOOL)isYesterday {
    NSDate *added = [self dateByAddingDays:1];
    return [added isToday];
}

- (NSDate *)dateByAddingYears:(NSInteger)years {
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingHours:(NSInteger)hours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

- (NSString *)stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

- (NSString *)stringWithISOFormat {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithISOFormatString:(NSString *)dateString {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithyyyyMMddTHHmmssSSSZFormatString:(NSString *)dateString {
    
    
    if ([dateString isKindOfClass:[NSNull class]]) {
        return nil;
    }
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =
        @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    });
    return [formatter dateFromString:dateString];
}

+(NSArray *)dateArrayWithDayCount:(NSInteger)count{
    
    
    NSMutableArray * array_date = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++) {
        NSDate  * date = [NSDate dateWithTimeIntervalSinceNow:-i * 24* 60 *60 ];
        
        [array_date insertObject:date atIndex:0];
    }
    return [NSDate stringChartsArrayWithArrayDate:array_date];
}


- (NSString *)stringDietTimeFormatter{
    
    if (self.isToday) {
        return @"今日";
        
    }else if (self.isYesterday){
        return @"昨日";
        
    } else if (self.isThisYear){
        
        return [NSString stringWithFormat:@"%02zd/%02zd",self.month,self.day];
    }else{
        
        return [NSString stringWithFormat:@"%zd/%02zd/%02zd",self.year,self.month,self.day];
        
    }
}

- (NSString *)stringSportTimeFormatter{
    
    if (self.isToday) {
        return [NSString stringWithFormat:@"今日 | %02zd:%02zd",self.hour,self.minute];
        
    }else if (self.isYesterday){
        return [NSString stringWithFormat:@"昨日 | %02zd:%02zd",self.hour,self.minute];
        
    } else if (self.isThisYear){
        
        return [NSString stringWithFormat:@"%02zd/%02zd | %02zd:%02zd",self.month,self.day,self.hour,self.minute];
    }else{
        return [NSString stringWithFormat:@"%zd/%02zd/%02zd | %02zd:%02zd",self.year,self.month,self.day,self.hour,self.minute];
        
    }
}
- (NSDate *)getFirstTime{
    
    NSString * string = self.stringWithyyyyBarMMBarddfmt;
    
    return [NSDate dateWithString:string format:@"yyyy-MM-dd"];
    
}

- (NSDate *)getLastTime{
    
    NSString * string = self.stringWithyyyyBarMMBarddfmt;
    
    NSDate * date = [NSDate dateWithString:string format:@"yyyy-MM-dd"];
    return [date dateByAddingDays:1];
}

@end
