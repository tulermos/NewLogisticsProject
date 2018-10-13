//
//  FCNetWorkError.m
//  风车医生
//
//  Created by meng wang on 2017/11/23.
//  Copyright © 2017年 FC. All rights reserved.
//

#import "FCNetWorkError.h"

@interface FCNetWorkError()


@end

@implementation FCNetWorkError

+ (NSString *)errorMessage:(NSInteger)code {
    NSString *msg = nil;
    switch (code) {
        case -1:
            msg = @"服务器异常";
            break;
        case -4:
            msg = @"参数非空异常";
            break;
        case -3:
            msg = @"没找到相应对象";
            break;
        case -2:
            msg = @"登录验证码错误";
            break;
        case -5:
            msg = @"订单状态异常";
            break;
        case -6:
            msg = @"医生状态异常";
            break;
        case -7:
            msg = @"订单没有编辑";
            break;
        case -8:
            msg =@"第三方电话接口异常";
            break;
        case -9:
            msg = @"错误的签到状态";
            break;
        case -10:
            msg = @"错误的解读报告状态";
            break;
        case -11:
            msg = @"问题被重复回答";
            break;
        case -42:
            msg = @"参数异常";
            break;
        case 404:
            msg = @"无法找到文件";
            break;
        case 500:
            msg = @"系统错误";
            break;
        case 502:
            msg = @"错误网关";
            break;
        case 503:
            msg = @"服务不可用";
            break;
        case 504:
            msg = @"网关超时";
            break;
        case 101:
        case 102:
        case 110:
            msg = @"服务器异常";
            break;
        case -1004:
            msg = @"未能连接到服务器";
            break;
        case -1001:
            msg = @"请求超时";
            break;
        case -1003:
        case -1009:
            msg = @"网络未连接，请检查网络";
            break;
        case -2000:
            msg = @"当前网络不佳，请稍后重试";
            break;
        case -999:
            msg = @"请求失败，请重试";
            break;
        case -1011:
        case -1008:
            msg = @"服务器错误";
            break;
        case -1201:
        case -1015:
        case -1016:
            msg = @"服务器返回异常";
            break;
        case -1005:
            msg = @"失去连接，请重试";
            break;
        case -1000:
        case -1002:
            msg = @"非法Url";
            break;
        default:
            break;
    }
    return msg;
}

@end
