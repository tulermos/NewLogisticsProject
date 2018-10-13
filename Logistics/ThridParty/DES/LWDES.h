//
//  LWDES.h
//  隔壁老王(销售版)
//
//  Created by laowang on 15/8/5.
//  Copyright (c) 2015年 隔壁老王. All rights reserved.
//

/******字符串DES加密******/
//#define kKEY @"wanglaobige&2014"

#define kKEY @"pinwheel"

#define __DESString(string) [LWDES encrypt:string]

/******DES解密转字符串******/
#define __DECODEDESSTRING( desString) [LWDES decrypt:desString]

#import <Foundation/Foundation.h>

@interface LWDES : NSObject

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

@end
