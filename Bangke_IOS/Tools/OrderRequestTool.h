//
//  OrderRequestTool.h
//  Bangke_IOS
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model_Request.h"

typedef void (^Successed) (id model);

typedef void (^Failed) (NSError * err);

@interface OrderRequestTool : NSObject

///根据订单编号查看订单详情
+(void)requestOrderInfoWithProcessId:(NSString *)processid
                        andSuccessed:(Successed)success
                           andFailed:(Failed)fail;

///选择最终竞单者
+(void)selectCompeteUserWithToken:(NSString *)token
                     andProcessId:(NSString *)processId
                     andBiddingID:(NSString *)biddingId
                     andSuccessed:(Successed)success
                        andFailed:(Failed)fail;
///确认发货
+(void)confirmOrderWithProcessID:(NSString *)processId
                    andSuccessed:(Successed)success
                       andFailed:(Failed)fail;
///取消订单
+(void)cancelOrderWithToken:(NSString *)token
               andProcessID:(NSString *)processId
             andFlagApprove:(NSString *)flag
               andSuccessed:(Successed)success
                  andFailed:(Failed)fail;

///确认收货
+(void)confirmFinishOrderWithProcessID:(NSString *)processId
                          andSuccessed:(Successed)success
                             andFailed:(Failed)fail;
///根据订单ID得到发单用户名（微信号）
+(void)queryBuyUserNameWithProcessID:(NSString *)processId
                        andSuccessed:(Successed)success
                           andFailed:(Failed)fail;


///根据订单ID得到接单用户名（微信号）
+(void)querySellUserNameWithProcessID:(NSString *)processId
                         andSuccessed:(Successed)success
                            andFailed:(Failed)fail;

///去帮列表查询
+(void)requestOrderListWithPage:(NSInteger)page
                    andLatitude:(NSString *)latitude
                   andLongitude:(NSString *)longitude
                    andSequence:(NSInteger)sequence
                       andLabel:(NSString *)label
                       andPtype:(NSInteger)type
                   andSuccessed:(Successed)success
                      andFailed:(Failed)fail;
///参与竞单
+(void)competeOrderWithToken:(NSString *)token
                       andID:(NSString *)ID
                     andCost:(NSString *)cost
                andSuccessed:(Successed)success
                   andFailed:(Failed)fail;

///抢订单
+(void)grabOrderWithToken:(NSString *)token
                    andID:(NSString *)ID
             andSuccessed:(Successed)success
                andFailed:(Failed)fail;

@end

