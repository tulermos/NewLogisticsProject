//
//  FCBaseTableView.h
//  风车医生
//
//  Created by lin on 2017/4/5.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WKRefreshTypeHeader,
    WKRefreshTypeFooter
} WKRefreshType;

@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

/**
 *  页数索引
 */
@property (nonatomic, assign)   NSInteger pageNO;
/**
 *  每页显示多少条
 */
@property (nonatomic, assign)   NSInteger pageSize;
/**
 *  是否还有显示的数据
 */
@property (nonatomic, assign, readonly)   BOOL isEndForLoadmore;
/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/**
 *  列表
 */
@property (nonatomic, assign)NSInteger totalPage;
/**
 *  是否开启头部刷新
 */
@property (nonatomic, assign)   BOOL isOpenHeaderRefresh;
/**
 *  是否开启尾部刷新
 */
@property (nonatomic, assign)   BOOL isOpenFooterRefresh;

@property (nonatomic, copy)    void (^requestBlock)();
@property (nonatomic, copy)    void (^clickSelectedCell)(NSIndexPath *indexPath);

@property (nonatomic,assign) BOOL isEmpty;

/**
 *  根据tableview样式创建tableview
 *
 *  @param style 样式
 *
 *  @return UITableView实例
 */
//- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

/**
 *  刷新
 *
 *  @param array 数据
 */
- (void)reloadDataWithArray:(NSArray *)array;

//-(void)reloadData;
- (void)endRefreshing;
/**
 *  头部刷新请求（子类需要重新）
 */
- (void)headerRequestWithData;
- (void)headerRequestDataNoAnimation;
/**
 *  脚部刷新请求（子类需要重新）
 */
- (void)footerRequestWithData;

- (void)footerRequestDataNoAnimation;

/*
 * 加载完没有数据或网络失败的提示
 */
- (void)setRemindreImageName:(NSString *)imageName text:(NSString *)text completion:(void(^)())completionBlock;

/*
 * 没有更多数据
 */
- (void)noMoreData;

- (void)removeEmptyView;
/*
 * 重置底部刷新
 */
- (void)resetFooterView;
/*
 * 空占位图
 */
- (void)setRemindreImageName:(NSString *)imageName text:(NSString *)text offsetY:(CGFloat)offsetY completion:(void(^)())completionBlock;
/*
 * 刷新空占位图
 */
- (void)reloadEmptyData;
/*
 * 传参刷新空占位图
 */
- (void)reloadEmptyData:(NSString *)imageName message:(NSString *)message;
/*
 * 刷新空占位图 带着占位参数；
 */
- (void)reloadEmptyDatawithText:(NSString *)text;
@end
