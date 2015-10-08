//
//  Model_SearchHelpList.h
//  Bangke_IOS
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import "JSONModel.h"
#import "Model_OrderHelpList.h"
@interface Model_SearchHelpList : JSONModel
@property (nonatomic, strong) NSString<Optional> * message;
@property (nonatomic, strong) NSString<Optional> * state;
@property (nonatomic, strong) NSArray<Model_OrderHelpList> * responseText;

@end
