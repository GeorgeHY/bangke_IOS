//
//  Model_SearchAccount.h
//  Bangke_IOS
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_InviteUser.h"
@interface Model_SearchAccount : JSONModel

@property (nonatomic ,strong)NSString<Optional> * state;
@property (nonatomic ,strong)NSString<Optional> * message;
@property (nonatomic ,strong)Model_InviteUser<Optional> * responseText;

@end
