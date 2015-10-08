//
//  Model_SearchCommunity.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/21.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@protocol  Model_SearchCommunity <NSObject>

@end

@interface Model_SearchCommunity : JSONModel

@property (nonatomic, strong) NSString<Optional> * areaName;
@property (nonatomic, strong) NSString<Optional> * city_id;
@property (nonatomic, strong) NSString<Optional> * id;
@property (nonatomic, strong) NSString<Optional> * province_id;
@property (nonatomic, strong) NSString<Optional> * area_id;
@property (nonatomic, strong) NSString<Optional> * longitude;
@property (nonatomic, strong) NSString<Optional> * latitude;
@property (nonatomic, strong) NSString<Optional> * create_time;
@property (nonatomic, strong) NSString<Optional> * descrip;
@property (nonatomic, strong) NSString<Optional> * name;
@property (nonatomic, strong) NSString<Optional> * cityName;
@property (nonatomic, strong) NSString<Optional> * dis;



@end
