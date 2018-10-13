//
//  NSDictionary+Extension.h
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

+ (instancetype)requestWithUrl:(NSString *)url param:(NSDictionary *)dict;

@end
