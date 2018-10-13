//
//  UINavigationController+pop.h
//  风车医生
//
//  Created by meng wang on 2017/9/11.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (pop)

+ (void)popToViewController:(Class)classObj withAnimated:(BOOL)animation;
+ (UIViewController *)getCurrentVC;
+ (UINavigationController *)getCurrentNavigation;

+ (BOOL)hasController:(Class)classObj;

@end
