//
//  Model_Bill.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  Model_Bill <NSObject>


@end

@interface Model_Bill : JSONModel

@property (nonatomic, strong) NSString<Optional> * id;//主键
@property (nonatomic, strong) NSString<Optional> * from_account;//花钱方帮客ID
@property (nonatomic, strong) NSString<Optional> * to_account;//挣钱方帮客ID
@property (nonatomic, strong) NSString<Optional> * money;//金额
@property (nonatomic, strong) NSString<Optional> * process_recode_id;//订单ID
@property (nonatomic, strong) NSString<Optional> * descrip;//描述
@property (nonatomic, strong) NSString<Optional> * create_time;//创建时间
@property (nonatomic, strong) NSString<Optional> * type;//交易类型
@property (nonatomic, strong) NSString<Optional> * inOrOut;//支入支出类型1收入2支出
@property (nonatomic, strong) NSString<Optional> * service_money;//服务金额
@property (nonatomic, strong) NSString<Optional> * ext1;//扩展字段1
@property (nonatomic, strong) NSString<Optional> * ext2;//扩展字段2
@property (nonatomic, strong) NSString<Optional> * flag;//交易归属人标记
@property (nonatomic, strong) NSString<Optional> * from_accountHead;
@property (nonatomic, strong) NSString<Optional> * to_accountHead;
@property (nonatomic, strong) NSString<Optional> * transaction_status;
@property (nonatomic, strong) NSString<Optional> * poundage;//手续费




@end
