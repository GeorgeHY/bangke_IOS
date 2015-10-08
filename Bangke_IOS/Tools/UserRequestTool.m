//
//  UserRequestTool.m
//  Bangke_IOS
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "UserRequestTool.h"
#import "Model_SearchMerchantInfo.h"
#import "Model_SearchUser.h"
#import "Model_SearchHeadPortrait.h"
@implementation UserRequestTool

+ (void)requestPersonInfoWithAccount:(NSString *)account
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:account forKey:@"account"];
    NSLog(@"param = %@",param);
    [AFNHttpTools requestWithUrl:@"users/getPersonInfo" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_SearchMerchantInfo * searchModel = [[Model_SearchMerchantInfo alloc]initWithString:jsonStr error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",err);
    }];
}


+ (void)requestPersonInfoWithToken:(NSString *)token
                      andSuccessed:(Successed)success
                         andFailed:(Failed)fail
{
    [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"permissions/user/userInfo?access_token=%@",token] andParameters:nil successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchUser * searchModel = [[Model_SearchUser alloc]initWithString:jsonStr error:nil];
        success(searchModel);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

+(void)returnHeadPortraitInfofromAccount:(NSString *)account
                            andSuccessed:(Successed)success
                               andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:account forKey:@"account"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools requestWithUrl:@"getHeadPortraitInfo" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_SearchHeadPortrait * model = [[Model_SearchHeadPortrait alloc]initWithString:jsonStr error:nil];
        success(model);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

///获取配置文件
+(void)getconfigWithToken:(NSString *)token
             andSuccessed:(Successed)success
                andFailed:(Failed)fail
{
    [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"permissions/config/properties?access_token=%@",token] andParameters:nil successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",err);
    }];
}

@end
