//
//  Model_MerchantData.h
//  Bangke_IOS
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_Image.h"
#import "Model_LabelInfo.h"
#import "Model_User.h"
#import "Model_Service.h"
@interface Model_MerchantData : JSONModel

@property (nonatomic, strong) NSArray<Optional> * imgesURLs;
@property (nonatomic, strong) NSArray<Model_LabelInfo> * labelInfos;
@property (nonatomic, strong) NSArray<Model_User> * perInfo;
@property (nonatomic, strong) NSArray<Model_Service> * services;


@end
