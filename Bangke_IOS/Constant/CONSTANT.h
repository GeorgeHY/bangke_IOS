//
//  CONSTANT.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#ifndef DDViedo_CONSTANT_h
#define DDViedo_CONSTANT_h

#define dTips_connectionError @"网络连接错误，请稍候重试~"
#define dTips_requestError @"请求错误"
#define dTips_timeOut @"请求超时"
#define dTips_stateFail @"操作失败，请稍候重试~"
#define dTips_noData @"数据为空~"
#define dTips_noMoreData @"没有更多数据了"
#define dTips_parseError @"解析错误"
#define dTips_uploadError @"头像上传失败"
#define dTips_uploadSuccess @"头像上传成功"
#define dTip_loading @"正在加载..."
#define dTips_changeSuccess @"修改成功"
#define dTips_changeFailed  @"修改失败"
#define dTips_quitSuccess   @"注销成功"


#define dStateSuccess  @"SUCCESS"
#define dStateFail   @"FAIL"
#define dStateTokenInvalid @"OUATH"
//被迫登出
#define dStateLogout 7
#define dPackageFail 6
#define ToastDuration 0.5



#define dNormalSource 1
#define dVipSource 2


#define   kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define   kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define   kRatio [UIScreen mainScreen].bounds.size.width / 320.0
#define kStatusBarHeight [[UIApplication sharedApplication]statusBarFrame].size.height

#define URL_TEST_MOVIE @"http://tv.sohu.com/20131202/n391143291.shtml?txid=b88fafa04634e028b94b84d63b23b53f"
//172.16.0.59
//119.254.108.212

#define slsd

#ifdef TESTURL
#define URL_BASE @"http://api.52bangke.com/mobile/"
#define URL_BASE_LOGIN @"http://api.52bangke.com/"
#define URL_BASE_H5 @"http://api.52bangke.com/phone/"

#define URL_BASE_IMAGE @"http://119.254.108.212/video/common/upload/images/"
#define URL_BASE_MOVIE @"http://119.254.108.212/video/common/RBT/"
#define URL_NESLIST @"coupons/getNewsList" //新闻资讯
#define URL_PRIVILEAGE @"coupons/privilegeList"//惠生活
#define URL_PRIVILEAGE_CATEGORY @"coupons/categoryList"//惠生活分类
#define URL_NEWSDETAIL @"http://119.254.108.212/video/clientapi.php/coupons/getNewsById/id/" //新闻详情
#else

#define URL_BASE @"http://52bangke.aliapp.com/mobile/"
#define URL_BASE_LOGIN @"http://52bangke.aliapp.com/"
#define URL_BASE_H5 @"http://52bangke.aliapp.com/phone/"


#define URL_BASE_IMAGE @"http://101.200.201.241/video/common/upload/images/"
#define URL_BASE_MOVIE @"http://172.16.0.52/video/common/RBT/"
#define URL_NESLIST @"coupons/getNewsList" //新闻资讯
#define URL_PRIVILEAGE @"coupons/privilegeList"//惠生活
#define URL_PRIVILEAGE_CATEGORY @"coupons/categoryList"//惠生活分类
#define URL_NEWSDETAIL @"http://172.16.0.52/video/clientapi.php/coupons/getNewsById/id/" //新闻详情
#endif

/*
 typeof(int *) a,b;
 等价于：
 int *a,*b;
 */

#define  curVersion [[[UIDevice currentDevice] systemVersion] floatValue] < 8 ?  7 : 8
#define WEAK_SELF(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define kNotNull(obj)  [obj isEqual:[NSNull null]]
//#import "SVProgressHUD.h"

#define ud_D_ID @"D_ID"
#define kNaviMaxY CGRectGetMaxY(self.navigationController.navigationBar.frame)

#define kMainScreenBounds [[UIScreen mainScreen]bounds]
#define kLeftMenuReveal 276
#define kBORDERWIDTH 0.5
#define NAVICOLOR @"3E3D42"

//Current device Information

#define kDeviceModel [[UIDevice currentDevice]model]
#define KDeviceSystemName [[UIDevice currentDevice]systemName]
#define kDeviceSystemVersion [[UIDevice currentDevice]systemVersion]
#define kDeviceUUID [[UIDevice currentDevice]identifierForVendor]UUIDString]


#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

#define SCALE_WIDTH(w) (SCREEN_WIDTH/320.0*w)
#define SCALE_HEIGHT(h) (SCREEN_HEIGHT/568.0*h)

#define RECTFIX_WIDTH(a) (IS_IPHONE6 ? a : SCALE_WIDTH(a))
#define RECTFIX_HEIGHT(a) (IS_IPHONE6 ? a : SCALE_HEIGHT(a))

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define APPLICATION ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//orderstate



#endif
