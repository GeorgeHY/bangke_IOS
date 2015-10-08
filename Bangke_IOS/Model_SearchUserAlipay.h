//
//  Model_SearchUserAlipay.h
//  Bangke_IOS
//
//  Created by admin on 15/8/20.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_UserAlipay.h"
@interface Model_SearchUserAlipay : JSONModel

@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) Model_UserAlipay<Optional> * responseText;

@end
