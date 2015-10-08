//
//  CheckWithdrawViewController.h
//  Bangke_IOS
//
//  Created by 韩扬 on 15/9/9.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_UserAlipay.h"

@interface CheckWithdrawViewController : UIViewController

@property (nonatomic, strong) NSString * money;//金额
@property (nonatomic, strong)Model_UserAlipay * currentAccount;//当前账户名

@end
