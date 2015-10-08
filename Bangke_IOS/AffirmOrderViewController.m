//
//  AffirmOrderViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/16.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "AffirmOrderViewController.h"
#import "Model_SearchOrderDesc.h"

@interface AffirmOrderViewController ()
@property (nonatomic, strong) UILabel * lbl1;
@property (nonatomic, strong) UILabel * orderCode;
@property (nonatomic, strong) UILabel * submitTime;
@property (nonatomic, strong) UILabel * finishTime;
@property (nonatomic, strong) UILabel * orderContent;
@property (nonatomic, strong) UILabel * payTypeLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * phoneNum;
@property (nonatomic, strong) UILabel * orderTitle;
@property (nonatomic, strong) UIImageView * typeIV;
@end

@implementation AffirmOrderViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
//    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
//    [leftItem setTintColor:[UIColor whiteColor]];
//    self.navigationItem.leftBarButtonItem = leftItem;
    //    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(selectTagAction)];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"求帮";
    
    WEAK_SELF(weakSelf);
    
    //topView
    UIImageView * topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight * 0.3)];
    topView.image = [UIImage imageNamed:@"完成"];
    [self.view addSubview:topView];
    self.lbl1 = [UILabel new];
    [topView addSubview:self.lbl1];
    [self.lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).with.offset(10);
        make.right.mas_equalTo(topView.mas_right).with.offset(-10);
        make.bottom.mas_equalTo(topView.mas_bottom).with.offset(-10);
        make.height.equalTo(@20);
    }];
    self.lbl1.text = @"提交失败";
    self.lbl1.textColor = [UIColor whiteColor];
    self.lbl1.textAlignment = NSTextAlignmentCenter;
    //订单编号View
    UIView * orderTimeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), kMainScreenWidth, kMainScreenHeight * 0.15)];
    [self.view addSubview: orderTimeView];
//    orderTimeView.backgroundColor = [UIColor lightGrayColor];
    self.orderCode = [UILabel new];
    [orderTimeView addSubview:self.orderCode];
    [self.orderCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderTimeView.mas_left).with.offset(20);
        make.top.mas_equalTo(orderTimeView.mas_top).with.offset(10);
        make.right.mas_equalTo(orderTimeView.mas_right).with.offset(-20);
        make.height.equalTo(@15);
    }];
    self.orderCode.text = @"订单编号:100030019";
    
    self.submitTime = [UILabel new];
    [orderTimeView addSubview:self.submitTime];
    [self.submitTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderTimeView.mas_left).with.offset(20);
        make.top.mas_equalTo(weakSelf.orderCode.mas_bottom).with.offset(10);
        make.right.mas_equalTo(orderTimeView.mas_right).with.offset(-20);
        make.height.equalTo(@15);
    }];
    self.submitTime.text = @"提交时间";
    
    self.finishTime = [UILabel new];
    [orderTimeView addSubview:self.finishTime];
    [self.finishTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderTimeView.mas_left).with.offset(20);
        make.top.mas_equalTo(weakSelf.submitTime.mas_bottom).with.offset(10);
        make.right.mas_equalTo(orderTimeView.mas_right).with.offset(-20);
        make.height.equalTo(@15);
    }];
    self.finishTime.text = @"截止时间";
    //orderView
    UIView * orderView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(orderTimeView.frame), kMainScreenWidth, kMainScreenHeight*0.2)];
    [self.view addSubview:orderView];
//    orderView.backgroundColor = [UIColor yellowColor];
    
    self.typeIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 15, 15)];
    self.typeIV.image = [UIImage imageNamed:@"邀"];
    [orderView addSubview:self.typeIV];
    
    self.orderTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.typeIV.frame) + 10, 10, kMainScreenWidth - 50 - self.typeIV.frame.size.width, 20)];
    [orderView addSubview:self.orderTitle];
    self.orderTitle.text = @"美妆";
    
    self.orderContent = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.orderTitle.frame) +10, kMainScreenWidth - 50 - self.typeIV.frame.size.width, 20)];
    self.orderContent.text = @"我要买豆皮我要买豆皮我要买豆皮";
    [orderView addSubview:self.orderContent];
    
    UIImageView * iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.orderContent.frame) + 10, self.orderContent.frame.origin.y, 15, 15)];
    iv2.image = [UIImage imageNamed:@"图"];
//    [orderView addSubview:iv2];
    //单价label
    UILabel * lbl2 = [UILabel new];
    [orderView addSubview:lbl2];
    [lbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderView.mas_left).with.offset(20);
        make.top.mas_equalTo(weakSelf.orderContent.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    lbl2.text = @"单价:";
    lbl2.font = [UIFont systemFontOfSize:14];
    
    //支付方式label
    self.payTypeLabel = [UILabel new];
    [orderView addSubview:self.payTypeLabel];
    [self.payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(orderView.mas_right).with.offset(-20);
        make.top.mas_equalTo(weakSelf.orderContent.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
    self.payTypeLabel.text = @"保证金支付";
    self.payTypeLabel.font = [UIFont systemFontOfSize:14];
    self.payTypeLabel.textColor = [UIColor orangeColor];
    
    self.priceLabel = [UILabel new];
    [orderView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbl2.mas_right).with.offset(10);
        make.top.mas_equalTo(weakSelf.orderContent.mas_bottom).with.offset(15);
        make.right.mas_equalTo(weakSelf.payTypeLabel.mas_left).with.offset(10);
        make.height.equalTo(@20);
    }];
    self.priceLabel.text = @"200元";
    
    //contactView
    UIView * contactView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(orderView.frame), kMainScreenWidth, kMainScreenHeight * 0.1)];
    [self.view addSubview:contactView];
//    contactView.backgroundColor = [UIColor greenColor];
    //地址label
    self.addressLabel = [UILabel new];
    [contactView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contactView.mas_left).with.offset(20);
        make.top.mas_equalTo(contactView.mas_top).with.offset(10);
        make.right.mas_equalTo(contactView.mas_right).with.offset(-20);
        make.height.equalTo(@16);
    }];
    self.addressLabel.text = @"天津市河北区";
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    
    self.nameLabel = [UILabel new];
    [contactView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contactView.mas_left).with.offset(20);
        make.top.mas_equalTo(weakSelf.addressLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 16));
        
    }];
    self.nameLabel.text = @"祺贵人";
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    
    self.phoneNum = [UILabel new];
    [contactView addSubview:self.phoneNum];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLabel.mas_right).with.offset(10);
        make.top.mas_equalTo(weakSelf.addressLabel.mas_bottom).with.offset(10);
        make.right.mas_equalTo(contactView.mas_right).with.offset(-20);
        make.height.equalTo(@16);
    }];
    self.phoneNum.text = @"12435678901";
    self.phoneNum.font = [UIFont systemFontOfSize:14];
    
    
    
    //btnView
    UIView * btnView = [UIView new];
    [self.view addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(0);
        make.height.equalTo(@(kMainScreenHeight * 0.1));
        
    }];
//    btnView.backgroundColor = [UIColor blueColor];
    //联系商家btn
//    UIButton * contactBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth/2, kMainScreenHeight * 0.1)];
//    [contactBtn setTitle:@"联系商家" forState:UIControlStateNormal];
//    [contactBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [btnView addSubview: contactBtn];
//    contactBtn.layer.borderWidth =1;
//    contactBtn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    //确认btn
    UIButton * okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight * 0.1)];
    [okBtn setTitle:@"确认" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnView addSubview: okBtn];
    okBtn.layer.borderWidth =1;
    okBtn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
}
#pragma mark - Action
- (void)okAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Request
- (void)requestData
{
//    [AFNHttpTools requestWithUrl:@"order/desc" successed:^(NSDictionary *dict) {
//        NSLog(@"dict = %@",dict);
//    } failed:^(NSError *err) {
//        NSLog(@"err = %@",[err localizedDescription]);
//    } andKeyVaulePairs:@"id",self.orderID, nil];
    
    [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"order/desc/%@",self.orderID] andParameters:nil successed:^(NSDictionary *dict) {
        NSLog(@"dict = %@",dict);
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchOrderDesc * searchModel = [[Model_SearchOrderDesc alloc]initWithString:jsonStr error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            self.lbl1.text = @"恭喜您！您已提交成功";
            self.orderCode.text = [NSString stringWithFormat:@"订单编号:%@",searchModel.responseText.id];
            self.submitTime.text = [NSString stringWithFormat:@"提交时间:%@",searchModel.responseText.create_time];
            self.finishTime.text = [NSString stringWithFormat:@"截止时间:%@",searchModel.responseText.end_time];
            self.orderTitle.text = searchModel.responseText.name;
            self.orderContent.text = searchModel.responseText.descrip;
            if ([searchModel.responseText.bond isEqualToString:@"1"]) {
                self.payTypeLabel.text = @"货到付款";
            }else{
                self.payTypeLabel.text = @"保证金支付";
            }
            self.priceLabel.text = [NSString stringWithFormat:@"%@元",searchModel.responseText.cost_amount];
            self.addressLabel.text = searchModel.responseText.receive_address;
            self.nameLabel.text = searchModel.responseText.contact_name;
            self.phoneNum.text = searchModel.responseText.phone;
            if ([searchModel.responseText.ptype isEqualToString:@"1"]) {
                self.typeIV.image = [UIImage imageNamed:@"竞"];
            }else if([searchModel.responseText.ptype isEqualToString:@"2"]){
                self.typeIV.image = [UIImage imageNamed:@"邀"];
            }else{
                self.typeIV.image = [UIImage imageNamed:@"抢"];
            }
            
            
            
            
            
        }

    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
    }];
}


@end
