//
//  NewMessageViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/24.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "NewMessageViewController.h"
#import "MessageViewController.h"
#import "AnnouncementViewController.h"
@interface NewMessageViewController ()

@end

@implementation NewMessageViewController

- (void)viewDidLoad {
    self.titleArr = @[@"公告",@"消息"];
    self.controllerArr = @[[AnnouncementViewController class],[MessageViewController class]];
    self.titleStr = @"消息";
    self.status = 3;
    [super viewDidLoad];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
