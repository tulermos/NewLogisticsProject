//
//  HelperViewController.m
//  Logistics
//
//  Created by meng wang on 2018/4/24.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "HelperViewController.h"
#import "WLHomeCollectionViewCell.h"
#import "TransportViewController.h"
#import "TransformDescViewController.h"
#import "PackViewController.h"
#import "PriceSumViewController.h"

#define kCollectionViewKey  @"kCollectionViewKey"

@interface HelperViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *iconArray;
@property (nonatomic, strong)NSArray *titleArray;

@end

@implementation HelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.title = NSLocalizedString(@"Home_yewuzhushou", nil);
    self.navigationController.navigationBar.hidden = YES;
    self.iconArray = @[@"yunshuyaoqiu",@"jiagegusuan",@"baozhuangjieshao",@"yunshujieshao"];
    self.titleArray = @[
                        NSLocalizedString(@"Help_yaoqiu", nil),
                        NSLocalizedString(@"Help_jiage", nil),
                        NSLocalizedString(@"Help_baozhuang", nil),
                        NSLocalizedString(@"Help_yunshu", nil),
                        ];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[WLHomeCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewKey];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(FCNavigationHeight);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark - UICollectionviewDataSource/delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WLHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewKey forIndexPath:indexPath];
    [cell setUpIcon:_iconArray[indexPath.item] title:_titleArray[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    if (indexPath.item == 0) {
        vc = [[TransportViewController alloc]init];
    }else if (indexPath.item == 1) {
        vc = [[PriceSumViewController alloc]init];
    }else if (indexPath.item == 2) {
        vc = [[PackViewController alloc]init];
    }else {
        vc = [[TransformDescViewController alloc]init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((FCWidth - 0.5) * 0.5, 140);
        layout.minimumLineSpacing = 0.5;
        layout.minimumInteritemSpacing = 0.5;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor colorWithHex:0xf1f1f1];
    }
    return _collectionView;
}

@end
