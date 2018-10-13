//
//  AddressBookAlertView.h
//  Logistics
//
//  Created by meng wang on 2018/4/25.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressBookAlertView : UIView

+ (instancetype)alertViewWithArray:(NSArray *)array sure:(NSString *)sureStr cancel:(NSString *)cancelStr completionBlock:(Int_Block)block;

- (void)show;
- (void)hide;
@end
