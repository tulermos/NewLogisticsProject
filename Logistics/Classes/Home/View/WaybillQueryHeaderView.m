//
//  WaybillQueryHeaderView.m
//  Logistics
//
//  Created by meng wang on 2018/4/21.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "WaybillQueryHeaderView.h"
#import "NSDate+Extension.h"

@interface WaybillQueryHeaderView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *stockView;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stockIcon;
@property (weak, nonatomic) IBOutlet UIView *overView;
@property (weak, nonatomic) IBOutlet UILabel *overLabel;
@property (weak, nonatomic) IBOutlet UIImageView *overIcon;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeIcon;
@property (nonatomic, assign)BOOL isClickStock;
@property (nonatomic, assign)BOOL isClickOver;
@property (nonatomic, assign)BOOL isClickTime;

@property (nonatomic, strong)BaseTableView *tableView;
@property (nonatomic, strong)UIView *converView;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)NSArray *dayArray;

@end

@implementation WaybillQueryHeaderView

+ (instancetype)waybillQueryHeaderView {
    return [[[NSBundle mainBundle]loadNibNamed:@"WaybillQueryHeaderView" owner:nil options:nil]firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.stockLabel.text = @"全部库存";
    self.overLabel.text = @"超期7天";
    self.timeLabel.text = @"今天";
    self.titleArray = @[@"超期7天",@"超期15天",@"超期30天",@"超期45天",@"超期60天"];
    self.dayArray = @[@7,@15,@30,@45,@60];
    [[UIApplication sharedApplication].keyWindow addSubview:self.converView];
    [self addSubview:self.tableView];
    UITapGestureRecognizer *stockGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickStock)];
    [_stockView addGestureRecognizer:stockGesture];
    UITapGestureRecognizer *overGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOver)];
    [_overView addGestureRecognizer:overGesture];
    UITapGestureRecognizer *timeGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTime)];
    [_timeView addGestureRecognizer:timeGesture];
    [self selected:1];
}

- (void)clickStock {
    self.isClickStock = !self.isClickStock;
    self.isClickOver = NO;
    self.isClickTime = NO;
    [self selected:0];
    self.converView.hidden = YES;
    self.tableView.hidden = YES;
    self.mj_h = 50;
    if (self.timeBlock) {
        self.timeBlock([self paramDict:365]);
    }
}

- (void)clickOver {
    if (!self.isClickOver) {
        if (self.timeBlock) {
            self.timeBlock([self paramDict:((NSNumber *)self.dayArray[self.tableView.tag]).integerValue]);
        }
    }
    self.isClickStock = NO;
    self.isClickTime = NO;
    self.isClickOver = !self.isClickOver;
    self.mj_h = self.isClickOver ? 250 : 50;
    [self selected:1];
    self.tableView.hidden = !self.isClickOver;
    self.converView.hidden = !self.isClickOver;
    self.tableView.frame = CGRectMake(0, 50, FCWidth, self.titleArray.count * 44);
    [self.tableView reloadDataWithArray:self.titleArray];
    
}

- (void)clickTime {
    self.isClickStock = NO;
    self.isClickOver = NO;
    self.isClickTime = !self.isClickTime;
    [self selected:2];
    self.converView.hidden = YES;
    self.tableView.hidden = YES;
    self.mj_h = 50;
    if (self.timeBlock) {
        self.timeBlock([self paramDict:0]);
    }
}

- (void)clickConver {
}

- (void)selected:(NSInteger)index {
    self.converView.hidden = YES;
    self.stockLabel.textColor = [UIColor blackColor];
    self.overLabel.textColor = [UIColor blackColor];
    self.timeLabel.textColor = [UIColor blackColor];
    if (index == 0) {
        self.stockLabel.textColor = kGlobalMainColor;
    }else if (index == 1) {
        self.overLabel.textColor = kGlobalMainColor;
    }else {
        self.timeLabel.textColor = kGlobalMainColor;
    }
}

- (NSDictionary *)paramDict:(NSInteger)day {
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *todayDate = [NSDate date];
    NSDate *startDate = [todayDate dateByAddingDays:-1 * day];
    NSString *todayStr = [format stringFromDate:todayDate];
    NSString *startStr = [format stringFromDate:startDate];
    NSDictionary *dict = @{@"start":startStr,@"end":todayStr};
    return dict;
}

- (void)setDefault {
    if (self.timeBlock) {
        self.timeBlock([self paramDict:7]);
    }
}

#pragma mark - UITableViewDelegate/Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableView.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = self.tableView.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    UIImage *image = [UIImage imageNamed:@""];
    cell.textLabel.textColor = [UIColor blackColor];
    if (self.tableView.tag == indexPath.row) {
        cell.textLabel.textColor = kGlobalMainColor;
        image = [UIImage imageNamed:@"duihao"];
    }
    cell.accessoryView = [[UIImageView alloc]initWithImage:image];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.mj_h = 50;
    self.overLabel.text = self.tableView.dataArray[indexPath.row];
    self.tableView.hidden = YES;
    self.converView.hidden = YES;
    self.isClickOver = !self.isClickOver;
    if (self.timeBlock) {
        self.tableView.tag = indexPath.row;
        self.timeBlock([self paramDict:((NSNumber *)self.dayArray[indexPath.row]).integerValue]);
    }
    [self.tableView reloadData];
}

#pragma mark - lazy
- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
    }
    return _tableView;
}

- (UIView *)converView {
    if (!_converView) {
        _converView = [[UIView alloc]initWithFrame:CGRectMake(0,FCNavigationHeight + 50 + self.titleArray.count * 44, FCWidth, FCHeight - FCNavigationHeight)];
        _converView.backgroundColor = [UIColor blackColor];
        _converView.alpha = 0.5;
        _converView.hidden = YES;
        _converView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickConver)];
        [_converView addGestureRecognizer:tap];
    }
    return _converView;
}

@end
