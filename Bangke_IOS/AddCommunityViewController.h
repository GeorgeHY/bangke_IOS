//
//  AddCommunityViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/19.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_Community.h"
#import "Model_Search.h"
@protocol sendModel <NSObject>

-(void)sendEditCommunity:(Model_Community *)model withType:(NSInteger)type;

@end

@interface AddCommunityViewController : UIViewController <sendModel>
@property (nonatomic, assign) id<sendModel> delegate;
@property (nonatomic, strong) Model_Community * currentCommunity;//需要编辑的社区
@property (nonatomic, strong) Model_SearchCommunity * currentAddCommunity;
@property (nonatomic, assign) NSInteger type;//1编辑2增加3通过地图增加


@end
