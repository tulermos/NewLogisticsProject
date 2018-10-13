//
//  CompanyInfoModel.m
//  Logistics
//
//  Created by meng wang on 2018/4/27.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "CompanyInfoModel.h"

@implementation CompanyInfoModel

- (void)setCompanyName:(NSString *)companyName {
    _companyName = companyName;
    //  把汉字转换成拼音第一种方法
    NSString *str = [[NSString alloc]initWithFormat:@"%@", companyName];
    // NSString 转换成 CFStringRef 型
    CFStringRef string1 = (CFStringRef)CFBridgingRetain(str);
    //  汉字转换成拼音
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, string1);
    //  拼音（带声调的）
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    //  去掉声调符号
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    //  CFStringRef 转换成 NSString
    NSString *strings = (NSString *)CFBridgingRelease(string);
    //  去掉空格
    NSString *cityString = [strings stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.companyNamePY = cityString;
}

- (void)setCompanyLinkMan:(NSString *)companyLinkMan {
    _companyLinkMan = companyLinkMan;
    NSArray *array = [companyLinkMan componentsSeparatedByString:@" "];
    _contactName = array.firstObject;
    _contactTel = array.lastObject;
}

@end
