//
//  UserInfoTool.m
//  DDViedo
//
//  Created by iwind on 15/3/25.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "UserInfoTool.h"

@implementation UserInfoTool

///存储用户名
+(BOOL)saveUserName:(NSString *)username
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:username forKey:@"username"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}
///获取用户名
+(NSString *)getUserName
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
   return  [userDefaults objectForKey:@"username"];
}

///删除用户名
+(BOOL)deleteUserName
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"username"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

///存储密码
+(BOOL)savePWD:(NSString *)pwd
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:pwd forKey:@"pwd"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}
///获取密码
+(NSString *)getPWD
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"pwd"];
}
///删除密码
+(BOOL)deletePWD
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"pwd"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

/////存储UUID
//+(BOOL)saveUUID:(NSString *)uuid
//{
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    [userDefaults setObject:uuid forKey:@"uuid"];
//    
//    BOOL ret = [userDefaults synchronize];
//    
//    return ret;
//}
///获取UUID
+(NSString *)getUUID
{
    NSString * uuid = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    
    return  uuid;
}

///存储D_id
+(BOOL)saveD_id:(NSString *)D_id{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:D_id forKey:@"D_id"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取D_id
+(NSString *)getD_id{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"D_id"];
}
///删除D_id
+(BOOL)deleteD_id
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"D_id"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

///存储版本号
+(BOOL)saveVersion:(NSString *)version{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:version forKey:@"CurrentVersion"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}


///获取版本号
+(NSString *)getCurrentVersion{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"CurrentVersion"];
}
///删除版本号
+(BOOL)updateVersion{
    return YES;
}

///存储token
+ (BOOL)saveToken:(NSString *)token
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"Token"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取token
+ (NSString *)getToken
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"Token"];
}
///删除token
+ (BOOL)deleteToken
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"Token"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

///存储验证码
+ (BOOL)saveIdentiCode:(NSString *)code
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:code forKey:@"IdentiCode"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取验证码
+ (NSString *)getIdentiCode
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"IdentiCode"];
}
///删除验证码
+ (BOOL)deleteIdentiCode
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"IdentiCode"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

///存储个推CID
+ (BOOL)saveGeXinClientID:(NSString *)clientId
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:clientId forKey:@"GeXin_CID"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取个推CID
+ (NSString *)getGeXinClientID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"GeXin_CID"];
}
///删除个推CID
+ (BOOL)deleteGeXinClientID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"GeXin_CID"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}


///存储当前ptype
+ (BOOL)saveCurrentPtype:(NSString *)ptype
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ptype forKey:@"CurrentPtype"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取当前ptype
+ (NSString *)getCurrentPtype
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"CurrentPtype"];
}
///删除当前ptype
+ (BOOL)deleteCurrentPtype
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"CurrentPtype"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

///存储当前LabelID
+ (BOOL)saveCurrentLabelID:(NSString *)labelID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:labelID forKey:@"CurrentLabelID"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取当前LabelID
+ (NSString *)getCurrentLabelID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"CurrentLabelID"];
}
///删除当前LabelID
+ (BOOL)deleteCurrentLabelID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"CurrentLabelID"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

///存储当前tableviewTag
+ (BOOL)saveCurrentTVTag:(NSString *)tag
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:tag forKey:@"CurrentTV_Tag"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取当前tableviewTag
+ (NSString *)getCurrentTVTag
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"CurrentTV_Tag"];
}
///删除当前tableviewTag
+ (BOOL)deleteCurrentTVTag
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"CurrentTV_Tag"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}


///存储当前用户ID
+ (BOOL)saveCurrentAccountID:(NSString *)accountId
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:accountId forKey:@"CurrentAccountID"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取当前用户ID
+ (NSString *)getCurrentAccountID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"CurrentAccountID"];
}
///删除当前用户ID
+ (BOOL)deleteCurrentAccountID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"CurrentAccountID"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}

///存储邀单状态
+ (BOOL)saveInviteFlag:(NSString *)flag
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:flag forKey:@"inviteFlag"];
    BOOL ret = [userDefaults synchronize];
    return ret;
}
///获取邀单状态
+ (NSString *)getInviteFlag
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return  [userDefaults objectForKey:@"inviteFlag"];
}
///删除邀单状态
+ (BOOL)deleteInviteFlag
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"inviteFlag"];
    
    BOOL ret = [userDefaults synchronize];
    
    return ret;
}



@end
