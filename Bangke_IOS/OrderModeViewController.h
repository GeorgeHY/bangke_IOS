//
//  OrderModeViewController.h
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/14.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_TypeCallBack.h"
typedef void (^CallBackTypeModel) (Model_TypeCallBack * model);
@interface OrderModeViewController : UIViewController

@property (nonatomic, copy) CallBackTypeModel decideType;

- (void)returnTypeModel:(CallBackTypeModel)model;

@end
