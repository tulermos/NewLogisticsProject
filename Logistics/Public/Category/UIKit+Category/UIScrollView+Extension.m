//
//  UIScrollView+Extension.m
//  smartre
//
//  Created by meng wang on 2017/8/8.
//  Copyright © 2017年 莫名. All rights reserved.
//

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)

//对scrollview进行扩展 用来解决scrollview中嵌套tableview左滑失效的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return [otherGestureRecognizer.view.superview isKindOfClass:[UITableView class]];
}

@end
