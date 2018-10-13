//
//  WKProgressHUD.h
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCBaseResponse.h"
@interface FCProgressHUD : NSObject

/*
 * 显示文本提示
 */
+ (void)showText:(NSString *)text;
/*
 * 在UIView上显示文字
 */
+ (void)showText:(NSString *)text onView:(UIView *)view ;

/*
 * 网络加载提示,在window上
 */
+ (void)showLoadingText:(NSString *)text;

/*
 * 网络加载提示,在view上
 */
+ (void)showLoadingText:(NSString *)text on:(UIView *)view;

/*
 * 显示load到view上
 */
+ (void)showLoadingOn:(UIView *)view;
/*
 * 成功的提示
 */
+ (void)showSuccessWith:(NSString *)text;

/*
 * 失败的提示
 */
+ (void)showErrorWith:(NSString *)text;

/*
 * 显示GIF图
 */
+ (void)showLoadingGifText:(NSString *)text;


/**
 显示圆圈的GIF图

 @param text 描述信息
 */
+ (void)showWatchShowLoadingGifText:(NSString *)text;

/*
 * 在window上隐藏
 */
+ (void)hideHUDForWindow;

/*
 * 在UIView上隐藏
 */
+ (void)hideHUDForView:(UIView *)view animation:(BOOL)animation;

@end
