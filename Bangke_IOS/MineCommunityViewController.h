//
//  MineCommunityViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/5.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_Community.h"

typedef void(^CallBackCommunityModel) (Model_Community * model) ;

@interface MineCommunityViewController : UIViewController

@property (nonatomic, assign)NSInteger source;//1我的社区//2发单选择地址
@property (nonatomic, strong) Model_Community * currentModel;
@property (nonatomic, copy) CallBackCommunityModel decideCommunity;

- (void)returnCommunityModel:(CallBackCommunityModel)model;

@end
