//
//  PayTypeViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_PayCallBack.h"

typedef void (^CallBackPayModel) (Model_PayCallBack * model);

@interface PayTypeViewController : UIViewController
@property (nonatomic, strong) Model_PayCallBack * currentModel;
@property (nonatomic, copy) CallBackPayModel decidePay;

- (void) returnPayModel:(CallBackPayModel)model;

@end
