//
//  BaseSegmentViewController.h
//  Logistics
//
//  Created by tulemos on 2018/10/17.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseSegmentViewController : UIViewController
@property (nonatomic, assign) BOOL isNeedIndicatorPositionChangeItem;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,strong) NSArray *controllerArr;

@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic,copy) NSString *titleStr;

@property (nonatomic,strong) UIButton *batchBtn;

- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
