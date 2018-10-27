//
//  AdvancedQueryViewController.h
//  Logistics
//
//  Created by tulemos on 2018/10/15.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnData)(NSMutableArray *dataArr);
@interface AdvancedQueryViewController : ViewController

@property (nonatomic,assign) NSInteger type;

@property (nonatomic, copy) ReturnData returnData;//声明一个block属性

- (void)returnData:(ReturnData)block;//加上后方便第A视图书写该block方法

@end

NS_ASSUME_NONNULL_END
