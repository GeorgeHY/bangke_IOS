//
//  Model_OrderHelpList.h
//  Bangke_IOS
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_LabelInfo.h"

@protocol Model_OrderHelpList <NSObject>


@end

@interface Model_OrderHelpList : JSONModel

@property (nonatomic, strong) NSString<Optional> * a_integral;
@property (nonatomic, strong) NSString<Optional> * a_level;
@property (nonatomic, strong) NSString<Optional> * account;
@property (nonatomic, strong) NSString<Optional> * b_integral;
@property (nonatomic, strong) NSString<Optional> * b_level;
@property (nonatomic, strong) NSString<Optional> * cost_amount;
@property (nonatomic, strong) NSString<Optional> * descrip;
@property (nonatomic, strong) NSString<Optional> * dis;
@property (nonatomic, strong) NSString<Optional> * head_portrait;
@property (nonatomic, strong) NSString<Optional> * headImgUrl;
@property (nonatomic, strong) NSString<Optional> * high_cost;
@property (nonatomic, strong) NSString<Optional> * imag_url;
@property (nonatomic, strong) NSString<Optional> * imgUrl;
@property (nonatomic, strong) NSString<Optional> * latitude;
@property (nonatomic, strong) NSString<Optional> * longitude;
@property (nonatomic, strong) NSString<Optional> * low_cost;
@property (nonatomic, strong) NSString<Optional> * nickname;
@property (nonatomic, strong) NSString<Optional> * order_by;
@property (nonatomic, strong) NSString<Optional> * order_by_type;
@property (nonatomic, strong) NSString<Optional> * page;
@property (nonatomic, strong) NSString<Optional> * prime_label_name;
@property (nonatomic, strong) NSString<Optional> * process_recode_id;
@property (nonatomic, strong) NSString<Optional> * process_type;
@property (nonatomic, strong) NSString<Optional> * row;
@property (nonatomic, strong) NSString<Optional> * subsequent_label_name;
@property (nonatomic, strong) NSArray<Model_LabelInfo> * labels;

@end
