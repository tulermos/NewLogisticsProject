//
//  PackagingDocumentsViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/26.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "PackagingDocumentsViewController.h"
#import "PackDocument_NoPackController.h"
#import "PackDocument_PackedViewController.h"
@interface PackagingDocumentsViewController ()

@end

@implementation PackagingDocumentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"未计量",@"已计量"];
    self.controllerArr = @[[PackDocument_NoPackController class],[PackDocument_PackedViewController class]];
    self.titleStr = @"打包单据";
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
