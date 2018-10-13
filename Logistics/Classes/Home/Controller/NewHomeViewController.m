//
//  NewHomeViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/12.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "NewHomeViewController.h"
#import "NewHomeFirstCell.h"
NSString *const HomeCellIdentifier = @"HomeCellCellId";
@interface NewHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *topImgView;


@end

@implementation NewHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    //    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.hidden = YES;
    [self setupUI];
}

-(void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    _topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FCWidth, FCWidth*0.45)];
    _topImgView.image = [UIImage imageNamed:@"home_topImg"];
    [self.view addSubview:_topImgView];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,FCWidth*0.45, FCWidth, FCHeight-FCWidth*0.45-self.tabBarController.tabBar.frame.size.height) style:0];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[NewHomeFirstCell class] forCellReuseIdentifier:HomeCellIdentifier];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 170;
    }else if (indexPath.row == 1)
    {
        return 85;
    }else{
        return 85;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        NewHomeFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:HomeCellIdentifier forIndexPath:indexPath];
        firstCell.selectionStyle = 0;
        return firstCell;
    }else{

    static NSString * str = @"cellStr";
    ///<2.>复用机制:如果一个页面显示7个cell，系统则会创建8个cell,当用户向下滑动到第8个cell时，第一个cell进入复用池等待复用。
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    ///<3.>新建cell
    if (cell == nil) {
        //副标题样式
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    return cell;
    }
}


@end

