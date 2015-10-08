//
//  Model_InviteUser.h
//  Bangke_IOS
//
//  Created by iwind on 15/7/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@protocol Model_InviteUser <NSObject>

@end


@interface Model_InviteUser : JSONModel

@property (nonatomic, strong) NSString<Optional> * account;
@property (nonatomic, strong) NSString<Optional> * a_level;
@property (nonatomic, strong) NSString<Optional> * b_level;
@property (nonatomic, strong) NSString<Optional> * head_portrait;
//@property (nonatomic, strong) NSString<Optional> * id;
@property (nonatomic, strong) NSString<Optional> * nickname;
@property (nonatomic, strong) NSString<Optional> * service_name;
@property (nonatomic, strong) NSString<Optional> * submit_cost;
@property (nonatomic, strong) NSString<Optional> * type;
@property (nonatomic, strong) NSString<Optional> * username;
@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * ptype;
@property (nonatomic, strong) NSString<Optional> * star;
@property (nonatomic, strong) NSString<Optional> * current_state;
@property (nonatomic, strong) NSString<Optional> * process_bidding_id;
@property (nonatomic, strong) NSString<Optional> * process_recode_id;
@property (nonatomic, strong) NSString<Optional> * create_time;


@end
