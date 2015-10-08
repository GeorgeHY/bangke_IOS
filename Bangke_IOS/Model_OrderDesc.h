//
//  Model_OrderDesc.h
//  Bangke_IOS
//
//  Created by iwind on 15/6/24.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@protocol Model_OrderDesc <NSObject>


@end

@interface Model_OrderDesc : JSONModel

@property (nonatomic, strong) NSString<Optional> * id;//订单ID
@property (nonatomic, strong) NSString<Optional> * descrip;//订单描述
@property (nonatomic, strong) NSString<Optional> * bond;//是否使用保证金
@property (nonatomic, strong) NSString<Optional> * phone;//联系人电话
@property (nonatomic, strong) NSString<Optional> * cost_amount;//费用
@property (nonatomic, strong) NSString<Optional> * makeing;//是否预约
@property (nonatomic, strong) NSString<Optional> * receive_address;//收货地址
@property (nonatomic, strong) NSString<Optional> * level;//安全等级
@property (nonatomic, strong) NSString<Optional> * end_time;//结束时间
@property (nonatomic, strong) NSString<Optional> * create_time;//订单生成时间
@property (nonatomic, strong) NSString<Optional> * contact_name;//收货人姓名
@property (nonatomic, strong) NSString<Optional> * complaint;
@property (nonatomic, strong) NSString<Optional> * credit_level;
@property (nonatomic, strong) NSString<Optional> * current_state;
@property (nonatomic, strong) NSString<Optional> * distribution;
@property (nonatomic, strong) NSString<Optional> * evaluate;
@property (nonatomic, strong) NSString<Optional> * evaluate_state;
@property (nonatomic, strong) NSString<Optional> * latitude;
@property (nonatomic, strong) NSString<Optional> * longitude;
@property (nonatomic, strong) NSString<Optional> * make_time;
@property (nonatomic, strong) NSString<Optional> * makesure_time;
@property (nonatomic, strong) NSString<Optional> * pleaseHelpAccount;
@property (nonatomic, strong) NSString<Optional> * ptype;
@property (nonatomic, strong) NSString<Optional> * result;
@property (nonatomic, strong) NSString<Optional> * name;
@property (nonatomic, strong) NSString<Optional> * price;
@property (nonatomic, strong) NSArray<Optional> * voices;//音频文件
@property (nonatomic, strong) NSArray<Optional> * images;//订单图片
@property (nonatomic, strong) NSArray<Optional> * processHistorys;//订单状态变化记录




@end
