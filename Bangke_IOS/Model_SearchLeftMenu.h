//
//  Model_SearchLeftMenu.h
//  Bangke_IOS
//
//  Created by iwind on 15/7/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_LeftMenuInfo.h"

@interface Model_SearchLeftMenu : JSONModel
@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) Model_LeftMenuInfo<Optional> * responseText;
@end
