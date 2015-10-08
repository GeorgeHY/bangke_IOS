//
//  Model_Order.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Model_Order <NSObject>

@end


@interface Model_Order : JSONModel

@property (nonatomic, strong) NSString<Optional> * id;//流程ID
@property (nonatomic, strong) NSString<Optional> * descrip;//订单描述
@property (nonatomic, strong) NSString<Optional> * ptype;//订单类型
@property (nonatomic, strong) NSString<Optional> * current_state;//流程当前状态
@property (nonatomic, strong) NSString<Optional> * phone;//电话
@property (nonatomic, strong) NSString<Optional> * contact_name;//联系人
@property (nonatomic, strong) NSString<Optional> * receive_address;//收获地址
@property (nonatomic, strong) NSString<Optional> * end_time;//结束时间
@property (nonatomic, strong) NSString<Optional> * lable_id;//标签ID
@property (nonatomic, strong) NSString<Optional> * type;//
@property (nonatomic, strong) NSString<Optional> * resource;
@property (nonatomic, strong) NSArray<Optional> * images;//图片路径
@property (nonatomic, strong) NSArray<Optional> * vioces;//声音路径
@property (nonatomic, strong) NSString<Optional> * price;
@property (nonatomic, strong) NSString<Optional> * evaluate_state;
@property (nonatomic, strong) NSString<Optional> * create_time;

@end
