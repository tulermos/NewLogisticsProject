//
//  MeasuringDocumentsViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/18.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "MeasuringDocumentsViewController.h"
#import "NoPackViewController.h"
#import "PackedViewController.h"
@interface MeasuringDocumentsViewController ()

@end

@implementation MeasuringDocumentsViewController

- (void)viewDidLoad {
    self.titleArr = @[@"未计量",@"已计量"];
    self.controllerArr = @[[NoPackViewController class],[PackedViewController class]];
    self.titleStr = @"计量单据";
    [super viewDidLoad];
   
}



@end
