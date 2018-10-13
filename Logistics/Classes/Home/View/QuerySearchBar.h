//
//  QuerySearchBar.h
//  Logistics
//
//  Created by meng wang on 2018/7/8.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockFilt)(NSString *searchStr);
typedef void(^BlockTextChange)(NSString *text);

@interface QuerySearchBar : UIView

//获取搜索框的内容
@property (nonatomic, strong)NSString *searchStr;

@property (nonatomic, strong)UITextField *textField;
//点击了搜索
@property (nonatomic, copy)BlockFilt filtBlock;
//点击了button
@property (nonatomic, copy)Void_Block clickDanjuBlock;
//点击了button
@property (nonatomic, copy)Void_Block clickKuanhaoBlock;
//文本内容发生改变
@property (nonatomic, copy)BlockTextChange changeBlock;
//搜索textfield距离顶部的距离
@property (nonatomic, assign)CGFloat margin_top;
//设置按钮的title
@property (nonatomic, strong)NSString *buttonTitle;

@end
