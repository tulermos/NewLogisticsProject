//
//  EncodeTarget.h
//  风车医生基础版
//
//  Created by meng wang on 2018/3/13.
//  Copyright © 2018年 FC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncodeTarget : NSObject
//按照指定格式 加密url 和 param
+ (NSString *)encode:(NSString *)url param:(NSDictionary *)param;

//根据加密包装后的字典 解析出参数字典
+ (NSDictionary *)decodeParam:(NSDictionary *)encodeParam;

//根据加密包装后的字典 解析出请求url
+ (NSString *)decodeUrl:(NSString *)desStr;
@end
