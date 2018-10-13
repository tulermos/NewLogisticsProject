//
//  WKBaseResponse.m
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import "FCBaseResponse.h"
#import "CHAlertAction.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation FCBaseResponse

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Code" : @"code"};
}

+ (instancetype)responseParse:(id)json modelClass:(NSString *)modelClass{
    if (json != nil) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:json encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        FCBaseResponse *response = [[self class] yy_modelWithDictionary:json];
        if (!response) {
            response = [[FCBaseResponse alloc]init];
        }
        if ([json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                response.isSuccess = YES;
                response.json = json;
                if (modelClass != nil || modelClass.length != 0) {
                    if ([json[@"data"] isKindOfClass:[NSDictionary class]]) {
                        response.data = [NSClassFromString(modelClass) yy_modelWithJSON:response.data];
                    }else if ([json[@"data"] isKindOfClass:[NSArray class]]) {
                        response.data = [NSClassFromString(modelClass) yy_modelWithJSON:json];
                    }else {
                        response.data = json;
                    }
                }
            }else {
                response.isSuccess = NO;
                response.json = json;
                if (modelClass != nil || modelClass.length != 0) {
                    if ([json[@"error"] isKindOfClass:[NSDictionary class]]) {
                        response.data = [[self class] yy_modelWithJSON:response.data];
                    }
                }
            }
        }else  {
            response.json = json;
        }
        return response;
    }
    return nil;
}

- (NSString *) description{
    
    NSString *result = @"";
    result = [result stringByAppendingFormat:@"state : %@\n",self.state];
    result = [result stringByAppendingFormat:@"data : %@\n",self.data];
    
    return result;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
