//
//  AddressBookViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/14.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "AddressBookViewController.h"
#import "ProfileTableViewCell.h"
#import "WebsiteMessageViewController.h"
@interface AddressBookViewController ()<UITableViewDataSource,UITableViewDelegate,HSLimitTextDelegate,UITextFieldDelegate>
@property (nonatomic, strong)BaseTableView *tableView;
@property (nonatomic, strong)NSArray *iconArray;
@property (nonatomic, strong) HSLimitText *searchBar;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong)NSArray *accessArray;
@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = kGlobalViewBgColor;
     [self setupUI];
}

- (void)setupUI {
    
    self.iconArray = @[@"员工",@"网点"];
    self.accessArray = @[[UIImage imageNamed:@"gengduo"],[UIImage imageNamed:@"gengduo"]
                        ];
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
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView *view = [UIView new];
    _tableView.tableFooterView = view;
    [self.view addSubview:_tableView];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.numberOfTapsRequired = 1;
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
   
}
-(void) hideKeyboard {
    [_searchBar.textField resignFirstResponder];
}
- (void)searchBtnAction:(UIButton*)btn {

}

#pragma mark - UITableViewDelegate/Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.iconArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[ProfileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    [cell showRedBadge:NO];
    [cell setupIcon:self.iconArray[indexPath.row] title:self.iconArray[indexPath.row] accessView:self.accessArray[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WebsiteMessageViewController *vc = [WebsiteMessageViewController new];
    if (indexPath.row == 0) {
        vc.status = 2;
    }else {
        vc.status = 1;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}



@end
