

#import "WLCargoTrackViewController.h"

#import "ZFScanViewController.h"

#import "WLCargoTrackQueryResultCell.h"
#import "WLCargoTrackInputQueryCell.h"
#import "WLCargoTrackRowsCell.h"

#import "WLCargoTrackModel.h"

@interface WLCargoTrackViewController ()<WLCargoTrackInputQueryCellDelegate>

@property (nonatomic, strong) NSMutableArray *tableviewDatas;

@property (nonatomic, copy) NSString *qrString;

@end

@implementation WLCargoTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableviewDatas = [[NSMutableArray alloc] init];
    [self.tableviewDatas addObject:@"0"];
    [self.tableviewDatas addObject:@"1"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton *rightBarBtn0 = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBarBtn0.frame = CGRectMake(0, 0, 5, 44);
    [rightBarBtn0 addTarget:self action:@selector(refreshRequest) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBarBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(refreshRequest) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem0 = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn0];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItems = @[rightItem0,rightItem];
    
    self.navigationItem.title = @"货物跟踪";
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            WLCargoTrackInputQueryCell *cell = [WLCargoTrackInputQueryCell cellWithReuseIdentifier:nil];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            WLCargoTrackQueryResultCell *cell = [WLCargoTrackQueryResultCell cellWithCellStyle:CellStyle_Default WithModel:self.tableviewDatas[indexPath.section] ReuseIdentifier:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            WLCargoTrackQueryResultCell *cell = [WLCargoTrackQueryResultCell cellWithCellStyle:CellStyle_Result WithModel:self.tableviewDatas[indexPath.section] ReuseIdentifier:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
        {
            WLCargoTrackRowsCell *cell = [WLCargoTrackRowsCell cellWithModel:self.tableviewDatas[indexPath.section][indexPath.row] ReuseIdentifier:@"WLCargoTrackRowsCell"];
            if (indexPath.row != 0) {
                cell.lineImgView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1];
                cell.cornerImgView2.image = [UIImage imageNamed:@"地址灰色.png"];
            }else {
                cell.cornerImgView2.image = [UIImage imageNamed:@"地址.png"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, [UIScreen mainScreen].bounds.size.width, 0, 0);
            return cell;
        }
            break;
    }
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return ((NSArray *)([self.tableviewDatas objectAtIndex:section])).count;
    }else {
        return 1;
    }
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableviewDatas.count;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self wlQRAction];
    }
}

- (void) wlQRAction {
    ZFScanViewController * vc = [[ZFScanViewController alloc] init];
    vc.returnScanBarCodeValue = ^(NSString * barCodeString){
        NSLog(@"barCodeString = %@",barCodeString);
        self.qrString = barCodeString;
        [self wlQueryOrder:barCodeString];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) wlQueryOrder:(NSString *)order {
    WLCargoTrackModel *model = [[WLCargoTrackModel alloc] init];
    [WLCargoTrackModel requestQueryOrderWithModel:model
                                    SuccessHandle:^(id  _Nonnull responseObject) {
                                        
        if ([[responseObject valueForKey:@"state"] isEqualToString:@"success"]) {
            [self.tableviewDatas removeAllObjects];
            [self.tableviewDatas addObject:@"0"];
            [self.tableviewDatas addObject:@"1"];
            NSDictionary *dataDict = ((NSArray *)responseObject[@"data"]).firstObject;
            NSDictionary *trackInfoDict = dataDict[@"trackinfo"];
            [self.tableviewDatas addObject:trackInfoDict];
            
            NSArray *recordEntityArr = trackInfoDict[@"recordEntity"];
            if (recordEntityArr) {
                [self.tableviewDatas addObject:recordEntityArr];
            }
            [self wlRefreshQueryCell];
        }else {
            [self.tableviewDatas removeAllObjects];
            [self.tableviewDatas addObject:@"0"];
            [self.tableviewDatas addObject:@"1"];
            NSLog(@"请求数据有误,展示报错!");
        }
        [self wlRefreshQueryCell];
    } Fail:^(NSError * _Nonnull error) {
        [self requestFail];
    }];
}

- (void) wlRefreshQueryCell {
    [self.tableView reloadData];
}

- (void) WLCargoTrackInputQueryCellDelegateModel:(NSDictionary *)responseObject {

    WLCargoTrackModel *model = [[WLCargoTrackModel alloc] init];
    model.orderStr = [responseObject valueForKey:@"orderStr"];
    [WLCargoTrackModel requestQueryOrderWithModel:model SuccessHandle:^(id  _Nonnull responseObject) {
        
        if ([[responseObject valueForKey:@"state"] isEqualToString:@"success"]) {
            [self.tableviewDatas removeAllObjects];
            [self.tableviewDatas addObject:@"0"];
            [self.tableviewDatas addObject:@"1"];
            NSDictionary *dataDict = ((NSArray *)responseObject[@"data"]).firstObject;
            NSDictionary *trackInfoDict = dataDict[@"trackinfo"];
            [self.tableviewDatas addObject:trackInfoDict];
            
            NSArray *recordEntityArr = trackInfoDict[@"recordEntity"];
            if (recordEntityArr) {
                [self.tableviewDatas addObject:recordEntityArr];
            }
            [self wlRefreshQueryCell];
        }else {
            [self.tableviewDatas removeAllObjects];
            [self.tableviewDatas addObject:@"0"];
            [self.tableviewDatas addObject:@"1"];
            NSLog(@"请求数据有误,展示报错!");
        }
        [self wlRefreshQueryCell];
    } Fail:^(NSError * _Nonnull error) {
        [self requestFail];
    }];
}

- (void) refreshRequest {
    [self wlQueryOrder:self.qrString];
}

- (void) requestFail {
    NSLog(@"访问失败!");
}

- (UIView *) errorFooterView {
    UIView *view = [[UIView alloc] init];
    UILabel *lab = [[UILabel alloc] init];
    return view;
}

@end
