//
//  NavigationBarView.m
//  Logistics
//
//  Created by meng wang on 2018/4/20.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "NavigationBarView.h"

@interface NavigationBarView()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *backButton;
@property (nonatomic, copy)Void_Block popBlock;

@end

@implementation NavigationBarView

- (instancetype)initWithTitle:(NSString *)title popBlock:(Void_Block)block {
    
    NavigationBarView *navBar = [[NavigationBarView alloc]init];
    navBar.titleLabel.text = title;
    navBar.popBlock = block;
    return navBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = kGlobalMainColor;
    self.titleLabel = [UILabel labelWithFont:19 textColor:[UIColor whiteColor] text:nil];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    self.backButton =[UIButton buttonWithNormalImage:@"fanhui" selectedImage:nil];
    [_backButton addTarget:self action:@selector(clickPop) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_titleLabel];
    [self addSubview:_backButton];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_titleLabel);
        make.leading.mas_equalTo(self).offset(15);
    }];
}


- (void)clickPop {
    if (self.popBlock) {
        self.popBlock();
    }
}

@end
