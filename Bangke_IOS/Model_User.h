//
//  Model_User.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/22.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@protocol Model_User <NSObject>


@end

@interface Model_User : JSONModel
@property (nonatomic, strong) NSString<Optional> * account;//帮客ID
@property (nonatomic, strong) NSString<Optional> * nickname;//昵称
@property (nonatomic, strong) NSString<Optional> * sex;//性别
@property (nonatomic, strong) NSString<Optional> * age;//年龄
@property (nonatomic, strong) NSString<Optional> * introduction;//自我介绍
@property (nonatomic, strong) NSString<Optional> * certification;//是否认证
@property (nonatomic, strong) NSString<Optional> * help_num_count;//帮助交易量
@property (nonatomic, strong) NSString<Optional> * help_evaluate_count;//帮助好评数
@property (nonatomic, strong) NSString<Optional> * qb_num_count;//被帮助交易量
@property (nonatomic, strong) NSString<Optional> * qb_evaluate_count;//被帮助好评数
@property (nonatomic, strong) NSString<Optional> * a_level;//求帮等级
@property (nonatomic, strong) NSString<Optional> * b_level;//帮助等级
@property (nonatomic, strong) NSString<Optional> * lable_names;//标签名称
@property (nonatomic, strong) NSString<Optional> * lable_ids;//标签ID
@property (nonatomic, strong) NSArray<Optional> * images;//自我介绍图片
@property (nonatomic, strong) NSString<Optional> * appUserAccount;
@property (nonatomic, strong) NSString<Optional> * a_integral;
@property (nonatomic, strong) NSString<Optional> * b_integral;
@property (nonatomic, strong) NSString<Optional> * create_time;
@property (nonatomic, strong) NSString<Optional> * dc;
@property (nonatomic, strong) NSString<Optional> * frozen;
@property (nonatomic, strong) NSString<Optional> * head_portrait;
@property (nonatomic, strong) NSString<Optional> * push_range;
@property (nonatomic, strong) NSString<Optional> * service_name;
@property (nonatomic, strong) NSString<Optional> * star;
@property (nonatomic, strong) NSString<Optional> * vendor_name;
@property (nonatomic, strong) NSString<Optional> * hot_service;
@property (nonatomic, strong) NSString<Optional> * popularity_service;
@property (nonatomic, strong) NSString<Optional> * money_start;
@property (nonatomic, strong) NSString<Optional> * money_end;
@property (nonatomic, strong) NSString<Optional> * adress;
@property (nonatomic, strong) NSString<Optional> * substation;
@property (nonatomic, strong) NSString<Optional> * hot_order;
@property (nonatomic, strong) NSString<Optional> * popularity_order;
@property (nonatomic, strong) NSString<Optional> * evaluate;
@property (nonatomic, strong) NSString<Optional> * phone;





@end
