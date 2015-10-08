//
//  SortViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/6/29.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "SortViewController.h"
#import "WebViewJavascriptBridge.h"
#import "QuickOrderViewController.h"
@interface SortViewController() <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) WebViewJavascriptBridge * bridge;

@end


@implementation SortViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    
    QuickOrderViewController * quickOrderVC = [[QuickOrderViewController alloc]init];
    UINavigationController * navi1 = [[UINavigationController alloc]initWithRootViewController:quickOrderVC];
    
    [_bridge registerHandler:@"rankCallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"serviceIdCallBack called: %@", data);
        NSDictionary * dict = data;
        NSLog(@"dict = %@",dict);
        NSString * param = [dict objectForKey:@"param"];
        quickOrderVC.source = weakSelf.source;
        quickOrderVC.serviceID = param;
        [self presentViewController:navi1 animated:YES completion:nil];
        responseCallback(@"回传数据");
    }];
    
        
    NSString * requestStr = nil;
    if (self.source == 1) {
        requestStr = [NSString stringWithFormat:@"%@sortchild.jsp?param=%@",URL_BASE_H5,self.labelID];
    }else{
        requestStr = [NSString stringWithFormat:@"%@helpingsortchild.jsp?param=%@",URL_BASE_H5,self.labelID];
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

