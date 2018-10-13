//
//  UINavigationController+pop.m
//  风车医生
//
//  Created by meng wang on 2017/9/11.
//  Copyright © 2017年 FC. All rights reserved.
//

#import "UINavigationController+pop.h"

@implementation UINavigationController (pop)

+ (void)popToViewController:(Class)classObj withAnimated:(BOOL)animation{
    
    UINavigationController *nav = [self getCurrentNavigation];
    for (UIViewController *vc in nav.viewControllers) {
        if ([vc isKindOfClass:[classObj class]]) {
            [nav popToViewController:vc animated:YES];
            break;
        }
    }
}

+ (BOOL)hasController:(Class)classObj {
    UINavigationController *nav = [self getCurrentNavigation];
    BOOL isExit = NO;
    for (UIViewController *vc in nav.viewControllers) {
        if ([vc isKindOfClass:[classObj class]]) {
            isExit = YES;
            break;
        }
    }
    return isExit;
}

+ (UINavigationController *)getCurrentNavigation {
    return [self getCurrentVC].navigationController;
}

+ (UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}

@end
