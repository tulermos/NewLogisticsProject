//
//  FCGoodsSearchBar.m
//  风车医生
//
//  Created by meng wang on 2017/8/24.
//  Copyright © 2017年 FC. All rights reserved.
//

#import "WaybillSearchBar.h"
#import "IQUIView+IQKeyboardToolbar.h"

@interface WaybillSearchBar ()<UISearchBarDelegate,UITextFieldDelegate>

@property (nonatomic, strong)UIButton *chooseButton;

@end

@implementation WaybillSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithHex:0xEFEFEF];
    [self addSubview:self.textField];
    [self addSubview:self.chooseButton];
    [self.textField becomeFirstResponder];
    [self.textField addDoneOnKeyboardWithTarget:self action:@selector(startSearch)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(15);
        make.top.mas_equalTo(self).mas_offset(10);
        make.bottom.mas_equalTo(self).mas_offset(-10);
        make.trailing
        .mas_equalTo(self.chooseButton.mas_leading).mas_offset(-10);
    }];
    
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_textField);
        make.trailing.mas_equalTo(self).mas_offset(-15);
        make.width.mas_equalTo(40);
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kGlobalLineColor;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldChange:(NSNotification *)notify {
    if (self.textField == notify.object) {
        if (self.changeBlock) {
            self.changeBlock(self.searchStr);
        }
    }
}

#pragma mark - AddAction
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self startSearch];
    return YES;
}

- (void)startSearch {
    [self endEditing:YES];
    self.searchStr = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (self.filtBlock) {
        self.filtBlock(self.searchStr);
    }
}

- (void)clickCancel {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (NSString *)searchStr {
    return [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (void)setMargin_top:(CGFloat)margin_top {
    _margin_top = margin_top;
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(margin_top);
    }];
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    _buttonTitle = buttonTitle;
    [_chooseButton setTitle:buttonTitle forState:UIControlStateNormal];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 懒加载

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"请输入运单单号";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.borderWidth = 0.5;
        _textField.layer.borderColor = kGlobalLineColor.CGColor;
        _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIButton *)chooseButton {
    if (!_chooseButton) {
        _chooseButton = [[UIButton alloc]init];
        [_chooseButton setTitleColor:kGlobalMainColor forState:UIControlStateNormal];
        _chooseButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_chooseButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_chooseButton sizeToFit];
        [_chooseButton addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}

@end
