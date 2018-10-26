//
//  AnnouncementViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/24.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "AnnouncementViewController.h"
#import "AnnouncementModel.h"
#import "AnnouncementDetailViewController.h"
@interface AnnouncementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) UILabel *subLabel;
@end

@implementation AnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}
-(void)setupUI
{
    _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,10, FCWidth, FCHeight-Navigation_Height-44) style:0];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UIView *view = [UIView new];
    _tableView.tableFooterView = view;
//    [_tableView registerClass:[ArticleNumberCell class] forCellReuseIdentifier:kPackedCellId];
}
-(void)loadData
{
    NSDictionary *param = [NSDictionary requestWithUrl:@"GetPublishList" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"pageindex":@(self.tableView.pageNO),@"pagesize":@(self.tableView.pageSize)}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
            [self.tableView.dataArray removeAllObjects];
            [self.tableView reloadDataWithArray:[NSArray yy_modelArrayWithClass:[AnnouncementModel class] json:dict[@"newsInfo"]]];

            [self.tableView reloadData];
            [self.tableView reloadEmptyData];
            
        }else{
            NSDictionary *dict = ((NSArray *)response.data).firstObject;
            [FCProgressHUD showText:dict[@"errorMsg"]];
        }
    } failure:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    AnnouncementModel *model = _tableView.dataArray[indexPath.row];
    _subLabel = [self getSubtitle:cell];
    _subLabel.text = model.NewTimes;
    cell.textLabel.text = model.Introduction;
    
    return cell;
}
- (UILabel *)getSubtitle:(UITableViewCell *)cell {
    UILabel *SubtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(FCWidth - 230, 0, 200, 50)];
    SubtitleLabel.backgroundColor = [UIColor clearColor];
    SubtitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    SubtitleLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
    SubtitleLabel.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:SubtitleLabel];
    return SubtitleLabel;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementModel *model = _tableView.dataArray[indexPath.row];
    AnnouncementDetailViewController *vc = [[AnnouncementDetailViewController alloc]init];
    vc.title = model.Introduction;
    vc.requestUrl = model.Contents;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - lazy

@end
