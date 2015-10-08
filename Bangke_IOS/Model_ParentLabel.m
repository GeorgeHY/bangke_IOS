//
//  Model_ParentLabel.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Model_ParentLabel.h"

@implementation Model_ParentLabel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"descrip"
                                                       }];
}


@end
