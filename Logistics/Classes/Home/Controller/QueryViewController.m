//
//  QueryViewController.m
//  Logistics
//
//  Created by meng wang on 2018/7/8.
//  Copyright © 2018年 meng wang. All rights reserved.
//

#import "QueryViewController.h"
#import "QuerySearchBar.h"

@interface QueryViewController ()

@property (nonatomic, strong)QuerySearchBar *searchBar;
@property (nonatomic, strong)UIWebView *webView;

@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addBlock];
}

- (void)setupUI {
    self.title = NSLocalizedString(@"Home_jingqingqidai", nil);
    self.searchBar = [[QuerySearchBar alloc]init];
    self.webView = [[UIWebView alloc]init];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 90, 0);
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.webView];
    self.searchBar.frame = CGRectMake(0, FCNavigationHeight, FCWidth, 45);
    self.webView.frame = CGRectMake(0, FCNavigationHeight + 45, FCWidth, FCHeight - FCNavigationHeight - 45);
}

- (void)addBlock {
    
    @weakify(self);
    self.searchBar.clickDanjuBlock = ^{
        @strongify(self);
        [self.view endEditing:YES];
        [self loadData:@"outerprint"];
        
    };
    self.searchBar.clickKuanhaoBlock = ^{
        @strongify(self);
        [self.view endEditing:YES];
        [self loadData:@"innerprint"];
    };
}

- (void)loadData:(NSString *)protocol {
    [FCProgressHUD showLoadingOn:self.view];
    NSDictionary *dict = [NSDictionary requestWithUrl:protocol param:@{@"cusCode":[UserManager sharedManager].user.cusCode,@"entNumber":[UserManager sharedManager].user.entNumber,@"printkey":self.searchBar.searchStr}];
    [FCHttpRequest requestWithMethod:HttpRequestMethodPost requestUrl:nil param:dict model:nil cache:NO success:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        if ([response.json[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dict = ((NSArray *)response.json[@"data"]).firstObject;
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:dict[@"webUrl"]]];
            [self.webView loadRequest:request];
        }
    } failure:^(FCBaseResponse *response) {
        [FCProgressHUD hideHUDForView:self.view animation:YES];
        NSDictionary *dict = ((NSArray *)response.data).firstObject;
        [FCProgressHUD showText:dict[@"errorMsg"]];
    }];
}

@end
