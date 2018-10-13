//
//  WaybillQueryViewController.m
//  Logistics
//
//  Created by meng wang on 2018/4/21.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WaybillQueryViewController.h"
#import "WaybillDetailViewController.h"
#import "WaybillQueryHeaderView.h"
#import "BaseTableView.h"
#import "WaybillTableViewCell.h"
#import "WaybillModel.h"
#import "WaybillQueryFooterView.h"

@interface WaybillQueryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)WaybillQueryHeaderView *headerView;
@property (nonatomic, strong)BaseTableView *tableView;
@property (nonatomic, strong)WaybillQueryFooterView *footerView;

@end

@implementation WaybillQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.title = NSLocalizedString(@"Home_yundanchaxun", nil);
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [self.view bringSubviewToFront:self.headerView];
    
    _headerView.frame = CGRectMake(0, FCNavigationHeight, FCWidth, 50);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FCNavigationHeight + 50);
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

- (void)loadData:(NSDictionary *)timeDict {
    [FCProgressHUD showLoadingOn:self.view];
    NSDictionary *dict = [NSDictionary requestWithUrl:@"shiplist" param:@{@"StartDate":timeDict[@"start"],@"EndDate":timeDict[@"end"],@"cusCode":[UserManager sharedManager].user.cusCode,@"entNumber":[UserManager sharedManager].user.entNumber}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:dict model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.json).lastObject;
        [self.tableView.dataArray removeAllObjects];
        if ([dict[@"state"] isEqualToString:@"success"]) {
            [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[WaybillModel class] json:dict[@"data"]]];
        }
        [self.tableView reloadData];
        [self.tableView reloadEmptyData];
        [self setSum];
    } failure:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}

- (void)setSum {
    
    CGFloat yf = 0, js = 0,dsk = 0,zl = 0,dsyf = 0,tj = 0;
    for (WaybillModel *model in self.tableView.dataArray) {
        yf += model.DShiSum.floatValue;
        js += model.Number.floatValue;
        dsk += 0;
        zl += model.Weight.floatValue;
        dsyf = 0;
        tj += model.Cube.floatValue;
    }
    self.footerView.yf = yf;
    self.footerView.js = js;
    self.footerView.dsf = dsk;
    self.footerView.zl = zl;
    self.footerView.dsyf = dsyf;
    self.footerView.tj = tj;
}

#pragma mark - UITableViewDelegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableView.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaybillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WaybillTableViewCell" owner:nil options:nil] firstObject];
    }
    cell.model = self.tableView.dataArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WaybillModel *model = self.tableView.dataArray[indexPath.section];
    WaybillDetailViewController *detailVc = [[WaybillDetailViewController alloc]init];
    detailVc.EntNumber = model.EntNumber;
    [self.navigationController pushViewController:detailVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView
- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kGlobalBGColor;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight =UITableViewAutomaticDimension;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
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

@end
