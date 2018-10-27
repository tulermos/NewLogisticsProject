//
//  ReceivingRegistrationViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/13.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "ReceivingRegistrationViewController.h"
#import "ReceivingRegistrationCell.h"
#import "TFDropDownMenuView.h"
#import "ReceivingRegistrationModel.h"
#import "WaybillQueryHeaderView.h"
#import "WaybillDetailViewController.h"
#import "AdvancedQueryViewController.h"
#import "shippingQueryViewController.h"
#define kReceivingRegistrationCell @"kReceivingRegistrationCell"
@interface ReceivingRegistrationViewController ()<UITableViewDelegate,UITableViewDataSource,HSLimitTextDelegate,UITextFieldDelegate,TFDropDownMenuViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) HSLimitText *searchBar;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, assign) NSInteger menuRow;
@property (nonatomic, assign) NSInteger menuColumn;
@property (nonatomic, assign) NSInteger pageindex;
@property (nonatomic, assign) NSInteger pagesize;
@property (nonatomic, strong)WaybillQueryHeaderView *headerView;
@end

@implementation ReceivingRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    self.view.backgroundColor = kGlobalViewBgColor;
    self.title = @"收货登记";
    UIButton *highSearchBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [highSearchBtn setTitle:@"高级查询" forState:(UIControlStateNormal)];
    [highSearchBtn setFrame:CGRectMake(15.0, 0.0, 70, 16)];
    [highSearchBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    highSearchBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    highSearchBtn.backgroundColor=[UIColor clearColor];
    [highSearchBtn addTarget:self action:@selector(highSearchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    highSearchBtn.frame = CGRectMake(0, 0, 70, 16);
    UIBarButtonItem *highSearch = [[UIBarButtonItem alloc] initWithCustomView:highSearchBtn];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:highSearch,nil]];
    [self setupUI];

}
-(void)setupUI
{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.headerView];
    
    _headerView.frame = CGRectMake(0, FCNavigationHeight, FCWidth, 50);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FCNavigationHeight + 55);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];

    @weakify(self);
    _headerView.timeBlock = ^(NSDictionary *dict) {
        @strongify(self);
        [self loadData:dict];
    };
    [self.headerView setDefault];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
    ReceivingRegistrationCell *cell = [tableView dequeueReusableCellWithIdentifier:kReceivingRegistrationCell forIndexPath:indexPath];
//    ReceivingRegistrationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"WaybillTableViewCell" owner:nil options:nil] firstObject];
//    }
    cell.RRModel = self.tableView.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ReceivingRegistrationModel *model = self.tableView.dataArray[indexPath.section];
    WaybillDetailViewController *detailVc = [[WaybillDetailViewController alloc]init];
    detailVc.EntNumber = model.EntNumber;
    [self.navigationController pushViewController:detailVc animated:YES];
}
//高级查询
-(void)highSearchBtnAction:(UIButton*)btn
{
    AdvancedQueryViewController *AQVC = [[AdvancedQueryViewController alloc]init];
    AQVC.type = 1;
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
    
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetEntDataList" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"entNumber":@"",@"pageindex":@(self.tableView.pageNO),@"pagesize":@(self.tableView.pageSize),@"StartTime":timeDict[@"start"],@"EndTime":timeDict[@"end"],@"StockID":@"",@"EntStartID":@"",@"EntEndID":@""}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
//            for (NSDictionary *adic in dict[@"entinfo"]) {
                [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[ReceivingRegistrationModel class] json:dict[@"entinfo"]]];
//                NSArray *models =[NSArray yy_modelArrayWithClass:[ReceivingRegistrationModel class] json:adic];
//            }
       
            [self.tableView reloadData];
            [self.tableView reloadEmptyData];
            
        }else{
            NSDictionary *dict = ((NSArray *)response.data).firstObject;
            [FCProgressHUD showText:dict[@"errorMsg"]];
        }
    } failure:^(FCBaseResponse *response) {
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}

#pragma mark - tableView
- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kGlobalBGColor;
//        _tableView.estimatedRowHeight = 90;
        _tableView.rowHeight =UITableViewAutomaticDimension;
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
        _tableView.isOpenFooterRefresh = YES;
         _tableView.isOpenHeaderRefresh = YES;
        [_tableView registerClass:[ReceivingRegistrationCell class] forCellReuseIdentifier:kReceivingRegistrationCell];
    }
    return _tableView;
}
- (WaybillQueryHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [WaybillQueryHeaderView waybillQueryHeaderView];
    }
    return _headerView;
}
@end

