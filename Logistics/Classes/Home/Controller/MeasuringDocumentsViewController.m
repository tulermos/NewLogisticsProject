//
//  MeasuringDocumentsViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/18.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "MeasuringDocumentsViewController.h"
#import "NoPackViewController.h"
@interface MeasuringDocumentsViewController ()

@end

@implementation MeasuringDocumentsViewController

- (void)viewDidLoad {
    self.titleArr = @[@"已打包",@"未打包"];
    self.controllerArr = @[[NoPackViewController class],[NoPackViewController class]];
    [super viewDidLoad];
  
}



@end
