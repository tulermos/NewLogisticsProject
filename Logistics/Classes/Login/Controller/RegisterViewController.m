//
//  RegisterViewController.m
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "RegisterViewController.h"
#import "TextFieldPartView.h"
#import "NavigationBarView.h"

@interface RegisterViewController ()

@property (nonatomic, strong)NavigationBarView *navigationBar;
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)TextFieldPartView *phoneTextfiled;
@property (nonatomic, strong)TextFieldPartView *codeTextfiled;
@property (nonatomic, strong)TextFieldPartView *contactTextfiled;
@property (nonatomic, strong)TextFieldPartView *companyTextfiled;
@property (nonatomic, strong)UILabel *labelTipAccount;
@property (nonatomic, strong)UIButton *submitButton;
@property (nonatomic, strong)UIButton *loginButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    @weakify(self);
    self.navigationBar = [[NavigationBarView alloc]initWithTitle:NSLocalizedString(@"Nav_Login_register", nil) popBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.view.backgroundColor = [UIColor colorWithHex:0xf3f5f7];
    self.backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    self.phoneTextfiled = [[TextFieldPartView alloc]initWithIcon:@"shoujihao" placeholder:NSLocalizedString(@"Login_place_phone", nil)];
    self.codeTextfiled = [[TextFieldPartView alloc]initWithIcon:@"yanzhengma" placeholder:NSLocalizedString(@"Login_place_code", nil)];
    [_codeTextfiled addRightButtonWithType:kRightButtonTypeCoder clickblock:^(id obj) {
        @strongify(self);
        [self requestCode];
    }];
    self.contactTextfiled = [[TextFieldPartView alloc]initWithIcon:@"lianxiren" placeholder:NSLocalizedString(@"Login_place_contact", nil)];
    self.companyTextfiled = [[TextFieldPartView alloc]initWithIcon:@"gongsimingcheng" placeholder:NSLocalizedString(@"Login_place_company", nil)];
    self.submitButton = [UIButton buttonWithFont:19 normalColor:[UIColor whiteColor] selectedColor:nil title:NSLocalizedString(@"Login_btn_register", nil)];
    [_submitButton addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    _submitButton.layer.cornerRadius = 5;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton setBackgroundColor:kGlobalMainColor];
    self.labelTipAccount = [UILabel labelWithFont:16 textColor:[UIColor colorWithHex:0x999999] text:NSLocalizedString(@"Login_count_had", nil)];
    self.loginButton = [UIButton buttonWithFont:16 normalColor:kGlobalMainColor selectedColor:nil title:NSLocalizedString(@"Login_title_had_account", nil)];
    [_loginButton addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.backgroundView];
    [_backgroundView addSubview:_phoneTextfiled];
    [_backgroundView addSubview:_codeTextfiled];
    [_backgroundView addSubview:_contactTextfiled];
    [_backgroundView addSubview:_companyTextfiled];
    [_backgroundView addSubview:_labelTipAccount];
    [_backgroundView addSubview:_submitButton];
    [_backgroundView addSubview:_loginButton];
    
    [self setupLayout];
}

- (void)setupLayout {
    [_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_navigationBar.mas_bottom);
        make.leading.trailing.mas_equalTo(self.view);
    }];
    [_phoneTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backgroundView).offset(15);
        make.leading.mas_equalTo(self.view).offset(30);
        make.trailing.mas_equalTo(self.view).offset(-30);
        make.height.mas_equalTo(55);
    }];
    [_codeTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneTextfiled.mas_bottom);
        make.leading.trailing.height.mas_equalTo(_phoneTextfiled);
    }];
    [_contactTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeTextfiled.mas_bottom);
        make.leading.trailing.height.mas_equalTo(_codeTextfiled);
    }];
    [_companyTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contactTextfiled.mas_bottom);
        make.leading.trailing.height.mas_equalTo(_contactTextfiled);
    }];
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_companyTextfiled.mas_bottom).offset(40);
        make.leading.trailing.mas_equalTo(_companyTextfiled);
        make.height.mas_equalTo(50);
    }];
    [self.labelTipAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_submitButton.mas_bottom).offset(30);
        make.trailing.mas_equalTo(_backgroundView).offset(-(FCWidth * 0.5));
        make.bottom.mas_equalTo(_backgroundView).offset(-40);
        make.height.mas_equalTo(20);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(_labelTipAccount);
        make.leading.mas_equalTo(_labelTipAccount.mas_trailing);
    }];
}

#pragma mark - Event
//请求code
- (void)requestCode {
    NSDictionary *dict = [NSDictionary requestWithUrl:@"" param:@{}];
    [FCHttpRequest FCNetWork:HttpRequestMethodPost url:nil model:nil cache:NO param:dict success:^(FCBaseResponse *response) {
    } failure:^(FCBaseResponse *response) {
    }];
}
- (void)clickLogin:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//提交
- (void)clickSubmit:(UIButton *)sender {
    if (![self isValid]) return;
    [FCProgressHUD showLoadingOn:self.view];
    NSDictionary *dict = [NSDictionary requestWithUrl:@"regedit" param:@{@"phone":_phoneTextfiled.text,@"chkcode":_codeTextfiled.text}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:dict model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        if (response.isSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [FCProgressHUD showText:response.json[@"error"][@"errMsg"]];
        }
    } failure:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        [FCProgressHUD showText:response.json[@"error"][@"errMsg"]];
    }];
}

- (BOOL)isValid {
    if (_phoneTextfiled.text.length == 0) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_no_phone", nil)];
        return NO;
    }
    if (![NSString isVaildPhoneNumber:_phoneTextfiled.text]) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_phone_error", nil)];
        return NO;
    }
    if (_codeTextfiled.text.length == 0) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_no_code", nil)];
        return NO;
    }
    if (_contactTextfiled.text.length == 0) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_no_pwd", nil)];
        return NO;
    }
    if (_companyTextfiled.text.length == 0) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_no_again_pwd", nil)];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
