//
//  WKBaseNetWork.m
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import "FCBaseNetWork.h"
#import "EncodeTarget.h"
#import "NSString+WJ.h"
#import <YYCache.h>

@interface FCBaseNetWork ()

@end

@implementation FCBaseNetWork

- (AFHTTPSessionManager *)httpSessionManager
{
    static AFHTTPSessionManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        _instance.responseSerializer = response;
        _instance.requestSerializer = [AFJSONRequestSerializer serializer];
        _instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        _instance.requestSerializer.timeoutInterval = 30.0f;
        
        _instance.responseSerializer.acceptableContentTypes = [_httpSessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/javascript",@"text/json", nil]];
        _instance.securityPolicy = [AFSecurityPolicy defaultPolicy];
        _instance.securityPolicy.allowInvalidCertificates = YES;
    });
    return _instance;
}

- (NSURLSessionDataTask*)requestWithMethod:(HttpRequestMethod)httpRequestMethod
               requestUrl:(NSString *)requestUrl
                    param:(NSDictionary *)param
                    model:(NSString *)model
                    cache:(BOOL)isCache
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock
{

    return [self baseRequestWithMethod:httpRequestMethod requestUrl:requestUrl param:param model:model cache:isCache success:successBlock failure:failureBlock];
}

- (void)requestWithMethod:(HttpRequestMethod)httpRequestMethod
               requestUrl:(NSString *)requestUrl
                    model:(NSString *)model
                  fileArr:(NSArray *)fileArr
                    param:(NSDictionary *)param
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock
{
    NSString *url = [FC_HostName stringByAppendingString:requestUrl];
    NSString *params = [NSString stringFromJson:param];
    if (httpRequestMethod == HttpRequestMethodPost) {
        
       [self.httpSessionManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if ([fileArr[0] isKindOfClass:[UIImage class]]) {
                for (int i=0;i<fileArr.count;i++) {
                    NSData *imageData = UIImageJPEGRepresentation(fileArr[i], 0.05);
                    [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image%d",i] fileName:@"test.jpg" mimeType:@"image/jpg"];
                }
            }else{
                NSData *spxData = fileArr[0];
                [formData appendPartWithFileData:spxData name:@"" fileName:@"voice.spx" mimeType:@"spx"];
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            FCBaseResponse *response = [FCBaseResponse responseParse:responseObject modelClass:model];
            
            if (response.isSuccess && successBlock) {
                
                successBlock(response);
                
            }else if (response.isSuccess && failureBlock){
                
                failureBlock(response);
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            FCBaseResponse *response = [FCBaseResponse new];
            response.errorCode = [NSString stringWithFormat:@"%zd",error.code];
            response.errorMsg = error.description;
            if (failureBlock) {
                failureBlock(response);
            }
        }];
    }
}

- (NSURLSessionDataTask*)baseRequestWithMethod:(HttpRequestMethod)httpRequestMethod
               requestUrl:(NSString *)requestUrl
                    param:(NSDictionary *)param
                        model:(NSString *)model
                        cache:(BOOL)isCache
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock
{
    
    if (![requestUrl containsString:@"actLogs.json"]) {
        NSLog(@" +++++++++++++rquest begin++++++++++");
        NSLog(@"Host:%@ URL:%@ \n param:%@ \n model:%@",FC_HostName,requestUrl,[NSString stringFromJson:param],model);
    }
    
    NSString *url = requestUrl;
    NSDictionary *paramDict = param;
    
    url = [FC_HostName stringByAppendingPathComponent:requestUrl];
    return [self RequestWithMethod:httpRequestMethod requestUrl:url param:paramDict model:model cache:isCache  success:^(FCBaseResponse *response) {
        if (![requestUrl containsString:@"actLogs.json"]) {
            FCLog(@"URL:%@\n%@",requestUrl ,response.json);
            FCLog(@"rquest +++++++++++++rquest end++++++++++");
        }
        if (successBlock) {
            successBlock(response);
        }
    } failure:^(FCBaseResponse *response) {
        
        if (![requestUrl containsString:@"actLogs.json"]) {
            FCLog(@"URL:%@\n%@",requestUrl ,[response yy_modelToJSONObject]);
            FCLog(@"rquest +++++++++++++rquest end++++++++++");
        }
        if (failureBlock) {
            failureBlock(response);
        }
    } ];
}

- (NSURLSessionDataTask*)RequestWithMethod:(HttpRequestMethod)httpRequestMethod
                   requestUrl:(NSString *)requestUrl
                        param:(NSDictionary *)param
                        model:(NSString *)model
                        cache:(BOOL)isCache
                      success:(SuccessBlock)successBlock
                      failure:(FailureBlock)failureBlock
{
    NSURLSessionDataTask *task = nil;
    
    //添加缓存策略
    if (![AFNetworkReachabilityManager sharedManager].isReachable) {
        [FCProgressHUD hideHUDForWindow];
        if (isCache) {
            YYCache *cache = [YYCache cacheWithName:@"cache"];
            NSDictionary *dict = (NSDictionary *)[cache objectForKey:[self createCacheKey:requestUrl parameter:param]];
            FCBaseResponse *response = [FCBaseResponse yy_modelWithDictionary:dict];
            response.json = dict;
            response.data = [NSClassFromString(model) yy_modelWithDictionary:dict[@"data"]];
            
            if (successBlock) {
                successBlock(response);
            }
            return task;
        }
    }
    
    if (httpRequestMethod == HttpRequestMethodPost) {
        task = [self.httpSessionManager POST:requestUrl parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
          
            FCBaseResponse *response = [FCBaseResponse responseParse:responseObject modelClass:model];
            //保存缓存数据
            if (response.json && isCache) {
                YYCache *cache = [YYCache cacheWithName:@"cache"];
                [cache setObject:response.json forKey:[self createCacheKey:requestUrl parameter:param]];
            }
            if (successBlock) {
                successBlock(response);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            FCBaseResponse *response = [[FCBaseResponse alloc]init];
            response.errorCode = [NSString stringWithFormat:@"%zd",error.code];
            response.errorMsg = error.description;
            if (failureBlock) {
                failureBlock(response);
            }
        }];

    }else if (httpRequestMethod == HttpRequestMethodGet){
        
        task = [self.httpSessionManager GET:requestUrl parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            [FCProgressHUD hideHUDForWindow];
            FCBaseResponse *response = [FCBaseResponse responseParse:responseObject modelClass:model];
            if (response.isSuccess && successBlock) {
                successBlock(response);
            }else if (response.isSuccess  && failureBlock){
                failureBlock(response);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [FCProgressHUD hideHUDForWindow];
            FCBaseResponse *response = [FCBaseResponse new];
            response.errorMsg = error.description;
            if (failureBlock) {
                failureBlock(response);
            }
        }];
    }
    return task;
}

//生成缓存的key
- (NSString *)createCacheKey:(NSString *)url parameter:(NSDictionary *)parameter {
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",url,paraString];
    return cacheKey;
}

@end
