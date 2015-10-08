//
//  OrderDetail_AViewController.h
//  Bangke_IOS
//
//  Created by 韩扬 on 15/9/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_ReviewOrderData.h"


@interface OrderDetail_AViewController : UIViewController

@property (nonatomic, strong) Model_ReviewOrderData * curModel;
@property (nonatomic, strong) NSString * curID;//当前订单Id

@end
