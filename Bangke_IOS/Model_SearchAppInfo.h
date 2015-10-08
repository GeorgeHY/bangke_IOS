//
//  Model_SearchAppInfo.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/26.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_AppInfo.h"
@interface Model_SearchAppInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) Model_AppInfo<Optional> * responseText;

@end
