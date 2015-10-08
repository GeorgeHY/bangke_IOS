//
//  Model_NameAuth.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/26.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"

@interface Model_NameAuth : JSONModel

@property (nonatomic, strong) NSString<Optional> * id;
@property (nonatomic, strong) NSString<Optional> * real_name;
@property (nonatomic, strong) NSString<Optional> * card;
@property (nonatomic, strong) NSString<Optional> * card_forwad;
@property (nonatomic, strong) NSString<Optional> * card_back;


@end
