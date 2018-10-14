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
#define ktableViewKey  @"ktableViewKey"
@interface ConsignmentNoteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseTableView *tableView;

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
    [queryBtn addTarget:self action:@selector(queryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    [self getData];
}
-(void)getData
{
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetConsignmentData" param:@{@"userID":@"22e3fc13-a2c1-45ce-b413-efd8a403af1b"}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
         [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.json).lastObject;
        [self.tableView.dataArray removeAllObjects];
        if ([dict[@"state"] isEqualToString:@"success"]) {
            [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[WaybillModel class] json:dict[@"data"]]];
        }
        [self.tableView reloadData];
        [self.tableView reloadEmptyData];
        NSLog(@"%@成功",response);
    } failure:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}


-(void)setUpUI
{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height, FCWidth, FCHeight-self.navigationController.navigationBar.frame.size.height) style:0];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kGlobalBGColor;
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight =UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];
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
    cell.model = self.tableView.dataArray[indexPath.section];
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
-(void)queryBtnAction:(UIButton*)btn
{
    
}
-(void)refreshBtnAction:(UIButton*)btn
{
    
}

@end
