//
//  FCAppUpadateModel.h
//  风车医生
//
//  Created by  李红涛 on 2017/11/3.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUpadateModel : NSObject
@property (nonatomic,strong) NSString *resCmd;
@property (nonatomic,strong) NSString *serverVersion;
@property (nonatomic,strong) NSString *IsNewVer;
@property (nonatomic,strong) NSString *lastForce;
@property (nonatomic,strong) NSString *IsAcitve;
@property (nonatomic,strong) NSString *TipInfo;
@property (nonatomic,strong) NSString *updateUrl;
@property (nonatomic,strong) NSString *client;
@property (nonatomic,strong) NSString *uuid;

@end
