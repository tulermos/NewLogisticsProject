//
//  ProfileViewController.m
//  CollectionTests
//
//  Created by meng wang on 2018/4/19.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "ProfileViewController.h"
#import "FeedbackViewController.h"
#import "SettingViewController.h"
#import "ProfileTableViewCell.h"
#import "ProfileHeaderView.h"
#import "CHAlertAction.h"

@interface ProfileViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)BaseTableView *tableView;
@property (nonatomic, strong)ProfileHeaderView *headerView;
@property (nonatomic, strong)NSArray *iconArray;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)NSArray *accessArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupUI {
    
    self.iconArray = @[@"系统设置"];
    self.accessArray = @[[UIImage imageNamed:@"gengduo"],
                         [NSString stringWithFormat:@"v %@",[NSString appVersion]]];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(140);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headerView.mas_bottom);
        make.leading.bottom.trailing.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    [cell setupIcon:self.iconArray[indexPath.row] title:self.iconArray[indexPath.row] accessView:self.accessArray[indexPath.row]];
    [cell showRedBadge:NO];
    if (indexPath.row == 1) {
        [cell showRedBadge:[UserManager sharedManager].isUpdate];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FCWidth, 100)];
    UIButton *loginOutView = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, FCWidth, 50)];
    [loginOutView setTitle:NSLocalizedString(@"Profile_loginOut", nil) forState:UIControlStateNormal];
    [loginOutView setBackgroundColor:[UIColor whiteColor]];
    [loginOutView setTitleColor:kGlobalMainColor forState:UIControlStateNormal];
    loginOutView.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginOutView addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:loginOutView];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        SettingViewController *vc = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if ([UserManager sharedManager].isUpdate) {
            NSString *url = [[NSUserDefaults standardUserDefaults]objectForKey:kAppServerAppUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (void)loginOut {
    [[UserManager sharedManager]clearUserData];
    [JPushManager removeAlias];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationNameUpdateRootVc object:nil];
}

#pragma mark - TableView
- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (ProfileHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [ProfileHeaderView profileHeaderView];
    }
    return _headerView;
}

@end
