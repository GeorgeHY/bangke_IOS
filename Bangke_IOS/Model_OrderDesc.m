//
//  Model_OrderDesc.m
//  Bangke_IOS
//
//  Created by iwind on 15/6/24.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Model_OrderDesc.h"

@implementation Model_OrderDesc

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"descrip"
                                                       }];
}

@end
