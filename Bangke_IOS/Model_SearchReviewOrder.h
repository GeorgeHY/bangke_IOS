//
//  Model_SearchReviewOrder.h
//  Bangke_IOS
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_ReviewOrderData.h"

@interface Model_SearchReviewOrder : JSONModel

@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) Model_ReviewOrderData<Optional> * responseText;

@end
