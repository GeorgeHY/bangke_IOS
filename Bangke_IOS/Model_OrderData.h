//
//  Model_OrderData.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/22.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_OrderDesc.h"
@interface Model_OrderData : JSONModel

@property (nonatomic, strong) NSString * total;
@property (nonatomic, strong) NSArray<Model_OrderDesc> * rows;

@end
