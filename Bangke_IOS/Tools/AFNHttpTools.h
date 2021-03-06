//
//  AFNHttpTools.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/11.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
typedef void (^RequestSuccessed) (NSDictionary * dict);

typedef void (^RequestFailed) (NSError * err);

#import <Foundation/Foundation.h>

@interface AFNHttpTools : NSObject
///json转化
+(NSString *)jsonStringWithDict:(NSDictionary *)dict;
///post请求方法1
+(void)requestWithUrl:(NSString *)url andPostDict:(NSDictionary *)postDict successed:(RequestSuccessed)successed failed:(RequestFailed)failed;
///post请求方法2
+(void)requestWithUrl:(NSString *)url successed:(RequestSuccessed)successed failed:(RequestFailed)failed andKeyVaulePairs:(NSString *)firstobj,...NS_REQUIRES_NIL_TERMINATION;

///post请求方法3
+(void)requestTokenWithUrl:(NSString *)url successed:(RequestSuccessed)successed failed:(RequestFailed)failed andKeyVaulePairs:(NSString *)firstobj,...NS_REQUIRES_NIL_TERMINATION;
//上传图片的
/**
  上传图片
  para url: 相对地址
  para dict:参数的字典
  para image:图片
 */
+(void)imageRequestWithUrl:(NSString *)url postDict:(NSDictionary *)dict image:(UIImage *)image successed:(RequestSuccessed)successed failed:(RequestFailed)failed;

///get方法
+ (void)getDataWithUrl:(NSString *)url
         andParameters:(id)parameters
             successed:(RequestSuccessed)successed
                failed:(RequestFailed)failed;
///put方法
+ (void)putDataWithUrl:(NSString *)url
         andParameters:(id)parameters
             successed:(RequestSuccessed)successed
                failed:(RequestFailed)failed;
///delete方法
+ (void)deleteDataWithUrl:(NSString *)url
            andParameters:(id)parameters
                successed:(RequestSuccessed)successed
                   failed:(RequestFailed)failed;



@end
