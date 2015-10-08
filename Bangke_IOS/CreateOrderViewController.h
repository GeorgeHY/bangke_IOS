//
//  CreateOrderViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_PayCallBack.h"
#import "Model_Community.h"
#import "Model_TypeCallBack.h"
#import "Model_ContentCallBack.h"

@interface CreateOrderViewController : UIViewController

//订单当前选项
@property (nonatomic, strong) Model_PayCallBack * currentPayModel;
@property (nonatomic, strong) Model_Community * currentCommunity;
@property (nonatomic, strong) Model_TypeCallBack * currentTypeModel;
@property (nonatomic, strong) Model_ContentCallBack * currentContentModel;
@property (nonatomic, strong) NSString * currentLblID;
@property (nonatomic, strong) NSString * currentLblName;

@property (nonatomic, assign) NSInteger source;//1发单2页面

@end
