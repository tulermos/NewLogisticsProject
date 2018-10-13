//
//  ForgetViewController.m
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "ForgetViewController.h"
#import "TextFieldPartView.h"
#import "NavigationBarView.h"

@interface ForgetViewController ()

@property (nonatomic, strong)NavigationBarView *navigationBar;
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)TextFieldPartView *phoneTextfiled;
@property (nonatomic, strong)TextFieldPartView *codeTextfiled;
@property (nonatomic, strong)TextFieldPartView *pwdTextfiled;
@property (nonatomic, strong)TextFieldPartView *againPwdTextfiled;
@property (nonatomic, strong)UIButton *submitButton;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    @weakify(self);
    self.navigationBar = [[NavigationBarView alloc]initWithTitle:NSLocalizedString(@"Login_nav_fine_pwd", nil) popBlock:^{
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
    self.pwdTextfiled = [[TextFieldPartView alloc]initWithIcon:@"mima" placeholder:NSLocalizedString(@"Login_place_pwd", nil)];
    self.againPwdTextfiled = [[TextFieldPartView alloc]initWithIcon:nil placeholder:NSLocalizedString(@"Login_place_again_pwd", nil)];
    self.submitButton = [UIButton buttonWithFont:19 normalColor:[UIColor whiteColor] selectedColor:nil title:NSLocalizedString(@"Login_btn_submit", nil)];
    [_submitButton addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    _submitButton.layer.cornerRadius = 5;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton setBackgroundColor:kGlobalMainColor];
    
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.backgroundView];
    [_backgroundView addSubview:_phoneTextfiled];
    [_backgroundView addSubview:_codeTextfiled];
    [_backgroundView addSubview:_pwdTextfiled];
    [_backgroundView addSubview:_againPwdTextfiled];
    [_backgroundView addSubview:_submitButton];
    
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
    [_pwdTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeTextfiled.mas_bottom);
        make.leading.trailing.height.mas_equalTo(_codeTextfiled);
    }];
    [_againPwdTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdTextfiled.mas_bottom);
        make.leading.trailing.height.mas_equalTo(_pwdTextfiled);
    }];
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_againPwdTextfiled.mas_bottom).offset(40);
        make.leading.trailing.mas_equalTo(_againPwdTextfiled);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(_backgroundView.mas_bottom).offset(-40);
    }];
}


#pragma mark - Event
//请求code
- (void)requestCode {
    
}
//提交
- (void)clickSubmit:(UIButton *)sender {
    if (![self isValid]) return;
    [FCProgressHUD showLoadingOn:self.view];
    NSDictionary *dict = [NSDictionary requestWithUrl:@"findpwd" param:@{@"phone":_phoneTextfiled.text,@"checkcode":_codeTextfiled.text,@"pwd":_pwdTextfiled.text}];
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
    if (_pwdTextfiled.text.length == 0) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_no_pwd", nil)];
        return NO;
    }
    if (_againPwdTextfiled.text.length == 0) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_no_again_pwd", nil)];
        return NO;
    }
    if (![_pwdTextfiled.text isEqualToString:_againPwdTextfiled.text]) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_pwd_agein_error", nil)];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
