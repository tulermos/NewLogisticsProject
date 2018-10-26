//
//  PackedViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/18.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "PackedViewController.h"
#import "ArticleNumberCell.h"
#import "ConsignmentNoteModel.h"
#import "MeaModel.h"
#import "ArticleNumberModel.h"
#define kPackedCellId  @"kPackedCellId"
@interface PackedViewController ()<UITableViewDelegate,UITableViewDataSource,ArticleNumberCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, assign) NSInteger pageindex;
@property (nonatomic, assign) NSInteger pagesize;
@end

@implementation PackedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    self.view.backgroundColor = kGlobalViewBgColor;
    [self setUpUI];
    if (self.status == 1) {
        [self getMeaData];
    }else{
        [self getPackData];
    }
}
-(void)setUpUI
{
    
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,10, FCWidth, FCHeight-Navigation_Height) style:0];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UIView *view = [UIView new];
    _tableView.tableFooterView = view;
    [_tableView registerClass:[ArticleNumberCell class] forCellReuseIdentifier:kPackedCellId];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
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
    ArticleNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:kPackedCellId forIndexPath:indexPath];
    if (self.status == 1) {
        MeaModel *model = _tableView.dataArray[indexPath.row];
        cell.meaModel = model;
        cell.status = 2;
    }else{
        ArticleNumberModel *model =_tableView.dataArray[indexPath.row];
        cell.anModel = model;
        cell.status = 2;
    }
    cell.delegate = self;
    cell.selectionStyle = 0;
    return cell;
}




-(void)getMeaData
{
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetMeasureDataList" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"pageindex":@(1),@"pagesize":@(15)}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
//            for (NSDictionary *adic in dict[@"unMeaSureInfo"]) {
                [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[MeaModel class] json:dict[@"measureInfo"]]];

            [self.tableView reloadData];
            [self.tableView reloadEmptyData];
        }else{
            self.tableView.tableHeaderView = nil;
            [self.tableView.dataArray removeAllObjects];
            [self.tableView reloadData];
            [FCProgressHUD hideHUDForView:self.view animation:YES];
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
            [FCProgressHUD showText:dict[@"errorMsg"]];
        }
        
    } failure:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}
-(void)getPackData
{
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetPackDataList" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"pageindex":@(1),@"pagesize":@(15)}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
       
            [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[ArticleNumberModel class] json:dict[@"caseInfo"]]];
         
            
            [self.tableView reloadData];
            [self.tableView reloadEmptyData];
        }else{
            
        }
        
    } failure:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}

-(void)ModifyOprateWithEntNum:(NSString *)numer
{
    
}
//批处理
-(void)batchBtnAction:(UIButton *)btn
{
    
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

