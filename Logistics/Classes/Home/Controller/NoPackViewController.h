//
//  NoPackViewController.h
//  Logistics
//
//  Created by tulemos on 2018/10/18.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface NoPackViewController : ViewController

@property (nonatomic,assign) NSInteger status;

-(void)getMeaData;

-(void)getPackData;

@end

NS_ASSUME_NONNULL_END
