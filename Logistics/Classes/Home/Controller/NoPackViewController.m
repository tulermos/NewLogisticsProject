//
//  NoPackViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/18.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "NoPackViewController.h"
#import "ArticleNumberCell.h"
#import "ConsignmentNoteModel.h"
#import "MeaModel.h"
#import "NSDate+BRAdd.h"
#import "MeaEditViewController.h"
#define kCellId  @"kCellId"
@interface NoPackViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, assign) NSInteger pageindex;
@property (nonatomic, assign) NSInteger pagesize;
@property (strong, nonatomic) NSMutableArray  *selectIndexs; //多选选中的行
@end

@implementation NoPackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    _selectIndexs = [[NSMutableArray alloc]initWithCapacity:0];
 
    self.view.backgroundColor = kGlobalViewBgColor;
    [self setUpUI];
    if (self.status == 1) {
        [self getMeaData];
    }else{
        [self getPackData];
    }
    
//    [self getPackData];
    
 
}

-(void)setUpUI
{
   
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,10, FCWidth, FCHeight-Navigation_Height-44) style:0];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UIView *view = [UIView new];
    _tableView.tableFooterView = view;
    [_tableView registerClass:[ArticleNumberCell class] forCellReuseIdentifier:kCellId];
    
    
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
    ArticleNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
  
    if (self.status == 1) {
          MeaModel *model = _tableView.dataArray[indexPath.row];
          cell.meaModel = model;
          cell.status = 1;
    }else{
          ArticleNumberModel *model =_tableView.dataArray[indexPath.row];
          cell.anModel = model;
          cell.status = 1;
    }
    for (NSIndexPath *index in _selectIndexs) {
        if (index == indexPath) { //改行在选择的数组里面有记录
            cell.selectBtn.selected = YES; //打勾
            break;
        }
    }
   
    cell.selectionStyle = 0;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleNumberCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.selectBtn.selected == YES) { //如果为选中状态
        cell.selectBtn.selected  = NO; //切换为未选中
        [_selectIndexs removeObject:indexPath]; //数据移除
    }else { //未选中
        cell.selectBtn.selected  = YES; //切换为选中
        [_selectIndexs addObject:indexPath]; //添加索引数据到数组
    }

    
}

-(void)getMeaData
{
    [FCProgressHUD showLoadingOn:self.view];
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetUnMeasureDataList" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"entNumber":@"",@"pageindex":@(self.tableView.pageNO),@"pagesize":@(self.tableView.pageSize),@"StartTime":[NSDate currentDateString],@"EndTime":[NSDate currentDateString],@"StockID":@"",@"EntStartID":@"",@"EntEndID":@""}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
//            for (NSDictionary *adic in dict[@"unMeaSureInfo"]) {
                [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[MeaModel class] json: dict[@"measureInfo"]]];

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

-(void)getPackData
{
    [FCProgressHUD showLoadingOn:self.view];
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetUnpackDataList" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"pageindex":@(1),@"pagesize":@(15)}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
            //            for (NSDictionary *adic in dict[@"unMeaSureInfo"]) {
            [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[ArticleNumberModel class] json: dict[@"caseInfo"]]];
            //                MeaModel *mea = [MeaModel yy_modelWithJSON:adic];
            //                [self.dataArr addObject:mea];
            //                [self.tableView reloadDataWithArray:[self.dataArr mutableCopy]];
            //            }
            
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






@end
