//
//  AddressBookAlertCell.h
//  Logistics
//
//  Created by meng wang on 2018/4/25.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressBookAlertCell : UITableViewCell

+ (CGFloat)heightForCell:(NSString *)title detail:(NSString *)detail;
- (void)setTitle:(NSString *)title detail:(NSString *)detail;

@end
