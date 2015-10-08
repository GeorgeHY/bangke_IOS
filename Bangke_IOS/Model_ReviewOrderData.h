//
//  Model_ReviewOrderData.h
//  Bangke_IOS
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_accountID.h"
#import "Model_LabelInfo.h"
#import "Model_Image.h"
#import "Model_OrderDesc.h"
#import "Model_User.h"
@interface Model_ReviewOrderData : JSONModel
@property (nonatomic, strong) Model_accountID<Optional> * accountID;
@property (nonatomic, strong) NSArray<Model_LabelInfo> * labelInfos;
@property (nonatomic, strong) NSArray<Model_Image> * orderImags;
@property (nonatomic, strong) NSArray<Model_OrderDesc> * orderInfo;
@property (nonatomic, strong) Model_User<Optional> * helpUser;
@property (nonatomic, strong) Model_User<Optional> * plaseHelpUser;
@property (nonatomic, strong) NSString<Optional> * is_take_part;//0是没参与过


@end
