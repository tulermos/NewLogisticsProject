//
//  EncodeTarget.m
//  风车医生基础版
//
//  Created by meng wang on 2018/3/13.
//  Copyright © 2018年 FC. All rights reserved.
//

#import "EncodeTarget.h"

@implementation EncodeTarget

+ (NSString *)encode:(NSString *)url param:(NSDictionary *)param{
    NSArray *keys = [param allKeys];
    NSArray *values = [param allValues];;
    NSAssert(keys.count == values.count, @"键值的个数必须相等");
    NSString *str = @"";
    for (int i=0; i<keys.count; i++) {
        NSString *valueStr = [NSString stringWithFormat:@"%@",values[i]];
        NSAssert([valueStr isKindOfClass:[NSString class]], @"必须是NSString类型的值");
        valueStr = [valueStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *item = [NSString stringWithFormat:@"%@=%@",keys[i],valueStr];
        if (str.length != 0) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"&%@",item]];
        }else{
            str = item;
        }
    }
    if ([str length] != 0) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@",str]];
    }
    NSString *string11 = __DESString(url);
    return string11;
}

+ (NSDictionary *)decodeParam:(NSDictionary *)encodeParam {
    if (![encodeParam.allKeys containsObject:@"v"]) {
        return encodeParam;
    }
    NSString *paramPath = __DECODEDESSTRING(encodeParam[@"v"]);
    if (paramPath.length > 0 && [paramPath containsString:@"?"]) {
        NSString *paramStr = [paramPath substringFromIndex:[paramPath rangeOfString:@"?"].location + 1];
        NSArray *paramPart = [paramStr componentsSeparatedByString:@"&"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:paramPart.count];
        for (NSString *part in paramPart) {
            NSArray *partArray = [part componentsSeparatedByString:@"="];
            if (partArray.count == 2) {
                [dict setObjectOrNil:partArray.lastObject forKey:partArray.firstObject];
            }
        }
        return dict;
    }else {
        return [NSDictionary dictionary];
    }
}

+ (NSString *)decodeUrl:(NSString *)desStr {
    NSString *requstPath = __DECODEDESSTRING(desStr);
    if ([requstPath containsString:@"?"]) {
        return [requstPath substringToIndex:[requstPath rangeOfString:@"?"].location];
    }
    return requstPath;
}

@end
