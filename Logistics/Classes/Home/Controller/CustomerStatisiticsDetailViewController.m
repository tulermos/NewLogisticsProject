//
//  CustomerStatisiticsDetailViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/26.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "CustomerStatisiticsDetailViewController.h"

@interface CustomerStatisiticsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong)WaybillQueryFooterView *footerView;

@end

@implementation CustomerStatisiticsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    self.view.backgroundColor = kGlobalViewBgColor;
    self.title = @"客户运单统计";
    [self setUpUI];
}
-(void)setUpUI
{
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.tableView];
  
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FCNavigationHeight + 55);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
    }];

}
-(void)loadData
{
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetCustomerShipDetail" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"pageindex":@(self.tableView.pageNO),@"pagesize":@(self.tableView.pageSize),@"CusID":_cusId}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
            [self.tableView.dataArray removeAllObjects];
            //            for (NSDictionary *adic in dict[@"entinfo"]) {
            [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[ConsignmentNoteModel class] json:dict[@"entinfo"]]];
            //                NSArray *models =[NSArray yy_modelArrayWithClass:[ReceivingRegistrationModel class] json:adic];
            //            }
            
            [self.tableView reloadData];
            [self.tableView reloadEmptyData];
            [self setSum];
            
        }else{
            NSDictionary *dict = ((NSArray *)response.data).firstObject;
            [FCProgressHUD showText:dict[@"errorMsg"]];
        }
    } failure:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableView.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    ConsignmentNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:ktableViewKey forIndexPath:indexPath];
    WaybillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WaybillTableViewCell" owner:nil options:nil] firstObject];
    }
    cell.CNModel  = self.tableView.dataArray[indexPath.section];
    return cell;
    //    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WaybillModel *model = self.tableView.dataArray[indexPath.section];
    WaybillDetailViewController *detailVc = [[WaybillDetailViewController alloc]init];
    detailVc.EntNumber = model.EntNumber;
    [self.navigationController pushViewController:detailVc animated:YES];
}
#pragma mark - tableView
- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kGlobalViewBgColor;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight =UITableViewAutomaticDimension;
        _tableView.isOpenFooterRefresh = YES;
        _tableView.isOpenHeaderRefresh = YES;
    }
    return _tableView;
}

- (WaybillQueryFooterView *)footerView {
    if (!_footerView) {
        _footerView = [WaybillQueryFooterView footerView];
    }
    return _footerView;
}
- (void)setSum {
    
    CGFloat yf = 0, js = 0,dsk = 0,zl = 0,dsyf = 0,tj = 0;
    for (ConsignmentNoteModel *model in self.tableView.dataArray) {
        if (![NSString isBlankString:model.ShiSum]) {
            yf += model.ShiSum.floatValue;
        }
        if (![NSString isBlankString:model.SdNumber]) {
            js += model.SdNumber.floatValue;
        }
        if (![NSString isBlankString:model.SdWeight]) {
            zl += model.SdWeight.floatValue;
        }
        dsk += 0;
        dsyf = 0;
        if (![NSString isBlankString:model.SdCube]) {
            tj += model.SdCube.floatValue;
        }
        
    }
    self.footerView.yf = yf;
    self.footerView.js = js;
    self.footerView.dsf = dsk;
    self.footerView.zl = zl;
    self.footerView.dsyf = dsyf;
    self.footerView.tj = tj;
}



@end
