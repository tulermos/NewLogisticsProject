//
//  QuerySearchBar.m
//  Logistics
//
//  Created by meng wang on 2018/7/8.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "QuerySearchBar.h"

@interface QuerySearchBar()<UISearchBarDelegate,UITextFieldDelegate>

@property (nonatomic, strong)UIButton *chooseButton;
@property (nonatomic, strong)UIButton *kuanhaoBtn;

@end

@implementation QuerySearchBar

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
    [self addSubview:self.kuanhaoBtn];
    [self.textField becomeFirstResponder];
    
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
        make.trailing.mas_equalTo(self.kuanhaoBtn.mas_leading).mas_offset(-10);
        make.width.mas_equalTo(40);
    }];
    [self.kuanhaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_textField);
        make.trailing.mas_equalTo(self).offset(-15);
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
    if (self.clickDanjuBlock) {
        self.clickDanjuBlock();
    }
}

- (void)clickKuanhao {
    if (self.clickKuanhaoBlock) {
        self.clickKuanhaoBlock();
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
        [_chooseButton setTitle:NSLocalizedString(@"Help_danju", nil) forState:UIControlStateNormal];
        [_chooseButton sizeToFit];
        [_chooseButton addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}

- (UIButton *)kuanhaoBtn {
    if (!_kuanhaoBtn) {
        _kuanhaoBtn = [[UIButton alloc]init];
        [_kuanhaoBtn setTitleColor:kGlobalMainColor forState:UIControlStateNormal];
        _kuanhaoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_kuanhaoBtn setTitle:NSLocalizedString(@"Help_kuanhao", nil) forState:UIControlStateNormal];
        [_kuanhaoBtn sizeToFit];
        [_kuanhaoBtn addTarget:self action:@selector(clickKuanhao) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kuanhaoBtn;
}

@end
