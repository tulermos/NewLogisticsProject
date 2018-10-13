//
//  NSString+WJ.h
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (WJ)

+ (NSString *)configUrl:(NSString *)url With:(NSArray *)keys values:(NSArray *)values;
+ (BOOL) isBlankString:(NSString *)string;
//+ (BOOL) isMobileNumber:(NSString *)mobileNum;
//验证身份证号
+ (BOOL)checkUserIdCard:(NSString *)idCard;
+ (BOOL) isZipCode:(NSString *)codenum;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
+ (BOOL) isVaildPhoneNumber:(NSString *)phoneNum;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSString *)With:(NSArray *)keys values:(NSArray *)values;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (NSString *)disable_emoji:(NSString *)text;

+ (NSString *)stringFromJson:(NSDictionary *)json;

+ (NSString *)stringRemoveHTML:(NSString *)str;
//中文编码
+ (NSString *)encodedString:(NSString *)str;
//中文解码
+ (NSString *)decodedString:(NSString *)str;

//获取手机型号
+ (NSString*)deviceVersion;

//获取app版本号
+(NSString*)appVersion;

//获取设备号
+(NSString*)uuidVersion;

//获取剩余内存
+ (NSString *)freeDiskSpaceInBytes;

//获取系统型号
+ (NSString*)systemVersion;

//秒转换为时分秒
+ (NSString*)timeFormatted:(int)totalSeconds;
//log信息
+ (NSString *)logMessage;

@end
