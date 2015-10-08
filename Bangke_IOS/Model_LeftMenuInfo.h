//
//  Model_LeftMenuInfo.h
//  Bangke_IOS
//
//  Created by iwind on 15/7/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@interface Model_LeftMenuInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> * certification;//是否认证1-否2-是
@property (nonatomic, strong) NSString<Optional> * nickname;//昵称
@property (nonatomic, strong) NSString<Optional> * head_portrait;//头像url
@property (nonatomic, strong) NSString<Optional> * count;//好评数

@end
