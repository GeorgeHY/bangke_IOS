//
//  QuickOrderViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/6/23.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "QuickOrderViewController.h"
#import "WebViewJavascriptBridge.h"
#import "Model_PayCallBack.h"
#import "Model_Community.h"
#import "Model_TypeCallBack.h"
#import "Model_ContentCallBack.h"
#import "CreateOrderViewController.h"
@interface QuickOrderViewController() <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) WebViewJavascriptBridge * bridge;

//订单当前选项
@property (nonatomic, strong) Model_PayCallBack * currentPayModel;
@property (nonatomic, strong) Model_Community * currentCommunity;
@property (nonatomic, strong) Model_ContentCallBack * currentContentModel;
@property (nonatomic, strong) NSString * currentLblID;
@property (nonatomic, strong) NSString * currentLblName;

@end

@implementation QuickOrderViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"详情";
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    NSLog(@"self.source = %d",self.source);
    [self createUI];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)createUI
{
    WEAK_SELF(weakSelf);
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    [self.view addSubview:self.webView];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"Response for message from ObjC");
    }];
    
    [_bridge registerHandler:@"orderInfoCallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"serviceIdCallBack called: %@", data);
        NSDictionary * dict = data;
        NSLog(@"dict = %@",dict);
        //金额
        weakSelf.currentPayModel = [[Model_PayCallBack alloc]init];
        NSString * cost_amount = [dict objectForKey:@"cost_amount"];
        weakSelf.currentPayModel.price = cost_amount;
        weakSelf.currentPayModel.payType = 1;
        
        //地址
//        self.currentCommunity = [[Model_Community alloc]init];
//        NSString * receive_address = [dict objectForKey:@"receive_address"];
//        NSString * phone = [dict objectForKey:@"phone"];
//        NSString * contact_name = [dict objectForKey:@"contact_name"];
//        self.currentCommunity.receive_address = receive_address;
//        self.currentCommunity.phone = phone;
//        self.currentCommunity.contact_name = contact_name;
        //内容
        weakSelf.currentContentModel = [[Model_ContentCallBack alloc]init];
        NSString * receiptName = [dict objectForKey:@"receiptName"];
        weakSelf.currentContentModel.helpContent = receiptName;
        NSString * labelID = [dict objectForKey:@"sub_label_id"];
        weakSelf.currentLblID = labelID;
        NSString * labelName = [dict objectForKey:@"sub_label_name"];
        weakSelf.currentLblName = labelName;

        
        CreateOrderViewController * createOrderVC = [[CreateOrderViewController alloc]init];
        createOrderVC.currentLblID = weakSelf.currentLblID;
        createOrderVC.currentPayModel = weakSelf.currentPayModel;
        createOrderVC.currentContentModel = weakSelf.currentContentModel;
        createOrderVC.currentLblName = weakSelf.currentLblName;
        createOrderVC.source = 2;
//        UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:createOrderVC];
        
        [weakSelf.navigationController pushViewController:createOrderVC animated:YES];
        
        
        
        
        //NSString * cid = [dict objectForKey:@"cid"];
//        NSString * serviceId = [dict objectForKey:@"id"];
        //NSString * password = [dict objectForKey:@"password"];
        //NSLog(@"%@",cid);
//        NSLog(@"%@",serviceId);
        //NSLog(@"%@",password);
//        quickOrderVC.currentToken = token;
//        quickOrderVC.serviceID = serviceId;
        
        //[weakSelf presentViewController:navi animated:YES completion:nil];
        
        
        //        responseCallback(@{@"userName": [UserInfoTool getUserName],@"password": [UserInfoTool getPWD],@"cid": [UserInfoTool getClientID]});
        responseCallback(@"回传数据");
    }];
    
    [_bridge registerHandler:@"acceptOrderCallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"serviceIdCallBack called: %@", data);
        NSDictionary * dict = data;
        NSString * state = [dict objectForKey:@"state"];
        if ([state isEqualToString:dStateSuccess]) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [weakSelf.view makeToast:@"接单失败" duration:ToastDuration position:CSToastPositionCenter];
        }
        
        
        //        responseCallback(@{@"userName": [UserInfoTool getUserName],@"password": [UserInfoTool getPWD],@"cid": [UserInfoTool getClientID]});
        responseCallback(@"回传数据");
    }];
    
    NSString * requestStr = nil;
    if (self.source == 1) {
        requestStr = [NSString stringWithFormat:@"%@receipt.jsp?access_token=%@&param=%@",URL_BASE_H5,self.currentToken,self.serviceID];
    }else{
        requestStr = [NSString stringWithFormat:@"%@helpingreceipt.jsp?access_token=%@&param=%@",URL_BASE_H5,self.currentToken,self.serviceID];
    }
    NSLog(@"requestStr%@",requestStr);
    NSURL * requestUrl = [NSURL URLWithString:requestStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:requestUrl]];
    
    
}

#pragma mark - Action
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
