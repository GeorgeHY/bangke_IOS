//
//  UserRequestTool.h
//  Bangke_IOS
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Successed) (id model);

typedef void (^Failed) (NSError * err);

@interface UserRequestTool : NSObject

///根据账号返回商家或者个人信息
+ (void)requestPersonInfoWithAccount:(NSString *)account;

///个人信息（我的简历）
+ (void)requestPersonInfoWithToken:(NSString *)token
                      andSuccessed:(Successed)success
                         andFailed:(Failed)fail;

///通过用户名获取用户头像详情
+(void)returnHeadPortraitInfofromAccount:(NSString *)account
                            andSuccessed:(Successed)success
                               andFailed:(Failed)fail;
///获取配置文件
+(void)getconfigWithToken:(NSString *)token
             andSuccessed:(Successed)success
                andFailed:(Failed)fail;


@end
