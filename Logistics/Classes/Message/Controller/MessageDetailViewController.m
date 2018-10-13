//
//  MessageDetailViewController.m
//  Logistics
//
//  Created by meng wang on 2018/5/2.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@property (nonatomic, strong)UITextView *textView;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(FCNavigationHeight);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
    self.textView.text =self.content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.editable = NO;
    }
    return _textView;
}

@end
