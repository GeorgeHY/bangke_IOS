//
//  Model_SelectTag.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/14.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_SelectTag : NSObject
@property (nonatomic, strong) NSString<Optional> * imgUrl;//图片地址
@property (nonatomic, strong) NSString<Optional> * name;//名字
@property (nonatomic, strong) NSString<Optional> * priority;//优先级
@property (nonatomic, strong) NSString<Optional> * create_time;//创建时间
@property (nonatomic, readwrite) NSString<Optional> * descrip;//备注
@property (nonatomic, strong) NSString<Optional> * bond;//是否需要保证金
@property (nonatomic, strong) NSString<Optional> * tagID;//id值
@end
