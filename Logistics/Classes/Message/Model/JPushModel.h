//
//  JPushModel.h
//  Logistics
//
//  Created by meng wang on 2018/5/2.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPushModel : NSObject<NSCoding>

@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *time;
//0:通知 1:自定义
@property (nonatomic, assign)BOOL type;
@property (nonatomic, assign)BOOL isRead;
@property (nonatomic, strong)NSString *id;

@end
