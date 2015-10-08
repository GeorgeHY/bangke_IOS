//
//  Model_SearchInvite.h
//  Bangke_IOS
//
//  Created by iwind on 15/7/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_InviteUser.h"
@interface Model_SearchInvite : JSONModel

@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSArray<Model_InviteUser> * responseText;

@end
