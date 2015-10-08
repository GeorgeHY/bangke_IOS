//
//  Model_BillData.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/22.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_Bill.h"
@interface Model_BillData : JSONModel

@property (nonatomic, strong) NSString<Optional> * total;
@property (nonatomic, strong) NSArray<Model_Bill> * rows;

@end
