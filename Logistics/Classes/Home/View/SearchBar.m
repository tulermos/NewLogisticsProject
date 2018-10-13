//
//  SearchBar.m
//  Logistics
//
//  Created by meng wang on 2018/4/24.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "SearchBar.h"

@interface SearchBar()

@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UITextField *textField;

@end

@implementation SearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification
        object:_textField];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.leading.mas_equalTo(self).offset(15);
        make.trailing.mas_equalTo(self).offset(-15);
        make.bottom.mas_equalTo(self).offset(-10);
    }];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(_contentView).offset(10);
        make.centerY.mas_equalTo(_contentView);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_icon);
        make.leading.mas_equalTo(_icon.mas_trailing).offset(10);
        make.trailing.mas_equalTo(_contentView).offset(-10);
    }];
}

- (void)textFieldDidChangeValue:(NSNotification *)notify {
    if (self.didChangeBlock) {
        self.didChangeBlock([self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]);
    }
}

#pragma mark - lazy
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.placeholder = NSLocalizedString(@"Home_place_search", nil);
        _textField.font = [UIFont systemFontOfSize:13];
        _textField.textColor = [UIColor colorWithHex:0x333333];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor colorWithHex:0xf3f5f7];
        _contentView.layer.cornerRadius = 15;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sousuo"]];
    }
    return _icon;
}

@end
