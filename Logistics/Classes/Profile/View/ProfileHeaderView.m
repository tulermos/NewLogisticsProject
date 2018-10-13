//
//  ProfileHeaderView.m
//  Logistics
//
//  Created by meng wang on 2018/4/22.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "ProfileHeaderView.h"

@interface ProfileHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ProfileHeaderView

+ (instancetype)profileHeaderView {
    return [[[NSBundle mainBundle]loadNibNamed:@"ProfileHeaderView" owner:nil options:nil]firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.text = [UserManager sharedManager].user.cusName;
}

@end
