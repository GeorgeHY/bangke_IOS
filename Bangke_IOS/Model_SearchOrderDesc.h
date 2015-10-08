//
//  Model_SearchOrderDesc.h
//  Bangke_IOS
//
//  Created by iwind on 15/6/24.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_OrderDesc.h"

@interface Model_SearchOrderDesc : JSONModel

@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) Model_OrderDesc<Optional> * responseText;

@end
