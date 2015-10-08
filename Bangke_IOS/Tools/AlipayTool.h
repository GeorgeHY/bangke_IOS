//
//  AlipayTool.h
//  Bangke_IOS
//
//  Created by admin on 15/8/20.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Successed) (id model);

typedef void (^Failed) (NSError * err);

@interface AlipayTool : NSObject

///充值
+(void)requestRechargeWithToken:(NSString *)token
                       andMoney:(NSString *)money
                   andSuccessed:(Successed)success
                      andFailed:(Failed)fail;
///提现
+(void)requestWithdrawWithToken:(NSString *)token
                       andMoney:(NSString *)money
                     andAccount:(NSString *)account
                    andUsername:(NSString *)username
                   andSuccessed:(Successed)success
                      andFailed:(Failed)fail;

///绑定支付宝
+(void)requestBindAlipayWithToken:(NSString *)token
                       andAccount:(NSString *)account
                      andUsername:(NSString *)username
                     andSuccessed:(Successed)success
                        andFailed:(Failed)fail;

///解绑支付宝
+(void)requestUnbindAlipayWithToken:(NSString *)token
                       andSuccessed:(Successed)success
                          andFailed:(Failed)fail;

///查询支付宝
+(void)requestQueryUserAlipayInfoWithToken:(NSString *)token
                              andSuccessed:(Successed)success
                                 andFailed:(Failed)fail;
///用户金额信息（余额冻结提现中）
+(void)requestMoneyInfoWithToken:(NSString *)token
                    andSuccessed:(Successed)success
                       andFailed:(Failed)fail;
@end
