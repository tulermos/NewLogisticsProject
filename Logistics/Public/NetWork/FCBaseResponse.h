//
//  WKBaseResponse.h
//
//  Created by xiaofengche on 2017/3/24.
//  Copyright © 2017年 xiaofengche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCBaseResponse : NSObject

@property (nonatomic, assign)BOOL isSuccess;
@property (nonatomic, strong)NSString *state;
/**
 *  服务端返回的响应码(根据后台返回的数据进行相应的修改)
 */
@property (nonatomic, copy) NSString *errorCode;
/**
 *  服务端返回的消息描述(根据后台返回的数据进行相应的修改)
 */
@property (nonatomic, copy) NSString *errorMsg;

@property (nonatomic, copy) NSString *uuid;
/**
 *  服务端返回的数据
 */
@property (nonatomic ,strong) id    data;

@property (nonatomic ,strong) id    json;

+ (instancetype)responseParse:(id)json modelClass:(NSString *)modelClass;

@end
