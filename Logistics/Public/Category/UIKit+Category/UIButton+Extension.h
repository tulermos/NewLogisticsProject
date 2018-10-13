//
//  UIButton+Extension.h
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

+ (instancetype)buttonWithFont:(CGFloat)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor title:(NSString *)title;

+ (instancetype)buttonWithNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage;

@end
