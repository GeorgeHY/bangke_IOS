//
//  Model_Money.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/22.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@interface Model_Money : JSONModel

@property (nonatomic, strong) NSString<Optional> * available_balance;
@property (nonatomic, strong) NSString<Optional> * lock_money;
@property (nonatomic, strong) NSString<Optional> * withdrawing;
@property (nonatomic, strong) NSString<Optional> * money;

@end
