//
//  UIButton+Extension.m
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (instancetype)buttonWithFont:(CGFloat)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

+ (instancetype)buttonWithNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    return btn;
}

@end
