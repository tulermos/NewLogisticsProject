//
//  MessageViewController.m
//  CollectionTests
//
//  Created by meng wang on 2018/4/19.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "MessageViewController.h"
#import "JPushModel.h"
#import "MessageDetailViewController.h"
#import "JPushTableViewCell.h"
#import "BaseTableView.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)BaseTableView *tableView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
    
}

- (void)setupUI {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:kNotificationNameJpushChange object:nil];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(10);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

- (void)loadData {
    [self.tableView.dataArray removeAllObjects];
    [self.tableView reloadDataWithArray:[JPushManager getJPushObjects]];
    [self.tableView reloadEmptyData];
    [self updateBadge];
}

#pragma mark - UITableViewDelegate/DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableView.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JPushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[JPushTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.model = self.tableView.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MessageDetailViewController *detailVc = [[MessageDetailViewController alloc]init];
    JPushModel *model = self.tableView.dataArray[indexPath.row];
    model.isRead = YES;
    [JPushManager updateJPushObject:model];
    detailVc.content = model.content;
    [self.navigationController pushViewController:detailVc animated:YES];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self updateBadge];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //chexiao
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.tableView.dataArray removeObjectAtIndex:indexPath.row];
        [JPushManager removeJPushObjectForIndex:indexPath.row];
        [self.tableView reloadData];
        [self.tableView reloadEmptyData];
    }];
    return @[deleteRowAction];
}

- (void)updateBadge {
    NSInteger unreadCount = 0;
    for (JPushModel *model in self.tableView.dataArray) {
        if (!model.isRead) {
            unreadCount += 1;
        }
    }
    NSString *value = [NSString stringWithFormat:@"%zd",unreadCount];
    if (unreadCount == 0) {
        value = nil;
    }
    [[[self.tabBarController.tabBar items]objectAtIndex:2]setBadgeValue:value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
