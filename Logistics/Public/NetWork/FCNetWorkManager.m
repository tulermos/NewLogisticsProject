//
//  WKNetWorkManager.m
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import "FCNetWorkManager.h"

static FCNetWorkManager *_fcNetWorkManager = nil;

@implementation FCNetWorkManager

+ (instancetype)shareNetWork{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _fcNetWorkManager = [[FCNetWorkManager alloc] init];
    });
    return _fcNetWorkManager;
}

- (NSURLSessionDataTask*)FCNetWork:(HttpRequestMethod)httpRequestMethod
            url:(NSString *)url
          model:(NSString *)model
          cache:(BOOL)isCache
          param:(NSDictionary *)param
        success:(SuccessBlock)successBlock
        failure:(FailureBlock)failureBlock
{
    return [self requestWithMethod:httpRequestMethod requestUrl:url param:param model:model cache:isCache success:successBlock failure:failureBlock];
}

- (void)FCUploadImages:(HttpRequestMethod)httpRequestMethod
                   url:(NSString *)url
               fileArr:(NSArray<UIImage *> *)fileArr
               success:(SuccessBlock)successBlock
               failure:(FailureBlock)failureBlock{
    [self requestWithMethod:httpRequestMethod requestUrl:url model:nil fileArr:fileArr param:nil success:successBlock failure:failureBlock];
}

@end
