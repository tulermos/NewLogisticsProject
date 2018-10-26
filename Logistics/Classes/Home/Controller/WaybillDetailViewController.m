//
//  WaybillDetailViewController.m
//  Logistics
//
//  Created by meng wang on 2018/4/22.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WaybillDetailViewController.h"
#import "WaybillDetailTableViewCell.h"
#import "WaybillDetailHeaderView.h"
#import "NavigationBarView.h"
#import "WaybillSearchBar.h"

@interface WaybillDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)BaseTableView *tableView;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)WaybillSearchBar *searchBar;

@end

@implementation WaybillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    if (!self.showTextField) {
        [self loadData:self.EntNumber];
    }else {
        self.title = NSLocalizedString(@"TabBar_Logistics", nil);
        [self.tableView reloadEmptyData];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.showTextField) {
         self.navigationController.navigationBar.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!self.showTextField) {
        self.navigationController.navigationBar.hidden = NO;
    }
}

- (void)setupUI {
    self.title = self.EntNumber;
    
    @weakify(self);
    NavigationBarView *barview = [[NavigationBarView alloc]initWithTitle:self.EntNumber popBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:barview];
    CGFloat height = FCNavigationHeight;
    
    if (self.showTextField) {
        self.searchBar.frame = CGRectMake(0, FCNavigationHeight, FCWidth, 45);
        [self.view addSubview:self.searchBar];
        barview.hidden = YES;
        self.searchBar.cancelBlock = ^{
            @strongify(self);
            [self loadData:self.searchBar.textField.text];
        };
        height = FCNavigationHeight + 45;
    }
    
    self.titles = @[NSLocalizedString(@"Home_start", nil),
                    NSLocalizedString(@"Home_end", nil),
                    NSLocalizedString(@"Home_goods", nil),
                    NSLocalizedString(@"Home_finace", nil)];
    [self.view addSubview:self.tableView];
    
    [barview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(FCNavigationHeight);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(height);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

- (void)loadData:(NSString *)entNumber {
    
    [FCProgressHUD showLoadingOn:self.view];
    NSDictionary *dict = [NSDictionary requestWithUrl:@"shipdetail" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"EntNumber":entNumber}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:dict model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
//        NSDictionary *json = ((NSArray *)response.json).lastObject;
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
        if ([dic[@"state"] isEqualToString:@"success"]) {
             [self.tableView reloadDataWithArray:[self setupDetailItems:dict]];
             [self addHeaderView:dic[@"data"]];
        }else {
            [FCProgressHUD showText:dict[@"errorMsg"]];
            self.tableView.tableHeaderView = nil;
            [self.tableView.dataArray removeAllObjects];
            [self.tableView reloadData];
        }
        [self.tableView reloadEmptyData];
    } failure:^(FCBaseResponse *response) {
        self.tableView.tableHeaderView = nil;
        [self.tableView.dataArray removeAllObjects];
        [self.tableView reloadData];
        [FCProgressHUD hideHUDForView:self.view animation:YES];
         NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}

- (void)addHeaderView:(NSDictionary *)json {
    WaybillDetailHeaderView *headerView = [WaybillDetailHeaderView headerView];;
    headerView.frame = CGRectMake(0, 0, FCWidth, 70);
    [headerView setupWithStart:json[@"StartStation"] end:json[@"EndStation"]];
    headerView.backgroundColor = kGlobalMainColor;
    self.tableView.tableHeaderView = headerView;
}

- (NSArray *)setupDetailItems:(NSDictionary *)json {
    
    WaybillSenderItem *sender = [WaybillSenderItem yy_modelWithJSON:json[@"Sender"]];
    sender.StartStation = json[@"StartStation"];
    sender.RoomNo = json[@"RoomNo"];
    WaybillReceiveItem *receiver = [WaybillReceiveItem yy_modelWithJSON:json[@"Receiver"]];
    receiver.EndStation = json[@"EndStation"];
    NSArray *goodsInfos = [NSArray yy_modelArrayWithClass:[WaybillGoodsInfoItem class] json:json[@"GoodsInfo"]];
    WaybillGoodsInfoItem *infoItem = goodsInfos.lastObject;
    infoItem.isLastObj = YES;
    for (WaybillGoodsInfoItem *infoItem in goodsInfos) {
        infoItem.ShiCurrOrganizition = json[@"ShiCurrOrganizition"];
    }
    
    WaybillFinaceItem *finace = [WaybillFinaceItem yy_modelWithJSON:json[@"Finace"]];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    [array addObject:sender];
    [array addObject:receiver];
    [array addObject:goodsInfos];
    [array addObject:finace];
    return array;
}

#pragma mark - UITableViewDatasource/delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableView.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id obj = self.tableView.dataArray[section];
    if ([obj isKindOfClass:[NSArray class]]) {
        return ((NSArray *)obj).count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id obj = self.tableView.dataArray[indexPath.section];
    if ([obj isKindOfClass:[NSArray class]]) {
        obj = ((NSArray *)obj)[indexPath.row];
    }
    NSString *cellId = [self cellReuseIdForItemType:obj];
    WaybillDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [self cellForCellReuseId:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.row + 1;
    cell.obj = obj;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FCWidth, 45)];
    view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"shutiao"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(15, (45-image.size.height) * 0.5, image.size.width, image.size.height);
    UILabel *label = [UILabel labelWithFont:15 textColor:kGlobalMainColor text:_titles[section]];
    label.frame = CGRectMake(15 + image.size.width + 5, imageView.mj_y, FCWidth - 35, imageView.mj_h);
    [view addSubview:imageView];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}


- (NSString *)cellReuseIdForItemType:(id)obj {
    NSString *cellId = @"cellId";
    if ([obj isKindOfClass:[WaybillSenderItem class]]) {
        cellId = @"WaybillSenderItem";
    }
    else if ([obj isKindOfClass:[WaybillReceiveItem class]]) {
        cellId = @"WaybillReceiveItem";
    }
    else if ([obj isKindOfClass:[WaybillGoodsInfoItem class]]) {
        cellId = @"WaybillGoodsInfoItem";
    }
    else if ([obj isKindOfClass:[WaybillFinaceItem class]]) {
        cellId = @"WaybillFinaceItem";
    }
    return cellId;
}

- (WaybillDetailTableViewCell *)cellForCellReuseId:(NSString *)cellId {
    WaybillDetailTableViewCell *cell = [[WaybillDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 300;
        _tableView.rowHeight =UITableViewAutomaticDimension;
        _tableView.separatorColor = [UIColor whiteColor];
    }
    return _tableView;
}
- (WaybillSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[WaybillSearchBar alloc]init];
    }
    return _searchBar;
}
@end
