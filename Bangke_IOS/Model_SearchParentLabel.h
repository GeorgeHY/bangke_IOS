//
//  Model_SearchParentLabel.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_ParentLabel.h"

@interface Model_SearchParentLabel : JSONModel

@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSArray<Model_ParentLabel> * responseText;


@end
