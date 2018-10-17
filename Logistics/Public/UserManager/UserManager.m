//
//  UserManager.m
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (instancetype)sharedManager {
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[UserManager alloc]init];
    });
    return _instance;
}

+ (void)setUpUserInfo {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyUser];
    UserModel *model = [UserModel  yy_modelWithJSON:dict];
    [UserManager sharedManager].user = model;
}

- (void)clearUserData {
    self.user = nil;
//    self.isLogin = NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultKeyUser];
}

+ (void)rememberLoginMessage:(BOOL)isRemember message:(NSDictionary *)message{
    if (isRemember) {
        [[NSUserDefaults standardUserDefaults]setObject:message forKey:@"loginMessage"];
    }else {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"loginMessage"];
    }
    [[NSUserDefaults standardUserDefaults]setBool:isRemember forKey:@"loginIsRemember"];
}

+ (NSDictionary *)getRememberLoginMessage {
    BOOL isRemember = [[NSUserDefaults standardUserDefaults]boolForKey:@"loginIsRemember"];
    if (isRemember) {
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginMessage"];
        return dict;
    }
    
    return nil;
}

- (BOOL)isUpdate {
    NSString *serverVersion = [[NSUserDefaults standardUserDefaults]objectForKey:kAppServerVersion];
    NSString *versionNum = [serverVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    appVersion = [appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (([appVersion longLongValue] < [versionNum longLongValue])) {
        return YES;
    }
    return NO;
}

- (BOOL)isDebug {
    #ifdef DEBUG
    return YES;
    #else
    return NO;
    #endif
}

- (BOOL)isLogin {
    if (self.user && self.user.uuid.length > 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)uuid {
     NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return idfv;
}

@end
