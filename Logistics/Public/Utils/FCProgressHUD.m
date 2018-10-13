//
//  WKProgressHUD.m
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import "FCProgressHUD.h"
#import "UIImage+Gif.h"
#import <MBProgressHUD.h>
#import "FCBaseResponse.h"
#import "FCNetWorkError.h"

const NSTimeInterval lastTime = 2;

@implementation FCProgressHUD

+ (void)showText:(NSString *)text{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.label.text = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.margin = 16.f;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    hud.alpha = 0.8;
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)showLoadingText:(NSString *)text{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.label.text = text;
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showLoadingText:(NSString *)text on:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showLoadingOn:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showSuccessWith:(NSString *)text{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    hud.label.text = text;
    [hud showAnimated:YES];
}

+ (void)showErrorWith:(NSString *)text{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    hud.label.text = text;
}

+ (void)showLoadingGifText:(NSString *)text{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    [keyWindow addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"load" ofType:@"gif"];
    UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL fileURLWithPath:path]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 40, 40);
    imageView.center = hud.center;
    hud.customView = imageView;
    hud.customView.frame = imageView.frame;
    //hud.color = [UIColor clearColor];
    hud.label.text = text;
    [hud showAnimated:YES];

}

+(void)showWatchShowLoadingGifText:(NSString *)text{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    [keyWindow addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"watchShowLoading" ofType:@"gif"];
    UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL fileURLWithPath:path]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 60, 60);
    imageView.center = hud.center;
    hud.customView = imageView;
    //hud.color = [UIColor clearColor];
    hud.label.text = text;
    [hud showAnimated:YES];
}

+ (void)hideHUDForWindow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    for (UIView *subview in keyWindow.subviews) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subview;
            [hud hideAnimated:YES];
        }
    }
}

+ (void)hideHUDForView:(UIView *)view animation:(BOOL)animation{
    [MBProgressHUD hideHUDForView:view animated:animation];
}

+ (void)showText:(NSString *)text onView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.margin = 16.f;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    hud.alpha = 0.8;
    [hud hideAnimated:YES afterDelay:1.5];
}

@end
