//
//  Model_SearchChildLabel.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_ChildLabel.h"
@interface Model_SearchChildLabel : JSONModel

@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSArray<Model_ChildLabel> * responseText;


@end
