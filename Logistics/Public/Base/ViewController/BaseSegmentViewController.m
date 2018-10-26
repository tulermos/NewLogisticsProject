//
//  BaseSegmentViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/17.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "BaseSegmentViewController.h"

@interface BaseSegmentViewController ()<JXCategoryViewDelegate>

@end

@implementation BaseSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = _titleStr;
      self.view.backgroundColor = kGlobalViewBgColor;
    if (self.status != 3) {
    _batchBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [_batchBtn setTitle:@"批处理" forState:(UIControlStateNormal)];
    [_batchBtn setFrame:CGRectMake(15.0, 0.0, 70, 16)];
    [_batchBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _batchBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _batchBtn.backgroundColor=[UIColor clearColor];
    [_batchBtn addTarget:self action:@selector(batchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *refreshBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [refreshBtn setFrame:CGRectMake(15.0, 0.0, 45, 16)];
//    [refreshBtn setTitle:@"刷新" forState:(UIControlStateNormal)];
//    [refreshBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//    refreshBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [refreshBtn setBackgroundImage:[UIImage imageNamed:@"导航刷新"] forState:0];
    refreshBtn.backgroundColor=[UIColor clearColor];
  
    [refreshBtn addTarget:self action:@selector(refreshBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *searchBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [searchBtn setFrame:CGRectMake(15.0, 0.0, 45, 16)];
    //    [refreshBtn setTitle:@"刷新" forState:(UIControlStateNormal)];
    //    [refreshBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    //    refreshBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"导航搜索"] forState:0];
     searchBtn.backgroundColor=[UIColor clearColor];
    [searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _batchBtn.frame = CGRectMake(0, 0, 70, 16);
    refreshBtn.frame=CGRectMake(0, 0, 35, 16);
    searchBtn.frame=CGRectMake(0, 0, 35, 16);
    [refreshBtn sizeToFit];
    [searchBtn sizeToFit];
    UIBarButtonItem *batch = [[UIBarButtonItem alloc] initWithCustomView:_batchBtn];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:search ,refresh, batch,nil]];
    }
    NSUInteger count = _titleArr.count;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,Navigation_Height+44, FCWidth, FCHeight-Navigation_Height-44)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(FCWidth*2, FCHeight-Navigation_Height-44);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    for (int i = 0; i < count; i ++) {
        UIViewController *listVC = [[_controllerArr[i] alloc] init];
        [self configListViewController:listVC index:i];
        [self addChildViewController:listVC];
        listVC.view.frame = CGRectMake(i*FCWidth, 0, FCWidth, FCHeight-Navigation_Height-44);
        [self.scrollView addSubview:listVC.view];
    }
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame: CGRectMake(0,Navigation_Height,FCWidth, 44)];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.contentScrollView = self.scrollView;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titles = _titleArr;
    self.categoryView.cellSpacing = 0;
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleSelectedColor = kGlobalMainColor;
    self.categoryView.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    JXCategoryIndicatorLineView *IndicatorLineView = [[JXCategoryIndicatorLineView alloc] init];
    IndicatorLineView.indicatorLineWidth = FCWidth/2;
//    IndicatorLineView.verticalMargin = 5;
    IndicatorLineView.indicatorLineViewHeight = 2;
    IndicatorLineView.indicatorLineViewColor =kGlobalMainColor ;
    self.categoryView.indicators = @[IndicatorLineView];
    [self.view addSubview:self.categoryView];
}
- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index {
    
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
- (JXCategoryTitleView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [[JXCategoryTitleView alloc] init];
    }
    return _categoryView;
}

@end
