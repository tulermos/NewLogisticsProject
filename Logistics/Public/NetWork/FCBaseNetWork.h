//
//  WKBaseNetWork.h
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCBaseResponse.h"

typedef NS_ENUM(NSUInteger,HttpRequestMethod) {
    HttpRequestMethodGet = 0,
    HttpRequestMethodPost =1
};

typedef void(^SuccessBlock)(FCBaseResponse *response);
typedef void(^FailureBlock)(FCBaseResponse *response);

@interface FCBaseNetWork : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *httpSessionManager;

- (NSURLSessionDataTask*)requestWithMethod:(HttpRequestMethod)httpRequestMethod
                       requestUrl:(NSString *)requestUrl
                            param:(NSDictionary *)param
                            model:(NSString *)model
                            cache:(BOOL)isCache
                          success:(SuccessBlock)successBlock
                          failure:(FailureBlock)failureBlock;

- (void)requestWithMethod:(HttpRequestMethod)httpRequestMethod
               requestUrl:(NSString *)requestUrl
                    model:(NSString *)model
                  fileArr:(NSArray *)fileArr
                    param:(NSDictionary *)param
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock;
@end
