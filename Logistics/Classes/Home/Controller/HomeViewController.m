//
//  HomeViewController.m
//  CollectionTests
//
//  Created by meng wang on 2018/4/19.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "HomeViewController.h"
#import "WLHomeCollectionViewCell.h"
#import "WaybillQueryViewController.h"
#import "WebsiteMessageViewController.h"
#import "HelperViewController.h"
#import "QueryViewController.h"
#import <SDCycleScrollView.h>
#import "ConsignmentNoteViewController.h"
#define kCollectionViewKey  @"kCollectionViewKey"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *iconArray;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong) NSDictionary * dataDic;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getData];
    
}

- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupUI {
    
    self.navigationController.navigationBar.hidden = YES;
    
    _dataDic = @{@"first":@[@"收货登记",@"打包单据",@"计量单据",@"托运单",@"",@""],@"second":@[@"货物跟踪",@"客户统计",@""],@"third":@[@"删除货号",@"待开单",@""]};
    
    self.iconArray =  @[@"收货登记",@"打包单据",@"计量单据",@"托运单",@"",@""];
    self.titleArray =  @[@"收货登记",@"打包单据",@"计量单据",@"托运单",@"",@""];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[WLHomeCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewKey];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - UICollectionviewDataSource/delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return 6;
    }else{
        return 3;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WLHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewKey forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell setUpIcon:_dataDic[@"first"][indexPath.item] title:_dataDic[@"first"][indexPath.item]];
    }else if (indexPath.section == 1)
    {
         [cell setUpIcon:_dataDic[@"second"][indexPath.item] title:_dataDic[@"second"][indexPath.item]];
    }else{
        [cell setUpIcon:_dataDic[@"third"][indexPath.item] title:_dataDic[@"third"][indexPath.item]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.item == 0){
           
        }else if(indexPath.item == 1) {

        }else if (indexPath.item == 2) {

        }else if (indexPath.item == 3) {
            ConsignmentNoteViewController *noteController = [ConsignmentNoteViewController new];
            [self.navigationController pushViewController:noteController animated:YES];
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.item == 0) {
           
        }else if(indexPath.item == 1) {
         
        }
    }else{
        if (indexPath.item == 0) {
       
        }else if(indexPath.item == 1) {
    
        }
    }
  
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 3, 15)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#567CD4"];
    UILabel *titleLabel = [UILabel labelWithFont:16 textColor:[UIColor colorWithHex:0x333333] text:nil];
    titleLabel.frame = CGRectMake(26, 11, 200, 22);
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        UIImageView*topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FCWidth, FCWidth*0.45)];
        topImgView.image = [UIImage imageNamed:@"home_topImg"];
        [headerView addSubview:topImgView];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(topImgView.frame), FCWidth, 38)];
        bgView.backgroundColor = [UIColor colorWithHexString:@"0xefeff4"];
        [headerView addSubview:bgView];
        [bgView addSubview:lineView];
        titleLabel.text = @"主营业务";
        [bgView addSubview:titleLabel];
        
    }else if (indexPath.section == 1){
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FCWidth, 38)];
        bgView.backgroundColor = [UIColor colorWithHexString:@"0xefeff4"];
        [headerView addSubview:bgView];
        [bgView addSubview:lineView];
        titleLabel.text = @"统计分析";
        [bgView addSubview:titleLabel];
    }else{
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FCWidth, 38)];
        bgView.backgroundColor = [UIColor colorWithHexString:@"0xefeff4"];
        [headerView addSubview:bgView];
        [bgView addSubview:lineView];
        titleLabel.text = @"系统维护";
        [bgView addSubview:titleLabel];
    }
    
    return headerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(FCWidth, FCWidth*0.45+38);
    }else{
         return CGSizeMake(FCWidth, 38);
    }
}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((FCWidth - 2)/3, 169/2);
        layout.minimumLineSpacing = 0.5;
        layout.minimumInteritemSpacing = 0.5;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor colorWithHex:0xf1f1f1];
    }
    return _collectionView;
}
- (void)getData{
 
    NSDictionary *param = [NSDictionary requestWithUrl:@"getright" param:nil];
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
//货物跟踪的接口
- (void)getCargoTrackingData{
    
    NSDictionary *param = [NSDictionary requestWithUrl:@"cargotrack" param:nil];
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
