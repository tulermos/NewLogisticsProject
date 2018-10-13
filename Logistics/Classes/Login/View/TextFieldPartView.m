//
//  TextFieldPartView.m
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "TextFieldPartView.h"

@interface TextFieldPartView()

@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIButton *rightButton;
@property (nonatomic, copy)Id_Block rightBlock;
@property (nonatomic, assign)kRightButtonType type;
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation TextFieldPartView{
    int time;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithIcon:(NSString *)iconName placeholder:(NSString *)placeholder {
    TextFieldPartView *partView = [[TextFieldPartView alloc]init];
    partView.icon.image = [UIImage imageNamed:iconName];
    partView.textField.placeholder = placeholder;
    return partView;
}

- (void)addRightButtonWithType:(kRightButtonType)type clickblock:(Id_Block)block {
    self.rightButton.hidden = NO;
    self.type = type;
    self.rightBlock = block;
    
}

- (void)setupUI {
    [self addSubview:self.textField];
    [self addSubview:self.icon];
    [self addSubview:self.lineView];
    [self addSubview:self.rightButton];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-5);
        make.leading.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.textField  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading
        .mas_equalTo(_icon.mas_trailing).offset(15);
        make.bottom.mas_equalTo(self).offset(-5);
        make.trailing.mas_equalTo(self).offset(-15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
        make.leading.mas_equalTo(_textField);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_textField).offset(-5);
        make.trailing.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
}

- (void)clickRight:(UIButton *)sender {
    
    //获取验证码
    if (self.type == kRightButtonTypeCoder) {
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(addTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
        self->time = 60;
    }
    if (self.rightBlock) {
        self.rightBlock(sender);
    }
}

- (void)addTimer:(NSTimer *)timer {
    NSString *title = [NSString stringWithFormat:@"%ds",self->time];
    [_rightButton setTitle:title forState:UIControlStateNormal];
    if (_rightButton.state != UIControlStateDisabled && self->time > 0) {
        _rightButton.enabled = NO;
        [_rightButton setBackgroundColor:[UIColor colorWithHex:0xcccccc]];
        [_rightButton setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateDisabled];
    }
    
    if (_rightButton.state == UIControlStateDisabled && self->time <= 0) {
        [_rightButton setBackgroundColor:kGlobalMainColor];
        _rightButton.enabled = YES;
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton setTitle:NSLocalizedString(@"Login_btn_get_code", nil) forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
    }
    self->time --;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    self.textField.secureTextEntry = secureTextEntry;
}

- (NSString *)text {
    return [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (void)setSetText:(NSString *)setText {
    _setText = setText;
    self.textField.text = setText;
}
#pragma mark - lazy
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:16];
    }
    return _textField;
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHex:0xe1e1e1];
    }
    return _lineView;
}
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithFont:12 normalColor:[UIColor whiteColor] selectedColor:nil title:NSLocalizedString(@"Login_btn_get_code", nil)];
        [_rightButton setBackgroundColor:kGlobalMainColor];
        _rightButton.layer.cornerRadius = 2.5;
        _rightButton.layer.masksToBounds = YES;
        _rightButton.hidden = YES;
        [_rightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
@end
