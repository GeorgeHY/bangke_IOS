//
//  AlipayTool.m
//  Bangke_IOS
//
//  Created by admin on 15/8/20.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "AlipayTool.h"
#import "Model_SearchRecharge.h"
#import "Model_Request.h"
#import "Model_SearchUserAlipay.h"
#import "Model_SearchMoney.h"
@implementation AlipayTool

+(void)requestRechargeWithToken:(NSString *)token
                       andMoney:(NSString *)money
                   andSuccessed:(Successed)success
                      andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    [param setValue:money forKey:@"money"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools putDataWithUrl:@"alipay/recharge" andParameters:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchRecharge * searchModel = [[Model_SearchRecharge alloc]initWithString:jsonStr error:nil];
        success(searchModel);
    } failed:^(NSError *err) {
        fail(err);
    }];
    
}

+(void)requestWithdrawWithToken:(NSString *)token
                       andMoney:(NSString *)money
                     andAccount:(NSString *)account
                    andUsername:(NSString *)username
                   andSuccessed:(Successed)success
                      andFailed:(Failed)fail
{
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    [param setValue:money forKey:@"money"];
    [param setValue:account forKey:@"alipay_account"];
    [param setValue:username forKey:@"alipay_username"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools deleteDataWithUrl:@"alipay/withdraw" andParameters:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchRecharge * searchModel = [[Model_SearchRecharge alloc]initWithString:jsonStr error:nil];
        success(searchModel);
    } failed:^(NSError *err) {
        fail(err);
    }];
    
}

+(void)requestBindAlipayWithToken:(NSString *)token
                       andAccount:(NSString *)account
                      andUsername:(NSString *)username
                     andSuccessed:(Successed)success
                        andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    [param setValue:account forKey:@"alipay_account"];
    [param setValue:username forKey:@"alipay_username"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools requestWithUrl:@"alipay/bindAlipay" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_Request * requestModel = [[Model_Request alloc]initWithString:jsonStr error:nil];
        success(requestModel);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

+(void)requestUnbindAlipayWithToken:(NSString *)token
                       andSuccessed:(Successed)success
                          andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools requestWithUrl:@"alipay/unbundingAlipay" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_Request * requestModel = [[Model_Request alloc]initWithString:jsonStr error:nil];
        success(requestModel);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

+(void)requestQueryUserAlipayInfoWithToken:(NSString *)token
                              andSuccessed:(Successed)success
                                 andFailed:(Failed)fail
{
    [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"alipay/userAlipayInfo?access_token=%@",token] andParameters:nil successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchUserAlipay * searchModel = [[Model_SearchUserAlipay alloc]initWithString:jsonStr error:nil];
        success(searchModel);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

+(void)requestMoneyInfoWithToken:(NSString *)token
                    andSuccessed:(Successed)success
                       andFailed:(Failed)fail
{
    [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"alipay/moneyInfo?access_token=%@",token] andParameters:nil successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchMoney * searchModel = [[Model_SearchMoney alloc]initWithString:jsonStr error:nil];
        success(searchModel);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

@end
