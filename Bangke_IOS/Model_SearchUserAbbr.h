//
//  Model_SearchUserAbbr.h
//  Bangke_IOS
//
//  Created by iwind on 15/6/24.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_UserAbbr.h"
@interface Model_SearchUserAbbr : JSONModel

@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSArray<Model_UserAbbr> * responseText;

@end
