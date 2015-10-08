//
//  Cell_Order.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_OrderDesc.h"
#import "OrderViewController.h"
@interface Cell_Order : UITableViewCell
@property (nonatomic, strong) OrderViewController * delegate;
@property (nonatomic, strong) Model_OrderDesc * model;

@property (nonatomic, strong) UIButton * btn1;//联系买家
@property (nonatomic, strong) UIButton * btn2;//查看详情
@property (nonatomic, strong) UIButton * btn3;//确认发货

@end
