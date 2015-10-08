//
//  Model_Community.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/5.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Model_Community <NSObject>

@end

@interface Model_Community : JSONModel
@property (nonatomic, strong) NSString<Optional> * id;//主键ID
@property (nonatomic, strong) NSString<Optional> * area_name;//地区名称
@property (nonatomic, strong) NSString<Optional> * phone;//电话
@property (nonatomic, strong) NSString<Optional> * receive_address;//接收地址
@property (nonatomic, strong) NSString<Optional> * longitude;//纬度
@property (nonatomic, strong) NSString<Optional> * latitude;//经度
@property (nonatomic, strong) NSString<Optional> * area_id;//地区ID
@property (nonatomic, strong) NSString<Optional> * default_select;//是否选择
@property (nonatomic, strong) NSString<Optional> * community_id;//社区ID
@property (nonatomic, strong) NSString<Optional> * community_name;//社区名称
@property (nonatomic, strong) NSString<Optional> * city_id;//城市ID
@property (nonatomic, strong) NSString<Optional> * city_name;//城市名称
@property (nonatomic, strong) NSString<Optional> * account;//帮客ID
@property (nonatomic, strong) NSString<Optional> * contact_name;//联系人
@property (nonatomic, strong) NSString<Optional> * lbs_address;//地址












@end
