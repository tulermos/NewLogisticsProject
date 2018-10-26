//
//  MeaEditViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/27.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "MeaEditViewController.h"
#import "BRDatePickerView.h"
#import "BRTextField.h"
#import "NSDate+BRAdd.h"
@interface MeaEditViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,HSLimitTextDelegate>
@property (nonatomic, strong) UITableView *tableView;
/** 重量 */
@property (nonatomic, strong) HSLimitText *weightTF;
/** 长 */
@property (nonatomic, strong) HSLimitText *lengthTF;
/** 宽 */
@property (nonatomic, strong) HSLimitText *wideTF;
/** 高 */
@property (nonatomic, strong) HSLimitText *highTF;
/** 体积 */
@property (nonatomic, strong) HSLimitText *volumeTF;
/** 密度 */
@property (nonatomic, strong) HSLimitText *densityTF;
/** 封签*/
@property (nonatomic, strong) HSLimitText *sealTF;
/** 备注 */
@property (nonatomic, strong) HSLimitText *noteTF;

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation MeaEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      _titleArr = @[@"重量：", @"长：", @"宽：", @"高：",@"体积：",@"密度：",@"封签：",@"备注："];
    self.view.backgroundColor = kGlobalViewBgColor;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Navigation_Height, FCWidth, FCHeight-Navigation_Height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *footView =[UIView new];
    self.tableView.tableFooterView = footView;
     [self.view addSubview:_tableView];
    
}
- (HSLimitText *)getTextField:(UITableViewCell *)cell {
    HSLimitText *textView = [[HSLimitText alloc] initWithFrame:CGRectMake(FCWidth - 263, 0, 248, 50) type:TextInputTypeTextfield];
    textView.backgroundColor = [UIColor clearColor] ;
    textView.labPlaceHolder.textColor = [UIColor colorWithHexString:@"0x999999"];
    textView.labPlaceHolder.font = [UIFont systemFontOfSize:15];
    textView.textField.textColor = [UIColor blackColor];
    textView.textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    textView.textField.returnKeyType = UIReturnKeySearch;
    textView.delegate = self;
    textView.textField.delegate = self;
    [cell.contentView addSubview:textView];
    return textView;
}

- (void)setupWeightTF:(UITableViewCell *)cell {
    if (!_weightTF) {
        _weightTF = [self getTextField:cell];
        _weightTF.placeholder = @"请输入重量";
        _weightTF.textField.returnKeyType = UIReturnKeyDone;
        _weightTF.tag = 0;
    }
}
- (void)setupLengthTF:(UITableViewCell *)cell {
    if (!_lengthTF) {
        _lengthTF = [self getTextField:cell];
        _lengthTF.placeholder = @"请输入长度";
        _weightTF.textField.returnKeyType = UIReturnKeyDone;
        _lengthTF.tag = 1;
    }
}
- (void)setupWideTF:(UITableViewCell *)cell {
    if (!_wideTF) {
        _wideTF = [self getTextField:cell];
        _wideTF.placeholder = @"请输入宽度";
        _wideTF.textField.returnKeyType = UIReturnKeyDone;
        _wideTF.tag = 2;
    }
}
- (void)setupHighTF:(UITableViewCell *)cell {
    if (!_highTF) {
        _highTF = [self getTextField:cell];
        _highTF.placeholder = @"请输入高度";
        _highTF.textField.returnKeyType = UIReturnKeyDone;
        _highTF.tag = 3;
    }
}

- (void)setupVolumeTF:(UITableViewCell *)cell {
    if (!_volumeTF) {
        _volumeTF = [self getTextField:cell];
        _volumeTF.placeholder = @"请输入体积";
        _volumeTF.textField.returnKeyType = UIReturnKeyDone;
        _volumeTF.tag = 4;
    }
}
- (void)setupdensityTF:(UITableViewCell *)cell {
    if (!_densityTF) {
        _densityTF = [self getTextField:cell];
        _densityTF.placeholder = @"请输入密度";
        _densityTF.textField.returnKeyType = UIReturnKeyDone;
        _densityTF.tag = 5;
    }
}
- (void)setupSealTF:(UITableViewCell *)cell {
    if (!_sealTF) {
        _sealTF = [self getTextField:cell];
        _sealTF.placeholder = @"请输入封签";
        _sealTF.textField.returnKeyType = UIReturnKeyDone;
        _sealTF.tag = 6;
    }
}
- (void)setupNoteTF:(UITableViewCell *)cell {
    if (!_noteTF) {
        _noteTF = [self getTextField:cell];
        _noteTF.frame =CGRectMake(FCWidth - 263, 0, 248, 100);
        [cell.contentView addSubview:_noteTF];
        _noteTF.placeholder = @"请输入备注";
        _noteTF.textField.returnKeyType = UIReturnKeyDone;
        _noteTF.tag = 7;
    }
}
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
           
            [self setupWeightTF:cell];
        }
            break;
        case 1:
        {
           
            [self setupLengthTF:cell];
        }
            break;
        case 2:
        {
           
            [self setupWideTF:cell];
        }
            break;
        case 3:
        {
            [self setupHighTF:cell];
        }
            break;
        case 4:
        {
           
           [self setupVolumeTF:cell];
        }
            break;
        case 5:
        {
           
            [self setupdensityTF:cell];
        }
            break;
    
        case 6:
        {
           
            [self setupSealTF:cell];
        }
            break;
        case 7:
        {
           
            [self setupNoteTF:cell];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7) {
        return 100;
    }else{
    return 50;
    }
}
@end
