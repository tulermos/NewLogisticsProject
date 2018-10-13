//
//  FCNetWorkError.h
//  风车医生
//
//  Created by meng wang on 2017/11/23.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCNetWorkError : NSObject

+ (NSString *)errorMessage:(NSInteger)code;

@end
