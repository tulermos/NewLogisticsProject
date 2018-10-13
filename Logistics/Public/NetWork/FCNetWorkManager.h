//
//  WKNetWorkManager.h
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import "FCBaseNetWork.h"

@interface FCNetWorkManager : FCBaseNetWork

/*
 * 网络是否可以
 */
@property (nonatomic,assign) BOOL isNetworkEnable;

+ (instancetype)shareNetWork;

@property (nonatomic, copy)NSString *controllerName;

- (NSURLSessionDataTask*)FCNetWork:(HttpRequestMethod)httpRequestMethod
           url:(NSString *)url
         model:(NSString *)model
         cache:(BOOL)isCache
         param:(NSDictionary *)param
       success:(SuccessBlock)successBlock
       failure:(FailureBlock)failureBlock;


- (void)FCUploadImages:(HttpRequestMethod)httpRequestMethod
                   url:(NSString *)url
               fileArr:(NSArray *)fileArr
               success:(SuccessBlock)successBlock
               failure:(FailureBlock)failureBlock;

@end
