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
#define kCellId  @"kCellId"
@interface NoPackViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, assign) NSInteger pageindex;
@property (nonatomic, assign) NSInteger pagesize;
@end

@implementation NoPackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    self.view.backgroundColor = kGlobalViewBgColor;
    [self setUpUI];
    [self getData];
}

-(void)setUpUI
{
   
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,Navigation_Height+44, FCWidth, FCHeight-Navigation_Height-44) style:0];
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
    ConsignmentNoteModel *model = _tableView.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = 0;
    return cell;
}
-(void)getData
{
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetUnMeasureDataList" param:@{@"userID":@"22e3fc13-a2c1-45ce-b413-efd8a403af1b",@"pageindex":@(1),@"pagesize":@(15)}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
            for (NSDictionary *adic in dict[@"unMeaSureInfo"]) {
                [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[MeaModel class] json:adic]];
//                MeaModel *mea = [MeaModel yy_modelWithJSON:adic];
//                [self.dataArr addObject:mea];
//                [self.tableView reloadDataWithArray:[self.dataArr mutableCopy]];
            }
           
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
@end
