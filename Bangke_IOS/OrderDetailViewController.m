//
//  OrderDetailViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/7/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "WebViewJavascriptBridge.h"
#import "ServiceInfoViewController.h"

@interface OrderDetailViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) WebViewJavascriptBridge * bridge;

@property (nonatomic, strong) UILabel * parentLabel;
@property (nonatomic, strong) UILabel * childLabel;

@end

@implementation OrderDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.title = @"订单详情";
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    //NSLog(@"self.source = %d",self.source);
    [self createUI];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
}
- (void)createUI
{

    
    
//    WEAK_SELF(weakSelf);
//    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
//    [self.view addSubview:self.webView];
//    
//    [WebViewJavascriptBridge enableLogging];
//    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"ObjC received message from JS: %@", data);
//        responseCallback(@"Response for message from ObjC");
//    }];
//    
//    
//    ServiceInfoViewController * serviceInfoVC = [[ServiceInfoViewController alloc]init];
////    QuickOrderViewController * quickOrderVC = [[QuickOrderViewController alloc]init];
////    UINavigationController * navi1 = [[UINavigationController alloc]initWithRootViewController:quickOrderVC];
//    
//    [_bridge registerHandler:@"serviceInfoCallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"serviceIdCallBack called: %@", data);
//        NSDictionary * dict = data;
//        NSString * param = [dict objectForKey:@"param"];
//        serviceInfoVC.param = param;
//        [self.navigationController pushViewController:serviceInfoVC animated:YES];
////        NSLog(@"dict = %@",dict);
////        NSString * param = [dict objectForKey:@"param"];
////        quickOrderVC.source = weakSelf.source;
////        quickOrderVC.serviceID = param;
////        [self presentViewController:navi1 animated:YES completion:nil];
//        responseCallback(@"回传数据");
//    }];
//    
//    
//    
//    NSString *  requestStr = [NSString stringWithFormat:@"%@orderdetail.jsp?access_token=%@&param=%@",URL_BASE_H5,[UserInfoTool getToken],self.orderID];
//    
//    NSLog(@"requestStr = %@",requestStr);
//    NSURL * requestUrl = [NSURL URLWithString:requestStr];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:requestUrl]];
    
    
}
#pragma mark - Action
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
