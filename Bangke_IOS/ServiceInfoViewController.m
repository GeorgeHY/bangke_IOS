//
//  ServiceInfoViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/7/3.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "ServiceInfoViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ServiceInfoViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) WebViewJavascriptBridge * bridge;

@end

@implementation ServiceInfoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"服务详情";
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
    WEAK_SELF(weakSelf);
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    [self.view addSubview:self.webView];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"Response for message from ObjC");
    }];
    
    //    QuickOrderViewController * quickOrderVC = [[QuickOrderViewController alloc]init];
    //    UINavigationController * navi1 = [[UINavigationController alloc]initWithRootViewController:quickOrderVC];
    
    //    [_bridge registerHandler:@"rankCallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
    //        NSLog(@"serviceIdCallBack called: %@", data);
    //        NSDictionary * dict = data;
    //        NSLog(@"dict = %@",dict);
    //        NSString * param = [dict objectForKey:@"param"];
    //        quickOrderVC.source = weakSelf.source;
    //        quickOrderVC.serviceID = param;
    //        [self presentViewController:navi1 animated:YES completion:nil];
    //        responseCallback(@"回传数据");
    //    }];
    
    
    
    NSString *  requestStr = [NSString stringWithFormat:@"%@serviceinformation.jsp?access_token=%@&param=%@",URL_BASE_H5,[UserInfoTool getToken],self.param];
//    NSString *  requestStr = [NSString stringWithFormat:@"%@serviceinformation.jsp?access_token=%@",URL_BASE_H5,[UserInfoTool getToken]];
    
    NSLog(@"requestStr = %@",requestStr);
    NSURL * requestUrl = [NSURL URLWithString:requestStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:requestUrl]];
    
    
}
#pragma mark - Action
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
