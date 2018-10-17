//
//  MessageViewController.m
//  Logistics
//
//  Created by meng wang on 2018/4/24.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WebsiteMessageViewController.h"
#import "AddressBookTableViewCell.h"
#import "AddressBookAlertView.h"
#import "CompanyInfoModel.h"
#import "CompanyInfoSectionModel.h"
#import "SearchBar.h"
#import <LJContactManager.h>
#import <LJPerson.h>
#import "BaseTableView.h"

@interface WebsiteMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)SearchBar *searchBar;
@property (nonatomic, strong)BaseTableView *tableView;
@property (nonatomic, strong)NSArray *allModels;
@property (nonatomic, strong)NSArray *keys;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation WebsiteMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    [self setupUI];
    if (_status == 1) {
        self.title = @"网点";
        [self loadDataWithUrl:@"company"];
    }else
    {
        self.title = @"员工";
        [self loadDataWithUrl:@"staff"];
    }
}

- (void)setupUI {
//    self.title = NSLocalizedString(@"Home_wangdianchaxun", nil);
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    @weakify(self);
    self.searchBar.didChangeBlock = ^(NSString *text) {
        @strongify(self);
        [self didSearchInputChange:text];
    };
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(FCNavigationHeight);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_searchBar.mas_bottom);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

- (void)didSearchInputChange:(NSString *)text {
    if (text.length == 0) {
        [self sortForSectionModel:self.allModels];
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.allModels.count];
    for (CompanyInfoModel *model in self.allModels) {
        if ([model.companyNamePY containsString:text] || [model.companyName containsString:text]){
            [array addObject:model];
        }
    }
    [self sortForSectionModel:array];
}

- (void)loadDataWithUrl:(NSString *)url {
   
    NSDictionary *dict = [NSDictionary requestWithUrl:url param:nil];
    [FCHttpRequest FCNetWork:HttpRequestMethodPost url:nil model:nil cache:NO param:dict success:^(FCBaseResponse *response) {
        if ([response.json[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
//            NSArray *models = [NSArray yy_modelArrayWithClass:[CompanyInfoModel class] json:dict[@"staffInfo"]];
            /*
            @property (nonatomic, strong)NSString *companyName;
            @property (nonatomic, strong)NSString *companyNamePY;
            @property (nonatomic, strong)NSString *RussianName;
            @property (nonatomic, strong)NSString *companyAddress;
            @property (nonatomic, strong)NSString *companyLinkMan;
            @property (nonatomic, strong)NSString *contactName;
            @property (nonatomic, strong)NSString *contactTel;
            @property (nonatomic, strong)NSString *companyEmail;
            @property (nonatomic, strong)NSString *companyNumber;
             */
//            CompanyInfoModel *company = [CompanyInfoModel yy_modelWithJSON:<#(nonnull id)#>]
            if ([url isEqualToString:@"staff"]) {
            for (NSDictionary *bdic in dict[@"staffInfo"]) {
                CompanyInfoModel *company  = [CompanyInfoModel new];
                 company.companyEmail =bdic[@"email"];
//                 company.contactName =bdic[@"company"];
                 company.companyNumber =bdic[@"telphone"];
                 company.companyName =bdic[@"staffname"];
//                company.companyAddress = 
                [_dataArr addObject:company];
              }
            }else{
                for (NSDictionary *bdic in dict[@"companyInfo"]) {
                    CompanyInfoModel *company  = [CompanyInfoModel new];
                    company.companyEmail =bdic[@"companyEmail"];
//                    company.companyLinkMan =bdic[@"companyLinkMan"];
                    company.companyNumber =bdic[@"companyNumber"];
                    company.companyName =bdic[@"companyName"];
                    company.companyAddress = bdic[@"companyAddress"];
                    [_dataArr addObject:company];
                }
            }
        
            [self sortForSectionModel:[_dataArr copy]];
            self.allModels = [_dataArr copy];
            NSLog(@"%@",response.json);
        }
    } failure:^(FCBaseResponse *response) {
        
    }];

}

- (void)sortForSectionModel:(NSArray *)models {
    NSMutableDictionary *sectionDict = [NSMutableDictionary dictionary];
    NSMutableArray *keys = [NSMutableArray array];
    for (CompanyInfoModel *infoModel in models) {
        NSString *firstChar = [[infoModel.companyNamePY substringWithRange:NSMakeRange(0, 1)] uppercaseString];
        if ([sectionDict.allKeys containsObject:firstChar]) {
            NSMutableArray *models = sectionDict[firstChar];
            if (!models) {
                models = [NSMutableArray array];
            }
            [models addObject:infoModel];
        }else {
            NSMutableArray *models = [NSMutableArray array];
            [models addObject:infoModel];
            [sectionDict setObject:models forKey:firstChar];
            [keys addObject:firstChar];
        }
    }
    NSArray *result = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //降序
    }];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in result) {
        NSArray *arrayModels = sectionDict[key];
        [array addObject:arrayModels];
    }
    self.keys = result;
    [self.tableView reloadDataWithArray:array];
}

#pragma mark - UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableView.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.tableView.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[AddressBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    NSArray *array = self.tableView.dataArray[indexPath.section];
    CompanyInfoModel *infoModel = array[indexPath.row];
    [cell setupName:infoModel.companyName tel:infoModel.contactTel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = self.tableView.dataArray[indexPath.section];
    CompanyInfoModel *model = array[indexPath.row];
    NSArray *contents = @[model.companyName?:@"",model.companyAddress?:@"",model.contactName?:@"",model.companyEmail?:@"",model.companyNumber?:@""];
    AddressBookAlertView *alertView = [AddressBookAlertView alertViewWithArray:contents sure:@"拨打电话" cancel:@"取消" completionBlock:^(NSInteger index) {
        if (index == 1) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.companyNumber];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }];
    [alertView show];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.keys;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    LJSectionPerson *sectionModel = self.tableView.dataArray[section];
    return self.keys[section];
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

- (SearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[SearchBar alloc]init];
    }
    return _searchBar;
}

@end
