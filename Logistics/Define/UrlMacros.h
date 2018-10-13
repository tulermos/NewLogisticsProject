//
//  FCUrl.h
//  风车医生
//
//  Created by lin on 2017/4/4.
//  Copyright © 2017年 FC. All rights reserved.
//

#ifndef FCUrl_h
#define FCUrl_h
/*********************BaseUrl**********************/
#if DEBUG
//测试环境
#define FC_HostName     @"http://s.zjyx833.com/webserviceApp.ashx"
//提测环境
//#define FC_HostName     @"http://s.zjyx833.com/webserviceApp.ashx"

#else
//线上环境
#define FC_HostName     @"http://s.zjyx833.com/webserviceApp.ashx"
#endif

/*********************UrlPath**********************/
#define LoginUrl @"login"
#endif /* FCUrl_h */
