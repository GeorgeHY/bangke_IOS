//
//  Model_Search.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/21.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_SearchCommunity.h"

@interface Model_Search : JSONModel

@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSArray<Model_SearchCommunity> * responseText;


@end
