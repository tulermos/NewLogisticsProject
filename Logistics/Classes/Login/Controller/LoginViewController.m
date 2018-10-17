//
//  LoginViewController.m
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "RegisterViewController.h"
#import "TextFieldPartView.h"
#import "NSString+WJ.h"

@interface LoginViewController ()

@property (nonatomic, strong)UIImageView *headerIcon;
@property (nonatomic, strong)TextFieldPartView *userTextField;
@property (nonatomic, strong)TextFieldPartView *pwdTextField;
@property (nonatomic, strong)UIButton *rememberButton;
@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIButton *forgetButton;
@property (nonatomic, strong)UIButton *registerButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getRemeberMessage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerIcon];
    [self.view addSubview:self.userTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.rememberButton];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.registerButton];
    [self setupLayout];
}

- (void)setupLayout {
    CGFloat height = 250.0 / 667.0 * FCHeight;
    [_headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(height);
    }];
    [_userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top
        .mas_equalTo(self.headerIcon.mas_bottom).offset(8);
        make.leading.mas_equalTo(self.view).offset(30);
        make.trailing.mas_equalTo(self.view).offset(-30);
        make.height.mas_equalTo(55);
    }];
    [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userTextField.mas_bottom);
        make.leading
        .trailing.height.mas_equalTo(self.userTextField);
    }];
    [_rememberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top
        .mas_equalTo(self.pwdTextField.mas_bottom).offset(20);
        make.leading.mas_equalTo(self.pwdTextField);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top
        .mas_equalTo(self.rememberButton.mas_bottom).offset(40);
        make.leading.trailing.mas_equalTo(self.pwdTextField);
        make.height.mas_equalTo(50);
    }];
    [_forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top
        .mas_equalTo(self.loginButton.mas_bottom).offset(25);
        make.leading.mas_equalTo(self.loginButton);
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.loginButton);
        make.centerY.mas_equalTo(self.forgetButton);
    }];
}

#pragma mark - event
//登录
- (void)clickLogin:(UIButton *)sender {
    if (![self isValid]) return;
    NSDictionary *dict = @{
       @"pwd":_pwdTextField.text,
       @"username":_userTextField.text,
       };
    NSDictionary *param = [NSDictionary requestWithUrl:@"login" param:dict ];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:param model:@"UserModel" cache:NO success:^(FCBaseResponse *response) {
        NSDictionary *dic = response.json;
        NSLog(@"%@",dic[@"state"]);
        if ([dic[@"state"] isEqualToString:@"success"]) {
            if (self.rememberButton.isSelected) {
                [UserManager rememberLoginMessage:YES message:@{@"user":_userTextField.text,@"pwd":_pwdTextField.text}];
            }else {
                [UserManager rememberLoginMessage:NO message:nil];
            }
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
            UserModel *model =  [UserModel new];
             model.cusName = dict[@"loginInfo"][@"cusRealName"];
             model.cusTel = dict[@"loginInfo"][@"cusTel"];
             model.cusCode = dict[@"loginInfo"][@"userID"];
             model.cusAlias = dict[@"loginInfo"][@"cusAlias"];
             model.uuid = dict[@"uuid"];
             model.other = dict[@"other"];
             model.resCmd = dict[@"resCmd"];
//             model.uuid = dic[@"uuid"];
//             model.uuid = dic[@"uuid"];
//            [[NSUserDefaults standardUserDefaults]setObject:dict[@"loginInfo"] forKey:kUserDefaultKeyUser];
//            [[NSUserDefaults standardUserDefaults]synchronize];
            [UserManager sharedManager].user = model;
//            [UserManager sharedManager].user.cusTel = model.cusTel;
//            [UserManager sharedManager].user.cusCode = model.;
//            [UserManager sharedManager].user.cusName = model.cusRealName;
//            [UserManager sharedManager].user.cusAlias = model.cusRealName;
//            [UserManager sharedManager].user.cusName = model.cusRealName;
            [JPushManager addAlias];
            [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationNameUpdateRootVc object:nil];
            [self rememberPwd];
            
            
        }else{
            NSDictionary *dict = ((NSArray *)response.data).firstObject;
            [FCProgressHUD showText:dict[@"errorMsg"]];
        }
//        if (response.isSuccess) {
//            if (self.rememberButton.isSelected) {
//                [UserManager rememberLoginMessage:YES message:@{@"user":_userTextField.text,@"pwd":_pwdTextField.text}];
//            }else {
//                [UserManager rememberLoginMessage:NO message:nil];
//            }
//            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
//            UserModel *model = [UserModel yy_modelWithJSON:dict];
//            [[NSUserDefaults standardUserDefaults]setObject:dict forKey:kUserDefaultKeyUser];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            [UserManager sharedManager].user = model;
//            [JPushManager addAlias];
//            [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationNameUpdateRootVc object:nil];
//            [self rememberPwd];
//            
//            
//            
//            
//        }else {
//            NSDictionary *dict = ((NSArray *)response.data).firstObject;
//            [FCProgressHUD showText:dict[@"errorMsg"]];
//        }
        
        NSLog(@"%@成功",response);
    } failure:^(FCBaseResponse *response) {
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}
//记住密码
- (void)clickRemember:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
//忘记密码
- (void)clickForget:(UIButton *)sender {
    ForgetViewController *forgetVc = [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:forgetVc animated:YES];
    
}
//注册
- (void)clickRegister:(UIButton *)sender {
    RegisterViewController *registerVc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (void)getRemeberMessage {
    NSDictionary *dict = [UserManager getRememberLoginMessage];
    if (dict) {
        _userTextField.setText = dict[@"user"];
        _pwdTextField.setText = dict[@"pwd"];
        _rememberButton.selected = YES;
    }
}

- (BOOL)isValid {
    if (_userTextField.text.length == 0) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_no_user", nil)];
        return NO;
    }
    if(_pwdTextField.text.length == 0) {
        [FCProgressHUD showText:NSLocalizedString(@"Login_tip_no_pwd", nil)];
        return NO;
    }
    return YES;
}

- (void)rememberPwd {
    if (!self.rememberButton.isSelected) return;
    

}

#pragma mark - lazy
- (UIImageView *)headerIcon {
    if (!_headerIcon) {
        _headerIcon = [[UIImageView alloc]init];
        _headerIcon.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"bg@2x" ofType:@"png"]];
    }
    return _headerIcon;
}

- (TextFieldPartView *)userTextField {
    if (!_userTextField) {
        _userTextField = [[TextFieldPartView alloc]initWithIcon:@"yonghuming" placeholder:NSLocalizedString(@"Login_User", nil)];
    }
    return _userTextField;
}

- (TextFieldPartView *)pwdTextField {
    if (!_pwdTextField) {
        _pwdTextField = [[TextFieldPartView alloc]initWithIcon:@"mima" placeholder:NSLocalizedString(@"Login_Pwd", nil)];
        _pwdTextField.secureTextEntry = YES;
    }
    return _pwdTextField;
}

- (UIButton *)rememberButton {
    if (!_rememberButton) {
        _rememberButton = [UIButton buttonWithNormalImage:@"jizhumima_moren" selectedImage:@"jizhumima_xuanzhong"];
        [_rememberButton setTitle:NSLocalizedString(@"Login_Remember_Pwd", nil) forState:UIControlStateNormal];
        [_rememberButton setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
        _rememberButton.titleLabel.font = [UIFont systemFontOfSize:13];
         [_rememberButton addTarget:self action:@selector(clickRemember:) forControlEvents:UIControlEventTouchUpInside];
        [_rememberButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 14, 0, -14)];
        [_rememberButton sizeToFit];
    }
    return _rememberButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithFont:19 normalColor:[UIColor colorWithHex:0xffffff] selectedColor:nil  title:NSLocalizedString(@"Login_Title", nil)];
        [_loginButton addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setBackgroundColor:kGlobalMainColor];
        _loginButton.layer.cornerRadius = 5;
        _loginButton.layer.masksToBounds = YES;
    }
    return _loginButton;
}
- (UIButton *)forgetButton {
    if (!_forgetButton) {
        NSString *title = [NSString stringWithFormat:@"%@?",NSLocalizedString(@"Login_forget_pwd", nil)];
        _forgetButton = [UIButton buttonWithFont:16 normalColor:[UIColor colorWithHex:0x999999] selectedColor:nil title:title];
        [_forgetButton addTarget:self action:@selector(clickForget:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}
- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithFont:16 normalColor:[UIColor colorWithHex:0x999999] selectedColor:nil title:NSLocalizedString(@"Login_register", nil)];
         [_registerButton addTarget:self action:@selector(clickRegister:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

@end
