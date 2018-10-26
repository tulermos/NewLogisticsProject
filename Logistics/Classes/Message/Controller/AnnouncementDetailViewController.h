//
//  AnnouncementDetailViewController.h
//  Logistics
//
//  Created by tulemos on 2018/10/26.
//  Copyright © 2018 meng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnouncementDetailViewController : UIViewController

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,copy) NSString *requestUrl;

@end

NS_ASSUME_NONNULL_END
