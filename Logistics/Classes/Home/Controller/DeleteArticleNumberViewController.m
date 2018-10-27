//
//  DeleteArticleNumberViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/13.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "DeleteArticleNumberViewController.h"
#import "ArticleNumberCell.h"
#import "ConsignmentNoteModel.h"
#define kArticleNumberCell  @"kArticleNumberCell"
@interface DeleteArticleNumberViewController ()<UITableViewDelegate,UITableViewDataSource,HSLimitTextDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) HSLimitText *searchBar;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) ConsignmentNoteModel*model;
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
    
    deleteBtn.frame = CGRectMake(0, 0, 70, 16);
    
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: delete,nil]];
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
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(textView.frame)+8, FCWidth, FCHeight-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height) style:0];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UIView *view = [UIView new];
    _tableView.tableFooterView = view;
    [_tableView registerClass:[ArticleNumberCell class] forCellReuseIdentifier:kArticleNumberCell];
    
    
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
    ArticleNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleNumberCell forIndexPath:indexPath];
    ConsignmentNoteModel *model = _tableView.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = 0;
    
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 3, 15)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#567CD4"];


    UILabel *titleLabel = [UILabel labelWithFont:16 textColor:[UIColor colorWithHex:0x333333] text:nil];
    titleLabel.frame = CGRectMake(26, 11, 200, 22);
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, FCWidth, 38)];
    bgView.backgroundColor = [UIColor whiteColor];
    UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0,38,FCWidth, 1)];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [bgView addSubview:lineView];
    titleLabel.text = @"查询结果";
    [bgView addSubview:titleLabel];
    [bgView addSubview:bottomLineView];
    return  bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleNumberCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    if (_dataArr.count > 0) {
        _model = _tableView.dataArray[indexPath.row];
    }

}
//删除
-(void)deleteBtnAction:(UIButton*)btn
{
    if ([NSString isBlankString:_model.EntNumber]) {
         [FCProgressHUD showText:@"请选择运单"];
        return;
    }
    NSDictionary *param = [NSDictionary requestWithUrl:@"deletebill" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"EntNumber":_model.EntNumber}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
          NSDictionary *adic = dic[@"data"][0];
            if ([[NSString stringWithFormat:@"%@",adic[@"responseCode"]] isEqualToString:@"0"]) {
                [FCProgressHUD showText:@"删除成功"];
                [self.tableView.dataArray removeAllObjects];
                [self.tableView reloadEmptyData];
            }else{
                [FCProgressHUD showText:adic[@"responseMsg"]];
            }
            
        }else{
            
        }
        [_tableView reloadData];
        NSLog(@"%@成功",response);
    } failure:^(FCBaseResponse *response) {
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}
//刷新
-(void)refreshBtnAction:(UIButton*)btn
{
       [self getSearchWithText:self.searchBar.text];
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
    if ([NSString isBlankString:_searchBar.textField.text]) {
        [FCProgressHUD showText:@"请输入货号"];
        return;
    }
    [_dataArr removeAllObjects];
    NSString *startTimeStr;
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    startTimeStr= [format1 stringFromDate:date];
    NSString *finishStr;
    NSDate * date1 = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    //一周的秒数
    NSTimeInterval time = 7 * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastWeek = [date1 dateByAddingTimeInterval:-time];
    finishStr =  [dateFormatter stringFromDate:lastWeek];
    
    
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetConsignmentDataList" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"entNumber":_searchBar.textField.text,@"pageindex":@(self.tableView.pageNO),@"pagesize":@(self.tableView.pageSize),@"StartTime":startTimeStr,@"EndTime":finishStr,@"StockID":@"",@"EntStartID":@"",@"EntEndID":@""}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            NSDictionary *adic = dic[@"data"][0];
            NSLog(@"%@",adic[@"billinfo"]);
            //            _dataArr = [ConsignmentNoteModel yy_modelWithJSON:adic[@"billinfo"]];
            [_dataArr  addObject:[ConsignmentNoteModel yy_modelWithJSON:adic[@"billinfo"]]];
            [self.tableView reloadDataWithArray:_dataArr];
            [self.tableView reloadEmptyData];
        }else{
            NSDictionary *dict =dic[@"data"][0];
            [FCProgressHUD showText:dict[@"errorMsg"]];
        }
        [_tableView reloadData];
        NSLog(@"%@成功",response);
    } failure:^(FCBaseResponse *response) {
        [_dataArr removeAllObjects];
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}

@end
