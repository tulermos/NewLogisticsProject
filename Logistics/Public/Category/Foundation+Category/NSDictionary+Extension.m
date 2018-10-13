//
//  NSDictionary+Extension.m
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import "NSString+WJ.h"
@implementation NSDictionary (Extension)

+ (instancetype)requestWithUrl:(NSString *)url param:(NSDictionary *)dict {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:url forKey:@"request"];
    NSMutableDictionary *objDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [objDict setObject:@"iOS" forKey:@"client"];
    [objDict setObject:[UserManager uuid] forKey:@"uuid"];
    [objDict setObject:@"" forKey:@"other"];
    [objDict setObject:[[[NSBundle mainBundle] preferredLocalizations]firstObject] forKey:@"language"];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:objDict];
    [param setObject:array forKey:@"data"];
    return param;
}

@end
