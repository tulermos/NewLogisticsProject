//
//  UILabel+Extension.m
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (instancetype)labelWithFont:(CGFloat)font textColor:(UIColor *)color text:(NSString *)text {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:font];
    label.text = text;
    if (color) {
        label.textColor = color;
    }
    return label;
}

@end
