//
//  NSObject+unRecognizedSelector.h
//  风车医生
//
//  Created by lin on 2017/5/10.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <Foundation/Foundation.h>

//防止点击没有实现的selector方法从而导致崩溃
@interface NSObject (unRecognizedSelector)

@end
