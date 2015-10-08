//
//  Model_Image.h
//  Bangke_IOS
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@protocol Model_Image <NSObject>

@end

@interface Model_Image : JSONModel

@property (nonatomic, strong) NSString<Optional> * resource;
@property (nonatomic, strong) NSString<Optional> * type;

@end
