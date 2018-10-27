//
//  ConsignmentNoteViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/12.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "ConsignmentNoteViewController.h"
#import "ConsignmentNoteCell.h"
#import "ConsignmentNoteModel.h"
#import "WaybillTableViewCell.h"
#import "WaybillModel.h"
#import "WaybillDetailViewController.h"
#import "WaybillQueryHeaderView.h"
#import "ReceivingRegistrationModel.h"
#import "WaybillQueryFooterView.h"
#import "AdvancedQueryViewController.h"
#import "shippingQueryViewController.h"
#define ktableViewKey  @"ktableViewKey"
@interface ConsignmentNoteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong)WaybillQueryHeaderView *headerView;
@property (nonatomic, strong)WaybillQueryFooterView *footerView;

@end

@implementation ConsignmentNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    self.view.backgroundColor = kGlobalViewBgColor;
    self.title = @"托运单";
    UIButton *queryBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [queryBtn setTitle:@"高级查询" forState:(UIControlStateNormal)];
    [queryBtn setFrame:CGRectMake(15.0, 0.0, 70, 16)];
    [queryBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    queryBtn.layer.masksToBounds=YES;
    queryBtn.layer.cornerRadius=3;
    queryBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    queryBtn.backgroundColor=[UIColor clearColor];
    [queryBtn addTarget:self action:@selector(highSearchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *refreshBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [refreshBtn setFrame:CGRectMake(15.0, 0.0, 45, 16)];
    [refreshBtn setTitle:@"刷新" forState:(UIControlStateNormal)];
    [refreshBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    refreshBtn.layer.masksToBounds=YES;
    refreshBtn.layer.cornerRadius=3;
    refreshBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    refreshBtn.backgroundColor=[UIColor clearColor];
    [refreshBtn addTarget:self action:@selector(refreshBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    queryBtn.frame = CGRectMake(0, 0, 70, 16);
    refreshBtn.frame=CGRectMake(0, 0, 35, 16);
    
    UIBarButtonItem *query = [[UIBarButtonItem alloc] initWithCustomView:queryBtn];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: query, refresh,nil]];
    [self setUpUI];
}
//高级查询
-(void)highSearchBtnAction:(UIButton*)btn
{
    shippingQueryViewController *AQVC = [[shippingQueryViewController alloc]init];
    AQVC.type = 2;
    WS;
    [AQVC returnData:^(NSMutableArray * _Nonnull dataArr) {
        weakSelf.tableView.dataArray = dataArr;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView reloadEmptyData];
    }];
    [self.navigationController pushViewController:AQVC animated:YES];
}


- (void)loadData:(NSDictionary *)timeDict
{
      NSDictionary *param = [NSDictionary requestWithUrl:@"GetConsignmentDataList" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"EntNumber":@"",@"pageindex":@(self.tableView.pageNO),@"pagesize":@(self.tableView.pageSize),@"StartTime":timeDict[@"start"],@"EndTime":timeDict[@"end"],@"StockID":@"",@"EntStartID":@"",@"EntEndID":@""}];
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


-(void)setUpUI
{
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.headerView];
    _headerView.frame = CGRectMake(0, FCNavigationHeight, FCWidth, 50);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FCNavigationHeight + 55);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    @weakify(self);
    _headerView.timeBlock = ^(NSDictionary *dict) {
        @strongify(self);
        [self loadData:dict];
    };
    [self.headerView setDefault];
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
- (WaybillQueryHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [WaybillQueryHeaderView waybillQueryHeaderView];
    }
    return _headerView;
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
