//
//  CustomerStatisticsViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/14.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "CustomerStatisticsViewController.h"
#import "CustomerStatisticsModel.h"
#import "CustomerStatisticsCell.h"
#define kCustomerStatisticsCell @"kCustomerStatisticsCell"
@interface CustomerStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource,HSLimitTextDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) HSLimitText *searchBar;
@property (nonatomic, strong) UIButton *searchBtn;
@end

@implementation CustomerStatisticsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    self.view.backgroundColor = kGlobalViewBgColor;
    self.title = @"客户统计";
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake(0,0,60,44);
    [but setTitle:@"刷新"forState:UIControlStateNormal];
    [but addTarget:self action:@selector(Next:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;

    [self setUpUI];
    [self getData];
}
-(void)setUpUI
{
    HSLimitText *textView = [[HSLimitText alloc] initWithFrame:CGRectMake(12,Navigation_Height+8, FCWidth-71, 28) type:TextInputTypeTextfield];
    textView.placeholder = @"请输入客户名称/销售员编码";
    textView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    textView.labPlaceHolder.textColor = [UIColor colorWithHexString:@"0x999999"];
    textView.labPlaceHolder.font = [UIFont systemFontOfSize:15];
    textView.textField.textColor = [UIColor blackColor];
    textView.textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    textView.textField.returnKeyType = UIReturnKeySearch;
    textView.delegate = self;
    textView.textField.delegate = self;
    // 通过init初始化的控件大多都没有尺寸
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"sousuo"];
    // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
    searchIcon.contentMode = UIViewContentModeCenter;
    searchIcon.size = CGSizeMake(30, 30);
    textView.textField.leftView = searchIcon;
    textView.textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textView];
    _searchBar = textView;
    
    _searchBtn = [UIButton buttonWithType:0];
    _searchBtn.frame = CGRectMake(CGRectGetMaxX(textView.frame),Navigation_Height, FCWidth-CGRectGetMaxX(textView.frame), 44);
    [_searchBtn setTitle:@"查询" forState:0];
    [_searchBtn setTitleColor:kGlobalMainColor forState:0];
    _searchBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [_searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:1<<6];
    [self.view addSubview:_searchBtn];
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(textView.frame)+8, FCWidth, FCHeight-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height) style:0];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[CustomerStatisticsCell class] forCellReuseIdentifier:kCustomerStatisticsCell];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableView.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomerStatisticsCell forIndexPath:indexPath];
    CustomerStatisticsModel *model = _tableView.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = 0;
    return cell;
}
-(void)getData
{
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetCustomerData" param:@{@"userID":@"22e3fc13-a2c1-45ce-b413-efd8a403af1b"}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        
        if (response.isSuccess) {
            NSDictionary *dict = ((NSArray *)response.json).lastObject;
            [self.dataArr removeAllObjects];
            if ([dict[@"state"] isEqualToString:@"success"]) {
                [self.dataArr addObject:[CustomerStatisticsModel yy_modelWithJSON:dict[@"data"]]];
            }
            
           
        }else {
            
        }
        [self.tableView reloadData];
        [self.tableView reloadEmptyData];
        NSLog(@"%@成功",response);
    } failure:^(FCBaseResponse *response) {
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}



@end
