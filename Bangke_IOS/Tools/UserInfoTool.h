//
//  UserInfoTool.h
//  DDViedo
//
//  Created by iwind on 15/3/25.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoTool : NSObject
///存储用户名
+(BOOL)saveUserName:(NSString *)username;
///获取用户名
+(NSString *)getUserName;
///删除用户名
+(BOOL)deleteUserName;

///存储密码
+(BOOL)savePWD:(NSString *)pwd;
///获取密码
+(NSString *)getPWD;
///删除密码
+(BOOL)deletePWD;

/////存储UUID
//+(BOOL)saveUUID:(NSString *)uuid;
///获取UUID
+(NSString *)getUUID;

///存储D_id
+(BOOL)saveD_id:(NSString *)D_id;
///获取D_id
+(NSString *)getD_id;
///删除D_id
+(BOOL)deleteD_id;

///存储版本号
+(BOOL)saveVersion:(NSString *)version;
///获取版本号
+(NSString *)getCurrentVersion;
///删除版本号
+(BOOL)updateVersion;

///存储token
+ (BOOL)saveToken:(NSString *)token;
///获取token
+ (NSString *)getToken;
///删除token
+ (BOOL)deleteToken;

///存储验证码
+ (BOOL)saveIdentiCode:(NSString *)code;
///获取验证码
+ (NSString *)getIdentiCode;
///删除验证码
+ (BOOL)deleteIdentiCode;

///存储个推CID
+ (BOOL)saveGeXinClientID:(NSString *)clientId;
///获取个推CID
+ (NSString *)getGeXinClientID;
///删除个推CID
+ (BOOL)deleteGeXinClientID;

///存储当前tableviewTag
+ (BOOL)saveCurrentTVTag:(NSString *)tag;
///获取当前tableviewTag
+ (NSString *)getCurrentTVTag;
///删除当前tableviewTag
+ (BOOL)deleteCurrentTVTag;

///存储当前ptype
+ (BOOL)saveCurrentPtype:(NSString *)ptype;
///获取当前ptype
+ (NSString *)getCurrentPtype;
///删除当前ptype
+ (BOOL)deleteCurrentPtype;

///存储当前LabelID
+ (BOOL)saveCurrentLabelID:(NSString *)labelID;
///获取当前LabelID
+ (NSString *)getCurrentLabelID;
///删除当前LabelID
+ (BOOL)deleteCurrentLabelID;

///存储当前用户ID
+ (BOOL)saveCurrentAccountID:(NSString *)accountId;
///获取当前用户ID
+ (NSString *)getCurrentAccountID;
///删除当前用户ID
+ (BOOL)deleteCurrentAccountID;

///存储邀单状态
+ (BOOL)saveInviteFlag:(NSString *)flag;
///获取邀单状态
+ (NSString *)getInviteFlag;
///删除邀单状态
+ (BOOL)deleteInviteFlag;


@end
