//
//  KernelCommon.h
//  KernelFrameWork
//
//  Created by lin on 2017/7/31.
//  Copyright © 2017年 FC. All rights reserved.
//

#ifndef KernelCommon_h
#define KernelCommon_h

#define kAppServerVersion @"appServerVersion"
#define kAppServerAppUrl @"kAppServerAppUrl"
/*********************第三方appkey**********************/
#define kJPUSHAPPKEY @"9409efa2859ea2434b6bb9b6"
/*********************布局**********************/
#define FCWidth    [UIScreen mainScreen].bounds.size.width
#define FCHeight   [UIScreen mainScreen].bounds.size.height
#define  TB_iPhoneX (FCWidth == 375.f && FCHeight == 812.f ? YES : NO)
#define  Navigation_Height                 (TB_iPhoneX ? 88.f : 64.f)
#define kAutoWidth                  (FCWidth/375)
#define kAutoHeight                 (TB_iPhoneX ? (FCWidth/812) : (FCHeight/667))
/************************Tabbar和NavgationBar字体颜色********************************/
#define TabbarItemNormalTextColor       UIColorFromHex(0x999999)
#define TabbarItemSelectTextColor       UIColorFromHex(0x6793fa)
#define TabbarBackgroundColor           UIColorFromHex(0xffffff)
#define NavgationBarTitleColor          UIColorFromHex(0xffffff)

/*********************项目中公共的颜色**********************/
#define MAIN_COLOR       [UIColor colorWithRed:0 green:0 blue:0 alpha:1.00]
#define kGlobalLineColor [UIColor colorWithHex:0xe1e1e1]
#define kGlobalBGColor   [UIColor colorWithHex:0xf1f1f1]
#define kGlobalMainColor [UIColor colorWithHex:0x567CD4]
#define kGlobalViewBgColor [UIColor colorWithHex:0xefeff4]
#define UIColorFromHex(hexValue)    ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0])


static CGFloat s_screen_navbar_height = 0.0;

#define FC_IPHONE_STATUES_H (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]))
#define FC_IPHONE_NAVBAR_H \
({ \
if (s_screen_navbar_height <= 0.0) { \
s_screen_navbar_height = CGRectGetHeight([[[UINavigationController new] navigationBar] frame]); \
} \
s_screen_navbar_height; \
})
#define FC_IPHONE_NAV_H (FC_IPHONE_STATUES_H + FC_IPHONE_NAVBAR_H)


//iphone6分辨率
#define FCScaleW     [UIScreen mainScreen].bounds.size.width/375
#define FCScaleH     [UIScreen mainScreen].bounds.size.width/667
#define FCStateHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define FCNavigationHeight [UIApplication sharedApplication].statusBarFrame.size.height + 44
//#define FCNavigationHeight 64
#define FCBottomSafeHeight (kDevice_Is_iPhoneX ? 34:0)

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


/*********************常用的工具类**********************/
#define FCHttpRequest     [FCNetWorkManager shareNetWork]
#define kUserDefaultKeyUser @"kUserDefaultKey_user"

/*********************公共的Block**********************/
typedef void (^loginSuccess)();
typedef void (^PushBlock)(id object);
typedef void (^Void_Block)(void);
typedef void (^Bool_Block)(BOOL value);
typedef void (^Int_Block)(NSInteger value);
typedef void (^String_Block)(NSString *value);
typedef void (^Dict_Block)(NSDictionary *value);
typedef void (^Id_Block)(id obj);
typedef void (^Async_Block)(id responseDTO);
typedef BOOL (^GesRecognizer_Block)(UIGestureRecognizer*, UITouch*);
typedef void (^SelectIndexData)(id data,NSInteger index);
typedef void (^DataHelper_Block)(id obj, BOOL ret);
typedef void (^DataHelper_Block_Page)(id obj, BOOL ret, int pageNumber);
typedef void (^DataHelper_Block_Auth)(id obj, BOOL ret, NSInteger index);
typedef void (^Location_Block)(id currentLongitude,id currentLatitude);
typedef void (^BtnClickBlock)(UIButton *sender);
typedef void (^OrderbyBtnIndex)(UIButton *sender,BOOL isUp);
typedef void (^SelectStandardMessage)(NSString *selectStandardString);

/*********************log**********************/
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#define FCLog(fmt, ...) NSLog((@" 方法:%s 行号:%d 日志内容:" fmt),  __FUNCTION__, __LINE__, ##__VA_ARGS__);

#define IQ_IS_IOS10_OR_GREATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 10)
#define IQ_IS_IOS11_OR_GREATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 11)

#endif /* KernelCommon_h */
