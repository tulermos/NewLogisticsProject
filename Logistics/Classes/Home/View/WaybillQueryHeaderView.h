//
//  WaybillQueryHeaderView.h
//  Logistics
//
//  Created by meng wang on 2018/4/21.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaybillQueryHeaderView : UIView

+ (instancetype)waybillQueryHeaderView;

@property (nonatomic, copy)Dict_Block timeBlock;

- (void)setDefault;


@end
