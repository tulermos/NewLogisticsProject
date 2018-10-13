//
//  AddressBookAlertView.m
//  Logistics
//
//  Created by meng wang on 2018/4/25.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "AddressBookAlertView.h"
#import "AddressBookAlertCell.h"

@interface AddressBookAlertView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIButton *sureButton;
@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *arraySource;
@property (nonatomic, copy)Int_Block completionBlock;
@property (nonatomic, strong)NSArray *titleArray;

@end

@implementation AddressBookAlertView

+ (instancetype)alertViewWithArray:(NSArray *)array sure:(NSString *)sureStr cancel:(NSString *)cancelStr completionBlock:(Int_Block)block {
    AddressBookAlertView  *alertView = [[AddressBookAlertView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    alertView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    [alertView.sureButton setTitle:sureStr forState:UIControlStateNormal];
    [alertView.cancelButton setTitle:cancelStr forState:UIControlStateNormal];
    alertView.arraySource = array;
    alertView.completionBlock = block;
    [alertView updateHeight];
    return alertView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleArray = @[@"公司名称:",@"公司地址:",@"联系人:",@"Email:",@"Phone:"];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.sureButton];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(15);
        make.trailing.mas_equalTo(self).offset(-15);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentView).offset(15);
        make.leading.trailing.mas_equalTo(_contentView);
        make.height.mas_equalTo(250);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tableView.mas_bottom).offset(20);
        make.leading.mas_equalTo(_tableView);
        make.trailing.mas_equalTo(_sureButton.mas_leading);
        make.height.mas_equalTo(40);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_cancelButton);
        make.trailing.mas_equalTo(_tableView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(_cancelButton);
        make.bottom.mas_equalTo(_contentView);
    }];
}

- (void)updateHeight {
    NSInteger index = 0;
    NSInteger height = 0;
    for (NSString *detail in self.arraySource) {
        height += [AddressBookAlertCell heightForCell:self.titleArray[index] detail:detail];
        index++;
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}
- (void)clickEvent:(UIButton *)sender {
    [self hide];
    if (self.completionBlock) {
        self.completionBlock(sender.tag);
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hide {
    [self removeFromSuperview];
}

#pragma mark - UITableViewDelegate/Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[AddressBookAlertCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setTitle:_titleArray[indexPath.row] detail:self.arraySource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AddressBookAlertCell heightForCell:_titleArray[indexPath.row] detail:self.arraySource[indexPath.row]];
}

#pragma mark - lazy
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [[UIButton alloc]init];
        [_sureButton setTitleColor:kGlobalMainColor forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _sureButton.tag = 1;
    }
    return _sureButton;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancelButton.tag = 0;
    }
    return _cancelButton;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor whiteColor];
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}

@end
