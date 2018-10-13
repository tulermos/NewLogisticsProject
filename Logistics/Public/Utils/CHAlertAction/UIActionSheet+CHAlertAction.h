//
//  UIActionSheet+Block.h
//
//
//  Created by CHia on 15/10/27.
//  Copyright © 2015年 CHia. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIActionSheet (CHAlertAction)<UIActionSheetDelegate>


- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx,NSString* buttonTitle))block;

@end
