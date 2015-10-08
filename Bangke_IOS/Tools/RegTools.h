//
//  RegTools.h
//  if_wapeng
//
//  Created by 心 猿 on 14-12-4.
//  Copyright (c) 2014年 funeral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegTools : NSObject
/**
 判断手机号码是否合法
 */
+(BOOL)regResultWithString:(NSString *)string;

/**
 判断所输入的昵称是否合法
 */
+(BOOL)regResultWithNickString:(NSString *)nickString;
/**
 判断所输入的邮箱是否合法
 */
+(BOOL)regResultWithMyMail:(NSString *)myMail;

/**
 判断所输入的QQ号是否合法
 */
+(BOOL)regResultWithQQNumber:(NSString *)QQnum;
/**
 判断所输入的钱数是否合法
 */
+ (BOOL)regResultWithRechargeMoney:(NSString *)money;
@end
