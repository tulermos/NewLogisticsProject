//
//  CHAlertAction.m
//
//
//  Created by CHia on 15/10/27.
//  Copyright © 2015年 CHia. All rights reserved.
//

#import "CHAlertAction.h"
#import <UIKit/UIKit.h>
#import "UIAlertView+CHAlertAction.h"
#import "UIActionSheet+CHAlertAction.h"

@implementation CHAlertAction


+(void)showAlertNONetwork{
    [CHAlertAction showAlertWithMessage:@"网络状态异常,请确定网络是否连接."];
}

+(void)showAlertWithMessage:(NSString *)message{
    [CHAlertAction showAlertWithTitle:@"提示" msg: message chooseBlock:^(NSInteger buttonIdx) {
        
    } buttonsStatement:@"确定",nil];
}

+ (void)showAlertWithMsg:(NSString*)message buttonsStatement:(NSArray<NSString*>*)arrayItems chooseBlock:(void (^)(NSInteger buttonIdx))block
{
    [CHAlertAction showAlertWithTitle:@"提示" msg:message buttonsStatement:arrayItems chooseBlock:block];
}

+ (void)showAlertWithTitle:(NSString*)title msg:(NSString*)message buttonsStatement:(NSArray<NSString*>*)arrayItems chooseBlock:(void (^)(NSInteger buttonIdx))block
{
    
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithArray:arrayItems];
    
    
    //UIAlertController style
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < [argsArray count]; i++)
    {
        UIAlertActionStyle style =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
        // Create the actions.
        UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
            if (block) {
                block(i);
            }
        }];
        [alertController addAction:action];
    }
    
    [[self getTopViewController] presentViewController:alertController animated:YES completion:nil];
    
    return;
    
}

+ (void)showActionSheetWithTitle:(NSString*)title
                         message:(NSString*)message
               cancelButtonTitle:(NSString*)cancelString
          destructiveButtonTitle:(NSString*)destructiveButtonTitle
                otherButtonTitle:(NSArray<NSString*>*)otherButtonArray
                     chooseBlock:(void (^)(NSInteger buttonIdx))block
{
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    
    if (cancelString) {
        [argsArray addObject:cancelString];
    }
    if (destructiveButtonTitle) {
        [argsArray addObject:destructiveButtonTitle];
    }
    
    [argsArray addObjectsFromArray:otherButtonArray];
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < argsArray.count ; i++ )
    {
        UIAlertActionStyle style =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
        
        if (1==i && destructiveButtonTitle) {
            
            style = UIAlertActionStyleDestructive;
        }
        
        // Create the actions.
        UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
            if (block) {
                block(i);
            }
        }];
        [alertController addAction:action];
        
    }
    [[self getTopViewController] presentViewController:alertController animated:YES completion:nil];
    return;
}

+ (UIViewController*)getTopViewController
{
    UIViewController *result = nil;
    
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


+ (void)showAlertWithTitle:(NSString*)title msg:(NSString*)message chooseBlock:(void (^)(NSInteger buttonIdx))block  buttonsStatement:(NSString*)cancelString, ...
{
    if (message.length == 0) return;
    
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:2];
    [argsArray addObject:cancelString];
    id arg;
    va_list argList;
    if(cancelString)
    {
        va_start(argList,cancelString);
        while ((arg = va_arg(argList,id)))
        {
            [argsArray addObject:arg];
        }
        va_end(argList);
    }
    
    
    //UIAlertView style
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelString otherButtonTitles:nil, nil];
    
    [argsArray removeObject:cancelString];
    for (NSString *buttonTitle in argsArray) {
        
        [alertView addButtonWithTitle:buttonTitle];
    }
    
    [alertView showWithBlock:^(NSInteger buttonIdx)
     {
         
         block(buttonIdx);
     }];
}




+ (void)showActionSheetWithTitle:(NSString*)title message:(NSString*)message chooseBlock:(void (^)(NSInteger buttonIdx))block
               cancelButtonTitle:(NSString*)cancelString destructiveButtonTitle:(NSString*)destructiveButtonTitle otherButtonTitle:(NSString*)otherButtonTitle,...
{
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    
    if (cancelString) {
        [argsArray addObject:cancelString];
    }
    if (destructiveButtonTitle) {
        [argsArray addObject:destructiveButtonTitle];
    }
    
    
    id arg;
    va_list argList;
    if(otherButtonTitle)
    {
        [argsArray addObject:otherButtonTitle];
        va_start(argList,otherButtonTitle);
        while ((arg = va_arg(argList,id)))
        {
            [argsArray addObject:arg];
        }
        va_end(argList);
    }
    
    //UIActionSheet
    UIView *view = [self getTopViewController].view;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:title delegate:nil cancelButtonTitle:cancelString destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil, nil];
    
    
    if (cancelString) {
        [argsArray removeObject:cancelString];
    }
    if (destructiveButtonTitle) {
        [argsArray removeObject:destructiveButtonTitle];
    }
    
    for (NSString* title in argsArray)
    {
        [sheet addButtonWithTitle:title];
    }
    
    __block BOOL isDestructiveExist = destructiveButtonTitle ? YES:NO;
    
    [sheet showInView:view block:^(NSInteger buttonIdx,NSString* buttonTitle)
     {
         NSInteger idx = buttonIdx;
         
         if (isDestructiveExist ) {
             
             switch (idx) {
                 case 0:
                     idx = 1;
                     break;
                 case 1:
                     idx = 0;
                     break;
                     
                 default:
                     break;
             }
         }
         
         if (block) {
             block(idx);
         }
     }];
    
    
}


@end
