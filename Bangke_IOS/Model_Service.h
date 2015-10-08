//
//  Model_Service.h
//  Bangke_IOS
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@protocol Model_Service <NSObject>

@end

@interface Model_Service : JSONModel

@property (nonatomic, strong) NSString<Optional> * id;
@property (nonatomic, strong) NSString<Optional> * service_money;
@property (nonatomic, strong) NSString<Optional> * service_name;
@property (nonatomic, strong) NSString<Optional> * service_time;
@property (nonatomic, strong) NSString<Optional> * display;
@property (nonatomic, strong) NSString<Optional> * ext1;
@property (nonatomic, strong) NSString<Optional> * ext2;
@property (nonatomic, strong) NSString<Optional> * ext3;
@property (nonatomic, strong) NSString<Optional> * account;


@end
