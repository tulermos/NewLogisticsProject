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
#import "Mea_NoPackingViewController.h"
#import "Mea_PackedViewController.h"
#import "MeaEditViewController.h"
@interface MeasuringDocumentsViewController ()

@end

@implementation MeasuringDocumentsViewController

- (void)viewDidLoad {
    self.titleArr = @[@"未计量",@"已计量"];
    self.controllerArr = @[[Mea_NoPackingViewController class],[Mea_PackedViewController class]];
    self.titleStr = @"计量单据";
    [super viewDidLoad];
   
}
//批处理
-(void)batchBtnAction:(UIButton *)btn
{
    MeaEditViewController *MEVC = [[MeaEditViewController alloc]init];
    [self.navigationController pushViewController:MEVC animated:YES];
}

//刷新
-(void)refreshBtnAction:(UIButton *)btn
{
    
}

//搜索
-(void)searchBtnAction:(UIButton *)btn
{
    
}


@end
