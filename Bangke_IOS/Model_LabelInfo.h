//
//  Model_LabelInfo.h
//  Bangke_IOS
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@protocol Model_LabelInfo <NSObject>

@end

@interface Model_LabelInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> * pri_label_id;//父标签ID
@property (nonatomic, strong) NSString<Optional> * prime_label_name;//父标签名字
@property (nonatomic, strong) NSString<Optional> * sub_label_id;//子标签ID
@property (nonatomic, strong) NSString<Optional> * subsequent_label_name;//子标签名字

@end
