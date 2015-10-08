//
//  Model_ParentLabel.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@protocol Model_ParentLabel <NSObject>

@end

@interface Model_ParentLabel : JSONModel

@property (nonatomic, strong) NSString<Optional> * id;
@property (nonatomic, strong) NSString<Optional> * name;//标签名称
@property (nonatomic, strong) NSString<Optional> * descrip;//备注
@property (nonatomic, strong) NSString<Optional> * bond;//是否需要保证金
@property (nonatomic, strong) NSString<Optional> * create_time;//创建时间
@property (nonatomic, strong) NSString<Optional> * parent_Id;//父标签ID
@property (nonatomic, strong) NSString<Optional> * priority;//优先级
@property (nonatomic, strong) NSString<Optional> * imag_url;//标签图片下载路径
@property (nonatomic, strong) NSString<Optional> * parentName;//父标签名称
@property (nonatomic, strong) NSString<Optional> * parentids;
@property (nonatomic, strong) NSString<Optional> * childcount;//子标签数

@end
