//
//  Model_SearchNameAuth.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/26.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_NameAuth.h"
@interface Model_SearchNameAuth : JSONModel

@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) Model_NameAuth<Optional> * responseText;


@end
