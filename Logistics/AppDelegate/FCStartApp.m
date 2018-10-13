//
//  FCStartApp.m
//  风车医生基础版
//
//  Created by meng wang on 2018/3/13.
//  Copyright © 2018年 FC. All rights reserved.
//

#import "FCStartApp.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "TabBarControllerConfig.h"
#import "BaseNavigationController.h"
#import "AppUpadateModel.h"
#import "UserModel.h"
#import "IQKeyboardManager.h"

@implementation FCStartApp

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获取用户缓存数据
        [[self class]fc_setUserData];
        //设置全局UI
        [[self class]fc_setGlobalUI];
        //全局键盘设置
        [[self class]fc_setKeyBord];
    });
}

+ (instancetype)sharedInstance {
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

+ (void)fc_setUserData {
    [UserManager setUpUserInfo];
    [JPushManager addAlias];
}

+ (void)fc_setGlobalUI {
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [[UITableView appearance] setEstimatedRowHeight:0];
    [[UITableView appearance] setEstimatedSectionFooterHeight:0];
    [[UITableView appearance] setEstimatedSectionHeaderHeight:0];
}

#pragma mark - 键盘回收相关
+ (void)fc_setKeyBord {
    //统一设置键盘
    [[IQKeyboardManager sharedManager]setEnable:YES];
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];
}

+ (void)appVersionUpdate {
    NSDictionary *dict = [NSDictionary requestWithUrl:@"update" param:nil];
    [FCHttpRequest FCNetWork:HttpRequestMethodPost url:nil model:nil  cache:NO param:dict success:^(FCBaseResponse *response) {
        if ([response.json[@"state"] isEqualToString:@"success"]){
            AppUpadateModel *model = [AppUpadateModel yy_modelWithJSON:((NSArray *)response.json[@"data"]).firstObject];
            if (model) {
                [[NSUserDefaults standardUserDefaults]setObject:model.serverVersion forKey:kAppServerVersion];
                [[NSUserDefaults standardUserDefaults]setObject:model.updateUrl forKey:kAppServerAppUrl];
                NSString *versionNum = [model.serverVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
                NSString * appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
                appVersion = [appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
                
                if (([appVersion longLongValue] < [versionNum longLongValue])) {
                    BOOL forceUpdate = model.IsAcitve.boolValue;
                    UIAlertController *controller = [UIAlertController alertControllerWithTitle:model.TipInfo
                                                                            message:nil
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
                    if (!forceUpdate) {
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        [controller addAction:cancel];
                    }
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.updateUrl]];
                    }];
                    [controller addAction:action];
                    UIViewController *vc = [[[UIApplication sharedApplication].delegate window] rootViewController];
                    [vc presentViewController:controller animated:YES completion:nil];
                }
            }
        }
    } failure:^(FCBaseResponse *response) {}];
}

#pragma mark - 根据token生成根控制器
- (UIViewController *)fc_rootViewController {
    if ([UserManager sharedManager].isLogin) {
        TabBarControllerConfig *tabbarVc = [[TabBarControllerConfig alloc] init];
        return tabbarVc.tabBarController;
    }else{
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:loginVc];
        return nav;
    }
}

@end
