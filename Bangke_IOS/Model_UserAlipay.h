//
//  Model_UserAlipay.h
//  Bangke_IOS
//
//  Created by admin on 15/8/20.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@interface Model_UserAlipay : JSONModel

@property (nonatomic, strong) NSString<Optional> * alipay_account;
@property (nonatomic, strong) NSString<Optional> * alipay_username;
@property (nonatomic, strong) NSString<Optional> * user_account;

@end
