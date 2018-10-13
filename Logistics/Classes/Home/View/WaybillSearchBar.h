//
//  FCGoodsSearchBar.h
//  风车医生
//
//  Created by meng wang on 2017/8/24.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockFilt)(NSString *searchStr);
typedef void(^BlockCancel)();
typedef void(^BlockTextChange)(NSString *text);

@interface WaybillSearchBar : UIView

//获取搜索框的内容
@property (nonatomic, strong)NSString *searchStr;

@property (nonatomic, strong)UITextField *textField;
//点击了搜索
@property (nonatomic, copy)BlockFilt filtBlock;
//点击了button
@property (nonatomic, copy)BlockCancel cancelBlock;
//文本内容发生改变
@property (nonatomic, copy)BlockTextChange changeBlock;
//搜索textfield距离顶部的距离
@property (nonatomic, assign)CGFloat margin_top;
//设置按钮的title
@property (nonatomic, strong)NSString *buttonTitle;

@end
