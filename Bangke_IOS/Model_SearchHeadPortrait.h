//
//  Model_SearchHeadPortrait.h
//  Bangke_IOS
//
//  Created by admin on 15/8/31.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_HeadPortrait.h"
@interface Model_SearchHeadPortrait : JSONModel
@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) Model_HeadPortrait<Optional> * responseText;
@end
