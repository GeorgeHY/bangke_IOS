

//
//  OrderRequestTool.m
//  Bangke_IOS
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 iwind. All rights reserved.
//
#define ROWS @"10"
#import "OrderRequestTool.h"
#import "Model_SearchReviewOrder.h"
#import "Model_Request.h"
#import "Model_SearchAccount.h"
#import "Model_SearchHelpList.h"
@implementation OrderRequestTool

+(void)requestOrderInfoWithProcessId:(NSString *)processid
                        andSuccessed:(Successed)success
                           andFailed:(Failed)fail
{
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:processid forKey:@"process_recode_id"];
    [param setValue:[UserInfoTool getToken] forKey:@"Access_token"];
    NSLog(@"param = %@",param);
    [AFNHttpTools requestWithUrl:@"permissions/order/getOrderInfo" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchReviewOrder * searchModel = [[Model_SearchReviewOrder alloc]initWithString:jsonStr error:nil];
        success(searchModel);
    } failed:^(NSError *err) {
        NSLog(@"err = %@",err);
        fail(err);
    }];
    
    
}

+(void)selectCompeteUserWithToken:(NSString *)token
                     andProcessId:(NSString *)processId
                     andBiddingID:(NSString *)biddingId
                     andSuccessed:(Successed)success
                        andFailed:(Failed)fail
{
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    [param setValue:processId forKey:@"process_recode_id"];
    [param setValue:biddingId forKey:@"processBiddingID"];
    NSLog(@"param = %@",param);
    [AFNHttpTools requestWithUrl:@"permissions/order/selectHelperTerminal" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_Request * model = [[Model_Request alloc]initWithString:jsonStr error:nil];
        success(model) ;
    } failed:^(NSError *err) {
        fail(err);
    }];
    
    
    
}

+(void)confirmOrderWithProcessID:(NSString *)processId
                    andSuccessed:(Successed)success
                       andFailed:(Failed)fail
{
    [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"order/deliver/%@",processId] andParameters:nil successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_Request * model = [[Model_Request alloc]initWithString:jsonStr error:nil];
        success(model);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

+(void)cancelOrderWithToken:(NSString *)token
               andProcessID:(NSString *)processId
             andFlagApprove:(NSString *)flag
               andSuccessed:(Successed)success
                  andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    [param setValue:processId forKey:@"processId"];
    [param setValue:flag forKey:@"flagApprove"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools requestWithUrl:@"permissions/order/orderCancel" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_Request * model = [[Model_Request alloc]initWithString:jsonStr error:nil];
        success(model);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

+(void)confirmFinishOrderWithProcessID:(NSString *)processId
                          andSuccessed:(Successed)success
                             andFailed:(Failed)fail
{
    [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"order/processSuccess/%@",processId] andParameters:nil successed:^(NSDictionary *dict) {
        
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_Request * model = [[Model_Request alloc]initWithString:jsonStr error:nil];
        success(model);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

+(void)queryBuyUserNameWithProcessID:(NSString *)processId
                        andSuccessed:(Successed)success
                           andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:processId forKey:@"processId"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools requestWithUrl:@"order/queryBuyUserName" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_SearchAccount * model = [[Model_SearchAccount alloc]initWithString:jsonStr error:nil];
        success(model);
    } failed:^(NSError *err) {
        fail(err);
    }];
    
}

+(void)querySellUserNameWithProcessID:(NSString *)processId
                         andSuccessed:(Successed)success
                            andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:processId forKey:@"processId"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools requestWithUrl:@"order/querySellUserName" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_SearchAccount * model = [[Model_SearchAccount alloc]initWithString:jsonStr error:nil];
        success(model);
    } failed:^(NSError *err) {
        fail(err);
    }];
}

///去帮列表查询
+(void)requestOrderListWithPage:(NSInteger)page
                    andLatitude:(NSString *)latitude
                   andLongitude:(NSString *)longitude
                    andSequence:(NSInteger)sequence
                       andLabel:(NSString *)label
                       andPtype:(NSInteger)type
                   andSuccessed:(Successed)success
                      andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [param setValue:ROWS forKey:@"row"];
    [param setValue:latitude forKey:@"latitude"];
    [param setValue:longitude forKey:@"longitude"];
    [param setValue:[NSString stringWithFormat:@"%d",sequence] forKey:@"order_by"];
    [param setValue:label forKey:@"prime_label_name"];
    if (type > 0 ) {
        [param setValue:[NSString stringWithFormat:@"%d",type] forKey:@"process_type"];
    }
    
    [param setValue:[UserInfoTool getCurrentAccountID] forKey:@"account"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools getDataWithUrl:@"order/helplist" andParameters:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchHelpList * searchModel = [[Model_SearchHelpList alloc]initWithString:jsonStr error:nil];
        success(searchModel);
    } failed:^(NSError *err) {
        NSLog(@"err = %@",err);
        fail(err);
    }];
    
}

///参与竞单
+(void)competeOrderWithToken:(NSString *)token
                       andID:(NSString *)ID
                     andCost:(NSString *)cost
                andSuccessed:(Successed)success
                   andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
//    [param setValue:ID forKey:@"process_recode_id"];
    [param setValue:cost forKey:@"submit_cost"];
     NSLog(@"param = %@",param);
    
    [AFNHttpTools requestWithUrl:[NSString stringWithFormat:@"permissions/order/bindprocess/%@",ID] andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_Request * requestModel = [[Model_Request alloc]initWithString:jsonStr error:nil];
        success(requestModel);
    } failed:^(NSError *err) {
        NSLog(@"err = %@",err);
        fail(err);
    }];
    
}

///抢订单
+(void)grabOrderWithToken:(NSString *)token
                    andID:(NSString *)ID
             andSuccessed:(Successed)success
                andFailed:(Failed)fail
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools requestWithUrl:[NSString stringWithFormat:@"permissions/order/receiveGRABOrder/%@",ID] andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_Request * requestModel = [[Model_Request alloc]initWithString:jsonStr error:nil];
        success(requestModel);
    } failed:^(NSError *err) {
        NSLog(@"err = %@",err);
        fail(err);
    }];
    
}



@end
