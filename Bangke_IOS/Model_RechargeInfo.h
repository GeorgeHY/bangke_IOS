//
//  Model_RechargeInfo.h
//  Bangke_IOS
//
//  Created by admin on 15/8/20.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@interface Model_RechargeInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> * create_time;
@property (nonatomic, strong) NSString<Optional> * descrip;
@property (nonatomic, strong) NSString<Optional> * from_account;
@property (nonatomic, strong) NSString<Optional> * money;
@property (nonatomic, strong) NSString<Optional> * process_recode_id;
@property (nonatomic, strong) NSString<Optional> * to_account;
@property (nonatomic, strong) NSString<Optional> * transaction_status;
@property (nonatomic, strong) NSString<Optional> * url;
@property (nonatomic, strong) NSString<Optional> * resultTpye;




@end
