//
//  Model_Compete.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_Compete : NSObject

@property (nonatomic, copy) NSString * imgUrl;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * level;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, assign) BOOL isFriend;
@property (nonatomic, copy) NSString * type;

@end
