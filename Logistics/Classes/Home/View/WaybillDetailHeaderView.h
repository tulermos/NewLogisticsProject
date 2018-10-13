//
//  WaybillDetailHeaderView.h
//  Logistics
//
//  Created by meng wang on 2018/4/23.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaybillDetailHeaderView : UIView

+ (instancetype)headerView;

- (void) setupWithStart:(NSString *)start end:(NSString *)end;

@end
