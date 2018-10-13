//
//  UserManager.h
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserManager : NSObject

@property (nonatomic, strong)UserModel *user;
@property (nonatomic, assign)BOOL isDebug; // 是否是开发环境
@property (nonatomic, assign)BOOL isLogin;  //是否登录
@property (nonatomic, assign)BOOL isUpdate; //是否有更新

+ (instancetype)sharedManager;

+ (void)rememberLoginMessage:(BOOL)isRemember message:(NSDictionary *)message;

+ (NSDictionary *)getRememberLoginMessage;

//配置用户数据
+ (void)setUpUserInfo;

+ (NSString *)uuid;

- (void)clearUserData;


@end
