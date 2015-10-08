//
//  Model_SearchCommunity.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/21.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Model_SearchCommunity.h"

@implementation Model_SearchCommunity
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"descrip"
                                                       }];
}

@end
