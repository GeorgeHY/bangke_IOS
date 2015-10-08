//
//  Model_SearchMerchantInfo.h
//  Bangke_IOS
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_MerchantData.h"
@interface Model_SearchMerchantInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) Model_MerchantData<Optional> * responseText;

@end
