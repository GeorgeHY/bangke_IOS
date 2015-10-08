//
//  Model_OrderHelpList.m
//  Bangke_IOS
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import "Model_OrderHelpList.h"

@implementation Model_OrderHelpList

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"descrip"
                                                       }];
}

@end
