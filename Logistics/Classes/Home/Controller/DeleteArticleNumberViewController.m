//
//  DeleteArticleNumberViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/13.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "DeleteArticleNumberViewController.h"
#import "ArticleNumberCell.h"
#define kArticleNumberCell  @"kArticleNumberCell"
@interface DeleteArticleNumberViewController ()<UITableViewDelegate,UITableViewDataSource,HSLimitTextDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HSLimitText *searchBar;
@property (nonatomic, strong) UIButton *searchBtn;
@end

@implementation DeleteArticleNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    self.view.backgroundColor = kGlobalViewBgColor;
    self.title = @"删除货号";
    UIButton *deleteBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    [deleteBtn setFrame:CGRectMake(15.0, 0.0, 70, 16)];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    deleteBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    deleteBtn.backgroundColor=[UIColor clearColor];
    [deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *refreshBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [refreshBtn setFrame:CGRectMake(15.0, 0.0, 45, 16)];
    [refreshBtn setTitle:@"刷新" forState:(UIControlStateNormal)];
    [refreshBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    refreshBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    refreshBtn.backgroundColor=[UIColor clearColor];
    [refreshBtn addTarget:self action:@selector(refreshBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    deleteBtn.frame = CGRectMake(0, 0, 70, 16);
    refreshBtn.frame=CGRectMake(0, 0, 35, 16);
    
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: delete, refresh,nil]];
    [self setUpUI];
//    [self getData];
}

-(void)setUpUI
{
    HSLimitText *textView = [[HSLimitText alloc] initWithFrame:CGRectMake(12,Navigation_Height+8, FCWidth-71, 28) type:TextInputTypeTextfield];
    textView.placeholder = @"请输入货号";
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
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(textView.frame)+8, FCWidth, FCHeight-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height) style:0];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[ArticleNumberCell class] forCellReuseIdentifier:kArticleNumberCell];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleNumberCell forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//删除
-(void)deleteBtnAction:(UIButton*)btn
{
    
}
//刷新
-(void)refreshBtnAction:(UIButton*)btn
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.searchBar.textField)
    {
        if (textField.text.length) {
            [self getSearchWithText:textField.text];
            
        }else{
            
        }
        
    }
    return YES;
}

-(void)searchBtnAction:(UIButton *)btn
{
    if (_searchBar.textField.text.length) {
        [self getSearchWithText:_searchBar.textField.text];
    }
}
//搜索
-(void)getSearchWithText:(NSString *)text
{
    
    NSDictionary *param = [NSDictionary requestWithUrl:@"deletebill" param:@{@"userID":@"22e3fc13-a2c1-45ce-b413-efd8a403af1b",@"EntNumber":@"G333-061216-36"}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        
        if (response.isSuccess) {
            
        }else {
            
        }
        NSLog(@"%@成功",response);
    } failure:^(FCBaseResponse *response) {
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}

@end
