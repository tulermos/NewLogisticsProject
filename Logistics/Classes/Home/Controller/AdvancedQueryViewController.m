//
//  AdvancedQueryViewController.m
//  Logistics
//
//  Created by tulemos on 2018/10/15.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import "AdvancedQueryViewController.h"
#import "pickerCell.h"
#import "CGXPickerView.h"
#define kpickerCell @"kpickerCell"
@interface AdvancedQueryViewController ()

@end

@implementation AdvancedQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"高级查询";
    [self.tableView registerClass:[pickerCell class] forCellReuseIdentifier:kpickerCell];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_type == 1) {
        return 3;
    }else{
    return 5;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FCWidth, 115)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *resetbtn= [UIButton buttonWithType:0];
    resetbtn.backgroundColor = [UIColor colorWithHexString:@"0xE6EDFB"];
    resetbtn.frame = CGRectMake(140,40,95, 35);
    [resetbtn setTitle:@"重置" forState:0];
    [resetbtn setTitleColor:[UIColor colorWithHexString:@"0x567CD4"] forState:0];
    resetbtn.layer.cornerRadius = resetbtn.height/2;
    resetbtn.layer.masksToBounds = YES;
    [resetbtn addTarget:self action:@selector(resetbtnAction:) forControlEvents:1<<6];
    [view addSubview:resetbtn];
    
    UIButton *confirmBtn= [UIButton buttonWithType:0];
    confirmBtn.backgroundColor = [UIColor colorWithHexString:@"0xE6EDFB"];
    confirmBtn.frame = CGRectMake(140,40,95, 35);
    [confirmBtn setTitle:@"确定" forState:0];
    [confirmBtn setTitleColor:[UIColor colorWithHexString:@"0x567CD4"] forState:0];
    confirmBtn.layer.cornerRadius = resetbtn.height/2;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:1<<6];
    [view addSubview:confirmBtn];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    pickerCell *cell = [tableView dequeueReusableCellWithIdentifier:kpickerCell forIndexPath:indexPath];
    cell.selectionStyle = 0;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    pickerCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowStr = [fmt stringFromDate:now];
    CGXPickerViewManager *manager = [[CGXPickerViewManager alloc]init];
    manager.titleLabelColor = kGlobalMainColor;
    manager.rightBtnBGColor =kGlobalMainColor;
    manager.leftBtnBGColor =kGlobalMainColor;
    if (indexPath.row == 0) {
        
        [CGXPickerView showDatePickerWithTitle:@"请选择开始时间" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:YES Manager:manager ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            cell.subTitleLab.text =selectValue;
        }];
    }else if (indexPath.row == 1)
    {
        [CGXPickerView showDatePickerWithTitle:@"请选择开始时间" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:@"2100-01-01 00:00:00" IsAutoSelect:YES Manager:manager ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            cell.subTitleLab.text =selectValue;
        }];
    }else if (indexPath.row == 2){
        [CGXPickerView showAddressPickerWithTitle:@"请选择目的城市" DefaultSelected:@[@0,@0] IsAutoSelect:YES Manager:manager ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
            NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
            cell.subTitleLab.text =  [NSString stringWithFormat:@"%@%@", selectAddressArr[0], selectAddressArr[1]];
        }];
    }else
    {
        
    }
}
//确定
-(void)confirmBtnAction:(UIButton *)btn
{
    
}
//重置
-(void)resetbtnAction:(UIButton *)btn
{
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
