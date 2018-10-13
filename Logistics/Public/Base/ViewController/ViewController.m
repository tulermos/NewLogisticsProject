//
//  ViewController.m
//  风车医生
//
//  Created by lin on 2017/4/1.
//  Copyright © 2017年 FC. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskDict = [NSMutableDictionary dictionary];
    self.view.backgroundColor = kGlobalBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    for (NSURLSessionDataTask *task in [self.taskDict allValues]) {
        if(task.state != NSURLSessionTaskStateCompleted) {
            FCLog(@"请求被取消：%@",task.currentRequest.URL);
            [task cancel];
        }
    }
    self.taskDict = nil;
}

- (void)dealloc {
    FCLog(@"控制器被销毁");
}

@end
