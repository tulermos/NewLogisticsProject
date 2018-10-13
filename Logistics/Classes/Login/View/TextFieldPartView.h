//
//  TextFieldPartView.h
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kRightButtonTypeDefault,
    kRightButtonTypeCoder
} kRightButtonType;
@interface TextFieldPartView : UIView

- (instancetype)initWithIcon:(NSString *)iconName placeholder:(NSString *)placeholder;
- (void)addRightButtonWithType:(kRightButtonType)type clickblock:(Id_Block)block;

@property (nonatomic, assign)UIKeyboardType keyboardType;
@property (nonatomic, assign)BOOL secureTextEntry;
@property (nonatomic, strong)NSString *text;
@property (nonatomic, strong)NSString *setText;

@end
