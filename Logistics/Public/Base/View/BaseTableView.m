//
//  FCBaseTableView.m
//  风车医生
//
//  Created by lin on 2017/4/5.
//  Copyright © 2017年 FC. All rights reserved.
//

#import "BaseTableView.h"
#import "UITableView+Gzw.h"
#import "UIImage+Gif.h"

@interface BaseTableView()

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@end

@implementation BaseTableView

- (void)dealloc
{
    
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        _tableViewStyle = style;
        _pageNO = 1;
        _pageSize = 10;
        _isEmpty = NO;
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
        //  去掉空白多余的行
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)setIsOpenHeaderRefresh:(BOOL)isOpenHeaderRefresh
{
    if (_isOpenHeaderRefresh != isOpenHeaderRefresh) {
        _isOpenHeaderRefresh = isOpenHeaderRefresh;
        
        if (isOpenHeaderRefresh) {
            //  设置头部刷新
            __weak typeof(self) weakSelf = self;
            MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
                weakSelf.pageNO = 1;
                [weakSelf headerRequestWithData];
            }];
            NSURL *gifImageUrl = [[NSBundle mainBundle] URLForResource:@"RefreshLoad" withExtension:@"gif"];
            UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:gifImageUrl];
            [header setImages:@[image] forState:MJRefreshStateRefreshing];
            header.lastUpdatedTimeLabel.hidden= YES;
            header.gifView.mj_w = 30;
            header.gifView.mj_h = 30;
            self.mj_header = header;
        }else {
            self.mj_header = nil;
        }
    }
}

- (void)setIsOpenFooterRefresh:(BOOL)isOpenFooterRefresh
{
    if (_isOpenFooterRefresh != isOpenFooterRefresh) {
        _isOpenFooterRefresh = isOpenFooterRefresh;
        if (isOpenFooterRefresh) {
            __weak typeof(self) weakSelf = self;
            MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
                if(weakSelf.pageNO >0){
                    weakSelf.pageNO += 1;
                }
                [weakSelf footerRequestWithData];
            }];
            NSURL *gifImageUrl = [[NSBundle mainBundle] URLForResource:@"RefreshLoad" withExtension:@"gif"];
            UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:gifImageUrl];
            [footer setImages:@[image] forState:MJRefreshStateRefreshing];
            self.mj_footer = footer;
        }else {
            self.mj_footer = nil;
        }
    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageNO = 1;
        _pageSize = 10;
    }
    return self;
}

- (void)reloadDataWithArray:(NSArray *)array
{
    if (self.pageNO == 1) {
        [self.dataArray removeAllObjects];
        if (array.count == 0) {
            self.isEmpty = YES;
        }
    }
    
    [self.dataArray addObjectsFromArray:array];
    
    if (self.dataArray.count > 0) {
        [self clearEmpty];
    }
    [self reloadData];
    [self endRefreshing];
}

- (void)endRefreshing
{
    //  结束头部刷新
    [self.mj_header endRefreshing];
    //  结束尾部刷新
    [self.mj_footer endRefreshing];
}

- (void)noMoreData{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetFooterView{
    [self.mj_footer resetNoMoreData];
}

- (void)clearEmpty {
    self.dataVerticalOffset = 0;
    self.buttonText = nil;
    self.descriptionText = @"";
    self.buttonNormalColor = [UIColor lightGrayColor];
    self.loadedImageName = nil;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


#pragma mark -- UITableViewDelegate 分割线定格

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, FCWidth, 0.1)];
    label.backgroundColor = [UIColor colorWithHex:0xd9d9d9];
    return label;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)headerRequestWithData
{
    //  空操作
}

- (void)footerRequestWithData
{
    //  空操作
}

- (void)headerRequestDataNoAnimation {
    self.pageNO = 1;
    [self headerRequestWithData];
}

- (void)footerRequestDataNoAnimation {
    self.pageNO++;
    [self footerRequestWithData];
}

- (void)setRemindreImageName:(NSString *)imageName text:(NSString *)text completion:(void(^)())completionBlock
{
    self.loading = YES;
    self.buttonText = text;
    self.descriptionText = @"";
    self.buttonNormalColor = [UIColor lightGrayColor];
    self.loadedImageName = imageName;
    self.loading = NO;
    
    [self gzwLoading:^{
        if (completionBlock) {
            completionBlock();
        }
    }];
}

- (void)setRemindreImageName:(NSString *)imageName text:(NSString *)text offsetY:(CGFloat)offsetY completion:(void(^)())completionBlock
{
    self.loading = YES;
    self.dataVerticalOffset = offsetY;
    self.buttonText = text;
    self.descriptionText = @"";
    self.buttonNormalColor = [UIColor lightGrayColor];
    self.loadedImageName = imageName;
    self.loading = NO;
    
    [self gzwLoading:^{
        if (completionBlock) {
            completionBlock();
        }
    }];
}

- (void)removeEmptyView {
    [self setRemindreImageName:@"" text:@"" completion:nil];
}

- (void)reloadEmptyData {
    if (self.dataArray.count == 0) {
        [self setRemindreImageName:@"Cry" text:NSLocalizedString(@"Tip_no_data", nil) offsetY:-50 completion:^{}];
    }else {
        [self removeEmptyView];
    }
}
- (void)reloadEmptyDatawithText:(NSString *)text {
    if (self.dataArray.count == 0) {
        [self setRemindreImageName:@"Cry" text:NSLocalizedString(@"Tip_no_data", nil) offsetY:-50 completion:^{}];
    }else {
        [self removeEmptyView];
    }
}
- (void)reloadEmptyData:(NSString *)imageName message:(NSString *)message {
    if (self.dataArray.count == 0) {
        [self setRemindreImageName:imageName text:message offsetY:-50 completion:^{}];
    }else {
        [self removeEmptyView];
    }
}
@end
