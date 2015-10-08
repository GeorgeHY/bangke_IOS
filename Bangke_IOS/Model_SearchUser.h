//
//  Model_SearchUser.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/22.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_User.h"
@interface Model_SearchUser : JSONModel

@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) Model_User<Optional> * responseText;



@end
