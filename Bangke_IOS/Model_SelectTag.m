//
//  Model_SelectTag.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/14.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Model_SelectTag.h"

@implementation Model_SelectTag

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"descrip"
                                                       }];
}
@end
