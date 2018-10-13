//
//  PriceSumViewController.m
//  Logistics
//
//  Created by meng wang on 2018/4/27.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "PriceSumViewController.h"

@interface PriceSumViewController ()

@property (nonatomic, strong)UITextView *textView;

@end

@implementation PriceSumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Help_jiage", nil);
    [self setupUI];
    [self loadData];
}

- (void)setupUI {
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(FCNavigationHeight);
        make.leading.trailing.bottom.mas_equalTo(self.view);
    }];
}

- (void)loadData {
    NSDictionary *dict = [NSDictionary requestWithUrl:@"business" param:@{@"type":@4}];
    [FCHttpRequest FCNetWork:HttpRequestMethodPost url:nil model:nil cache:NO param:dict success:^(FCBaseResponse *response) {
        if ([response.json[@"state"] isEqualToString:@"success"]) {
            self.textView.text = ((NSArray *)response.json[@"data"]).firstObject[@"info"];
        }
    } failure:^(FCBaseResponse *response) {
        if ([response.json[@"state"] isEqualToString:@"error"]) {
            [FCProgressHUD showText:response.json[@"data"][@"errorMsg"]];
        }
    }];
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
