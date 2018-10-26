//
//  shippingQueryViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/26.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "shippingQueryViewController.h"
#import "BRDatePickerView.h"
#import "BRTextField.h"
#import "NSDate+BRAdd.h"
#import "siteModel.h"
#import "ReceivingRegistrationModel.h"
#import "ConsignmentNoteCell.h"
#import "ConsignmentNoteModel.h"
#import "WaybillTableViewCell.h"
#import "WaybillModel.h"
#import "WaybillDetailViewController.h"
#import "WaybillQueryHeaderView.h"
#import "ReceivingRegistrationModel.h"
#import "WaybillQueryFooterView.h"

@interface shippingQueryViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
/** 发货人姓名 */
@property (nonatomic, strong) BRTextField *deliveryNameTF;
/** 收件人姓名 */
@property (nonatomic, strong) BRTextField *goodsTimeTF;
/** 结束时间 */
@property (nonatomic, strong) BRTextField *finishTimeTF;
/** 目的城市 */
@property (nonatomic, strong) BRTextField *cityTF;
/** 开始时间 */
@property (nonatomic, strong) BRTextField *startTimeTF;


@property (nonatomic,  copy) NSString *startTimeStr;

@property (nonatomic, strong) NSArray *titleArr;



@property (nonatomic, strong) NSMutableArray *dataArr;


@end

@implementation shippingQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"高级查询";

    _dataArr = [NSMutableArray array];
    _titleArr = @[@"开始时间：", @"结束时间：", @"目的城市：", @"发货人姓名：",@"收货人姓名："];
    self.view.backgroundColor = kGlobalViewBgColor;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Navigation_Height, FCWidth, FCHeight-Navigation_Height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FCWidth, 115)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *resetbtn= [UIButton buttonWithType:0];
    resetbtn.backgroundColor = [UIColor colorWithRed:86/255.0 green:124/255.0 blue:212/255.0 alpha:1/1.0];
    ;
    resetbtn.frame = CGRectMake(FCWidth-235,40,95, 35);
    [resetbtn setTitle:@"重置" forState:0];
    [resetbtn setTitleColor:[UIColor whiteColor] forState:0];
    resetbtn.layer.cornerRadius = resetbtn.height/2;
    resetbtn.layer.masksToBounds = YES;
    [resetbtn addTarget:self action:@selector(resetbtnAction:) forControlEvents:1<<6];
    [view addSubview:resetbtn];
    
    UIButton *confirmBtn= [UIButton buttonWithType:0];
    confirmBtn.backgroundColor = [UIColor colorWithRed:86/255.0 green:124/255.0 blue:212/255.0 alpha:1/1.0];
    confirmBtn.frame = CGRectMake(FCWidth-115,40,95, 35);
    [confirmBtn setTitle:@"确定" forState:0];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:0];
    confirmBtn.layer.cornerRadius = resetbtn.height/2;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:1<<6];
    [view addSubview:confirmBtn];
    _tableView.tableFooterView = view;
    [self.view addSubview:_tableView];

}
- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(FCWidth - 230, 0, 200, 50)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f];
    textField.textAlignment = NSTextAlignmentRight;
    textField.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];;
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}
#pragma mark - 货号 textField
- (void)setupDeliveryNameTF:(UITableViewCell *)cell {
    if (!_deliveryNameTF) {
        _deliveryNameTF = [self getTextField:cell];
        _deliveryNameTF.placeholder = @"请输入发货人姓名";
        _deliveryNameTF.returnKeyType = UIReturnKeyDone;
        _deliveryNameTF.tag = 0;
    }
}

#pragma mark - 货号 textField
- (void)setupGoodsTimeTF:(UITableViewCell *)cell {
    if (!_goodsTimeTF) {
        _goodsTimeTF = [self getTextField:cell];
        _goodsTimeTF.placeholder = @"请输入收货人姓名";
        _goodsTimeTF.returnKeyType = UIReturnKeyDone;
        _goodsTimeTF.tag = 0;
    }
}


#pragma mark - 开始时间 textField
- (void)setupStartTimeTF:(UITableViewCell *)cell {
    if (!_startTimeTF) {
        _startTimeTF = [self getTextField:cell];
        _startTimeTF.placeholder = @"请选择开始时间";
        __weak typeof(self) weakSelf = self;
        _startTimeTF.tapAcitonBlock = ^{
            [BRDatePickerView showDatePickerWithTitle:@"请选择开始时间" dateType:BRDatePickerModeDateAndTime defaultSelValue:weakSelf.startTimeTF.text minDate:[NSDate date] maxDate:nil isAutoSelect:YES themeColor:kGlobalMainColor resultBlock:^(NSString *selectValue) {
                weakSelf.startTimeTF.text = selectValue;
                weakSelf.startTimeStr = selectValue;
            }];
        };
    }
}
#pragma mark - 结束 textField
- (void)setupFinishTimeTF:(UITableViewCell *)cell {
    if (!_finishTimeTF) {
        _finishTimeTF = [self getTextField:cell];
        _finishTimeTF.placeholder = @"请选择结束时间";
        __weak typeof(self) weakSelf = self;
        _finishTimeTF.tapAcitonBlock = ^{
            [BRDatePickerView showDatePickerWithTitle:@"请选择结束时间" dateType:BRDatePickerModeDateAndTime defaultSelValue:nil minDate:[weakSelf dateFromString: weakSelf.startTimeStr] maxDate:nil isAutoSelect:YES themeColor:kGlobalMainColor resultBlock:^(NSString *selectValue) {
                weakSelf.finishTimeTF.text = selectValue;
                //                weakSelf.finishTimeTF = selectValue;
            }];
        };
    }
}
#pragma mark - 城市 textField
- (void)setupCityTF:(UITableViewCell *)cell {
    if (!_cityTF) {
        _cityTF = [self getTextField:cell];
        _cityTF.placeholder = @"请选择城市";
        __weak typeof(self) weakSelf = self;
        _cityTF.tapAcitonBlock = ^{
            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES themeColor:kGlobalMainColor resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                weakSelf.cityTF.text = [NSString stringWithFormat:@"%@",city.name];
            }];
        };
        
    }
}
//NSString转NSDate
-(NSDate *)dateFromString:(NSString *)string
{
    //    //需要转换的字符串
    //    NSString *dateString = @"2015-06-26 08:08:08";
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:string];
    return date;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"testCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.textColor =[UIColor blackColor];
    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupStartTimeTF:cell];
        }
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupFinishTimeTF:cell];
        }
            break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupCityTF:cell];
        }
            break;
        case 3:
        {
           [self setupDeliveryNameTF:cell];
        }
            break;
        case 4:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupGoodsTimeTF:cell];
        }
            break;
       
        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
////确定
//-(void)confirmBtnAction:(UIButton *)btn
//{
//    if ([NSString isBlankString:_numberTF.text]) {
//        _numberTF.text = @"";
//    }else{
//        _numberTF.text = _numberTF.text;
//    }
//
//    if ([NSString isBlankString:_startTimeTF.text]) {
//        _startTimeTF.text = @"2018-10-19";
//    }else{
//        _startTimeTF.text = _startTimeTF.text;
//    }
//    if ([NSString isBlankString:_finishTimeTF.text]) {
//        _finishTimeTF.text = @"2018-10-26";
//    }else{
//        _finishTimeTF.text = _finishTimeTF.text;
//    }
//    if ([NSString isBlankString:_startSiteTF.text]) {
//        _startSiteTF.text = @"";
//    }else{
//        _startSiteTF.text = _startSiteTF.text;
//    }
//    if ([NSString isBlankString:_warehouseTF.text]) {
//        _warehouseTF.text = @"";
//    }else{
//        _warehouseTF.text =_warehouseTF.text;
//    }
//
//
//    [FCProgressHUD showLoadingOn:self.view];
//    NSDictionary *param = [NSDictionary requestWithUrl:@"GetEntDataList" param:@{@"userID":[UserManager sharedManager].user.cusCode,@"EntNumber":_numberTF.text,@"pageindex":@(1),@"pagesize":@(15),@"StartTime":_startTimeTF.text,@"EndTime":_finishTimeTF.text,@"StockID":_warehouseTF.text,@"EntStartID":@"",@"EntEndID":@""}];
//    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:nil cache:NO success:^(FCBaseResponse *response) {
//        [FCProgressHUD hideHUDForView:self.view animation:YES];
//        NSDictionary *dic = response.json;
//        NSLog(@"%@",dic[@"state"]);
//        if ([dic[@"state"] isEqualToString:@"success"]) {
//            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
//            [_dataArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[ReceivingRegistrationModel class] json:dict[@"entinfo"]]];
//            if (self.returnData != nil) {
//                self.returnData(_dataArr);//视图将要消失时候调用
//            }
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            NSDictionary *dict = ((NSArray *)response.data).firstObject;
//            [FCProgressHUD showText:dict[@"errorMsg"]];
//        }
//    } failure:^(FCBaseResponse *response) {
//        NSDictionary *dict = ((NSArray *)response.data).firstObject;
//        [FCProgressHUD showText:dict[@"errorMsg"]];
//    }];
//
//}

-(void)returnData:(ReturnData)block
{
    _returnData = block;
}
////重置
//-(void)resetbtnAction:(UIButton *)btn
//{
//    _numberTF.text = @"";
//    _startTimeTF.text = @"";
//    _finishTimeTF.text = @"";
//    _startSiteTF.text = @"";
//    _cityTF.text = @"";
//    _warehouseTF.text = @"";
//    [_tableView reloadData];
//}

@end
