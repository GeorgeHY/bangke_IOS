//
//  Model_UserAbbr.h
//  Bangke_IOS
//
//  Created by iwind on 15/6/24.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@protocol  Model_UserAbbr <NSObject>

@end

@interface Model_UserAbbr : JSONModel

@property (nonatomic, strong) NSString<Optional> * account;//用户ID
@property (nonatomic, strong) NSString<Optional> * a_level;//等级
@property (nonatomic, strong) NSString<Optional> * head_portrait;//用户头像
@property (nonatomic, strong) NSString<Optional> * nickname;//手机用户或商家用户名户名称
@property (nonatomic, strong) NSString<Optional> * service_name;//服务口号


@end
