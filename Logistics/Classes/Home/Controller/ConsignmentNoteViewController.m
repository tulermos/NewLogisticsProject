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
#define ktableViewKey  @"ktableViewKey"
@interface ConsignmentNoteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;

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
        
        if (response.isSuccess) {
            NSDictionary *dict = ((NSArray *)response.json).lastObject;
            [self.dataArr removeAllObjects];
            if ([dict[@"state"] isEqualToString:@"success"]) {
                 [self.dataArr addObject:[ConsignmentNoteModel yy_modelWithJSON:dict[@"data"]]];
            }
            [self.tableView reloadData];
        }else {
            
        }
        
        NSLog(@"%@成功",response);
    } failure:^(FCBaseResponse *response) {
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}


-(void)setUpUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height, FCWidth, FCHeight-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height) style:0];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[ConsignmentNoteCell class] forCellReuseIdentifier:ktableViewKey];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsignmentNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:ktableViewKey forIndexPath:indexPath];
//    ConsignmentNoteModel *model = _dataArr[indexPath.row];
//    cell.model = model;
    return cell;
}

-(void)queryBtnAction:(UIButton*)btn
{
    
}
-(void)refreshBtnAction:(UIButton*)btn
{
    
}

@end
