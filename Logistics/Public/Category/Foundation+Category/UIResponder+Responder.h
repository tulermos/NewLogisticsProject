//
//  UIResponder+Responder.h
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Responder)

//通过响应链的方式进行多个参数的传递
- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
