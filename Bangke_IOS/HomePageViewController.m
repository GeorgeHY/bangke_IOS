//
//  HomePageViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/4/29.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#define HBTNTAG 207
#define TVTAG 306

#import "HomePageViewController.h"
#import "HMSegmentedControl.h"
#import "MapViewController.h"
#import "MineFundViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "LoginViewController.h"
#import "CreateOrderViewController.h"
#import "UserInfoTool.h"
#import "DVSwitch.h"
#import "MJRefresh.h"
#import "WebViewJavascriptBridge.h"
#import "QuickOrderViewController.h"
#import "SortViewController.h"
#import "HomeBtn.h"
#import "Model_SearchParentLabel.h"
#import "Model_SearchHelpList.h"
#import <MAMapKit/MAMapKit.h>
#import "Cell_Helplist.h"
#import "OrderDetail_AViewController.h"


#define APIKey @"73bd80e73ca442d415160c47e789fd37"
 

@interface HomePageViewController () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,MAMapViewDelegate>

@property (nonatomic, assign) NSInteger currentSegIndex;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) HMSegmentedControl * segmentedControl1;
@property (nonatomic, strong) HMSegmentedControl * segmentedControl2;
@property (nonatomic, strong) UIView * view1;
@property (nonatomic, strong) UIView * view2;
@property (nonatomic, strong) UIView * view3;
@property (nonatomic, strong) UISegmentedControl * segControl;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) UIButton * leftBtnItem;
@property (nonatomic, strong) UIViewController * leftVC;
@property (nonatomic, strong) UINavigationBar * naviBar;
@property (nonatomic, strong) DVSwitch * switcher;
@property (nonatomic, strong) UIView * mainView;
@property (nonatomic, strong) UIView * firstView;//我要求帮
@property (nonatomic, strong) UIView * secondView;//我要去帮
@property (nonatomic, strong) NSString * currentUrl;//当前地址
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) UIButton * recommendBtn;//推荐按钮
@property (nonatomic, strong) UIButton * arrangeBtn;//排行按钮
@property (nonatomic, strong) UIButton * classifyBtn;//分类按钮
@property (nonatomic, strong) UIWebView * mainWebView1;
@property (nonatomic, strong) UIWebView * mainWebView2;

@property (nonatomic, strong) WebViewJavascriptBridge * bridge1;
@property (nonatomic, strong) WebViewJavascriptBridge * bridge2;


@property (nonatomic, strong) UITableView * ptypeList;
@property (nonatomic, strong) UITableView * disList;
@property (nonatomic, strong) UITableView * labelList;
@property (nonatomic, strong) HomeBtn * btn1;
@property (nonatomic, strong) HomeBtn * btn2;
@property (nonatomic, strong) HomeBtn * btn3;

@property (nonatomic, strong) NSArray * ptypeArr;
@property (nonatomic, strong) NSArray * disArr;
@property (nonatomic, strong) NSMutableArray * labelArr;
@property (nonatomic, strong) NSMutableArray * labelModelArr;

@property (nonatomic, strong) UITableView * dataTV;
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, assign) NSInteger curPtype;
@property (nonatomic, assign) NSInteger curDis;
@property (nonatomic, assign) NSInteger curlabel;

@property (nonatomic, strong) MAMapView * mapView;
@property (nonatomic, strong) CLLocation * currentLocation;

@property (nonatomic, assign) NSInteger curPage;





@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor orangeColor];
    [MAMapServices sharedServices].apiKey = APIKey;
    self.mapView = [[MAMapView alloc]init];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.curPtype = 0;
    self.curDis = 0;
    self.curlabel = 0;
    [self initWithData];
    
    
    //[self createUI];
    self.isLogin = NO;
    //mainView
    if (self.mainView) {
        [self.mainView removeFromSuperview];
    }else{
        self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight-64)];
        //[self.mainView showPlaceHolderWithLineColor:[UIColor blackColor]];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.mainView];
    }
//    if (self.switcher) {
//        [self.switcher forceSelectedIndex:0 animated:YES];
//    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    

    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.naviBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    [self.view addSubview:self.naviBar];
    [self.naviBar setBarTintColor:[UIColor orangeColor]];
    self.leftBtnItem = [[UIButton alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
    [self.naviBar addSubview:self.leftBtnItem];
    [self.leftBtnItem addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([UserInfoTool getToken].length > 0) {
        [self.leftBtnItem setTitle:nil forState:UIControlStateNormal];
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
        iv.image = [UIImage imageNamed:@"左"];
        [self.leftBtnItem addSubview:iv];
        
        self.leftBtnItem.tag = 20;
        [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    }else{
        [self.leftBtnItem setTitle:@"登录" forState:UIControlStateNormal];
        self.leftBtnItem.tag = 21;
        [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
    }
    //navibarRightItem
    
//    UIButton * rightBtnItem = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth-self.navigationController.navigationBar.frame.size.height, kStatusBarHeight, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
//    [self.naviBar addSubview:rightBtnItem];
//    [rightBtnItem addTarget:self action:@selector(pushMapVC) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtnItem setImage:[UIImage imageNamed:@"定位1"] forState:UIControlStateNormal];
    
    [self createDVSwitch];
    if (self.dataTV) {
        [self.dataTV.header beginRefreshing];
    }
    
//    NSArray * segArr = [[NSArray alloc]initWithObjects:@"我要求帮",@"我要去帮",nil];
//    self.segControl = [[UISegmentedControl alloc]initWithItems:segArr];
//    self.segControl.bounds = CGRectMake(0, 0, 200, 30);
//    self.segControl.center = CGPointMake(self.navigationController.navigationBar.center.x, self.navigationController.navigationBar.center.y);
//    self.segControl.selectedSegmentIndex = 0;
//    self.segControl.tintColor = [UIColor whiteColor];
//    [self.naviBar addSubview:self.segControl];
//    [self.segControl addTarget:self action:@selector(changeSegIndex:) forControlEvents:UIControlEventValueChanged];
    [UserInfoTool deleteInviteFlag];
}

- (void)initWithData
{
    self.ptypeArr = [NSArray arrayWithObjects:@"全部类型",@"竞单",@"邀单",@"抢单", nil];
    self.disArr = [NSArray arrayWithObjects:@"最近发布",@"距离近",@"距离远",@"报价低",@"报价高",@"0~50元",@"50~200元",@"200元以上", nil];
    self.labelArr = [NSMutableArray array];
    self.labelModelArr = [NSMutableArray array];
    self.dataArr = [NSMutableArray array];
    [self requestParentLabel];
    

}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [self.segControl removeFromSuperview];
    
}

- (void)createUIinView:(UIView*)view
{
    //WEAK_SELF(weakSelf);


    
    
    //首页三栏
    
    
    
//    
//    CGFloat viewWidth = CGRectGetWidth(view.frame);
//    self.segmentedControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 64, viewWidth, 50)];
////    self.segmentedControl.selectedSegmentIndex = 0;
//    self.segmentedControl.type = HMSegmentedControlTypeText;
//    self.segmentedControl.sectionTitles = @[@"推荐",@"排行",@"分类"];
//    self.segmentedControl.selectedSegmentIndex = 0;
//    self.segmentedControl.backgroundColor = [UIColor whiteColor];
//    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
//    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
//    self.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
//    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
//    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//    self.segmentedControl.tag = 3;
//    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
//        NSLog(@"%d",index);
////        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, kMainScreenHeight-114) animated:YES];
//        switch (index) {
//            case 0:
//            {
//                weakSelf.currentUrl = [URL_BASE_H5 stringByAppendingString:@"recommend.jsp"];
//                
//            }
//                break;
//            case 1:
//            {
//                weakSelf.currentUrl = [URL_BASE_H5 stringByAppendingString:@"rank.jsp"];
//            }
//                break;
//            case 2:
//            {
//                weakSelf.currentUrl = [URL_BASE_H5 stringByAppendingString:@"sort.jsp"];
//            }
//                break;
//                
//            default:
//                break;
//                
//        }
//        [weakSelf.mainWebView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weakSelf.currentUrl]]];
//    }];
//    
//    [view addSubview:self.segmentedControl];
    
//    UIView * btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
//    btnView.backgroundColor =[UIColor redColor];
//    [view addSubview:btnView];
    
//    for (NSInteger i = 0; i < 3; i++) {
//        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*(kMainScreenWidth/3), 0, kMainScreenWidth/3, btnView.frame.size.height)];
//        btn.tag = i +100;
//        btn.backgroundColor = [UIColor whiteColor];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
//        [btnView addSubview:btn];
//        if (i == 0) {
//            [btn setTitle:@"推荐" forState:UIControlStateNormal];
//            btn.selected = YES;
//        }else if (i == 1){
//            [btn setTitle:@"排行" forState:UIControlStateNormal];
//            btn.selected = NO;
//        }else{
//            [btn setTitle:@"分类" forState:UIControlStateNormal];
//            btn.selected = NO;
//        }
//    }
    
    //三个按钮
//    self.recommendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth/3, btnView.frame.size.height)];
//    [self.recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
//    [self.recommendBtn addTarget:self action:@selector(recommentConverAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btnView addSubview:self.recommendBtn];
////    self.recommendBtn.backgroundColor = [UIColor orangeColor];
////    self.recommendBtn.selected = YES;
//    
//    self.arrangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth/3, 0, kMainScreenWidth/3, btnView.frame.size.height)];
//    [self.arrangeBtn setTitle:@"排行" forState:UIControlStateNormal];
//    [self.arrangeBtn addTarget:self action:@selector(arrangeConverAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btnView addSubview:self.arrangeBtn];
////    self.arrangeBtn.backgroundColor = [UIColor whiteColor];
//    
//    self.classifyBtn = [[UIButton alloc]initWithFrame:CGRectMake((kMainScreenWidth/3)*2, 0, kMainScreenWidth/3, btnView.frame.size.height)];
//    [self.classifyBtn setTitle:@"分类" forState:UIControlStateNormal];
//    [self.classifyBtn addTarget:self action:@selector(classifyConverAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btnView addSubview:self.classifyBtn];
//    self.classifyBtn.backgroundColor = [UIColor whiteColor];
    
    
    
//    UIWebView * webView1= [[UIWebView alloc]initWithFrame:];
//    NSURL * url1 = [NSURL URLWithString:@"http://119.254.102.77:8080/bkweb/bkc/recommend.html"];
//    webView1.delegate = self;
//    //    NSString * detailStr = [URL_NEWSDETAIL stringByAppendingString:self.newsId];
//    //    NSLog(@"--------- detailStr = %@",detailStr);
//    //    NSURL * url = [NSURL URLWithString:detailStr];
//    [webView1 loadRequest:[NSURLRequest requestWithURL:url1]];

    
    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame), viewWidth, kMainScreenHeight-114)];
//    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
//    [self.scrollView showPlaceHolderWithLineColor:[UIColor whiteColor]];
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.contentSize = CGSizeMake(viewWidth * 3, 300);
//    self.scrollView.delegate = self;
//    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, viewWidth, 300) animated:NO];
//    [self.view addSubview:self.scrollView];
//    
//    
//    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-114)];
//    self.view1.backgroundColor = [UIColor redColor];
//    
//
//    
//    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(kMainScreenWidth, 0, kMainScreenWidth, kMainScreenHeight-114)];
//    self.view2.backgroundColor = [UIColor yellowColor];
//    UIWebView * webView2= [[UIWebView alloc]initWithFrame:self.view2.bounds];
//    NSURL * url2 = [NSURL URLWithString:@"http://119.254.102.77:8080/bkweb/bkc/rank.html"];
//    webView2.delegate = self;
//    //    NSString * detailStr = [URL_NEWSDETAIL stringByAppendingString:self.newsId];
//    //    NSLog(@"--------- detailStr = %@",detailStr);
//    //    NSURL * url = [NSURL URLWithString:detailStr];
//    [webView2 loadRequest:[NSURLRequest requestWithURL:url2]];
//    [self.view2 addSubview:webView2];
//    [self.scrollView addSubview:self.view2];
//    
//    self.view3 = [[UIView alloc]initWithFrame:CGRectMake(kMainScreenWidth * 2, 0, kMainScreenWidth, kMainScreenHeight-114)];
//    self.view3.backgroundColor = [UIColor blueColor];
//    UIWebView * webView3= [[UIWebView alloc]initWithFrame:self.view1.bounds];
//    NSURL * url3 = [NSURL URLWithString:@"http://119.254.102.77:8080/bkweb/bkc/sort.html"];
//    //    NSString * detailStr = [URL_NEWSDETAIL stringByAppendingString:self.newsId];
//    //    NSLog(@"--------- detailStr = %@",detailStr);
//    //    NSURL * url = [NSURL URLWithString:detailStr];
//    [webView3 loadRequest:[NSURLRequest requestWithURL:url3]];
//    [self.view3 addSubview:webView3];
//    [self.scrollView addSubview:self.view3];
    
    
    //navibarLeftItem
    
    
//    self.mainWebView1= [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame), kMainScreenWidth, kMainScreenHeight - CGRectGetMaxY(self.segmentedControl.frame))];
//    NSURL * url = [NSURL URLWithString:@"http://119.254.102.77:8080/bk-portal/phone/recommend.jsp"];
//    self.mainWebView1.delegate = self;
//    webView.scrollView.header = [mjrefresh]
    
    //    NSString * detailStr = [URL_NEWSDETAIL stringByAppendingString:self.newsId];
    //    NSLog(@"--------- detailStr = %@",detailStr);
    //    NSURL * url = [NSURL URLWithString:detailStr];
    
    
//    [self.mainWebView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.currentUrl]]];
//    [view addSubview:self.mainWebView1];
//    UIButton * btn = [UIButton new];
//    [view addSubview:btn];
//    [view bringSubviewToFront:btn];
//    //    [btn showPlaceHolderWithLineColor:[UIColor blackColor]];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(view.mas_right).with.offset(0);
//        make.bottom.mas_equalTo(view.mas_bottom).with.offset(-25);
//        make.size.mas_equalTo(CGSizeMake(60, 60));
//    }];
//    [btn addTarget:self action:@selector(sendOrderAction:) forControlEvents:UIControlEventTouchUpInside];
//    //    btn.backgroundColor = [UIColor blackColor];
//    [btn setImage:[UIImage imageNamed:@"首页-发单"] forState:UIControlStateNormal];
    
    
}

#pragma mark - Action
- (void)recommentConverAction:(UIButton *)btn
{
    btn.selected = YES;
    btn.backgroundColor = [UIColor orangeColor];
    self.arrangeBtn.selected = NO;
    self.arrangeBtn.backgroundColor = [UIColor whiteColor];
    [self.arrangeBtn setNeedsLayout];
    self.classifyBtn.selected = NO;
    self.classifyBtn.backgroundColor = [UIColor whiteColor];
    [self.classifyBtn setNeedsLayout];
}

- (void)arrangeConverAction:(UIButton *)btn
{
    btn.selected = YES;
    btn.backgroundColor = [UIColor orangeColor];
    self.recommendBtn.selected = NO;
    self.recommendBtn.backgroundColor = [UIColor whiteColor];
    [self.recommendBtn setNeedsLayout];
    self.classifyBtn.selected = NO;
    self.classifyBtn.backgroundColor = [UIColor whiteColor];
    [self.classifyBtn setNeedsLayout];

}

- (void)classifyConverAction:(UIButton *)btn
{
    btn.selected = YES;
    btn.backgroundColor = [UIColor orangeColor];
    self.arrangeBtn.selected = NO;
    self.arrangeBtn.backgroundColor = [UIColor whiteColor];
    [self.arrangeBtn setNeedsLayout];
    self.recommendBtn.selected = NO;
    self.recommendBtn.backgroundColor = [UIColor whiteColor];
    [self.recommendBtn setNeedsLayout];

}
//- (void)selectAction:(UIButton *)btn
//{
//    if (btn.tag == 100) {
//        btn.selected = YES;
//        [btn setBackgroundColor:[UIColor orangeColor]];
//        self.currentUrl = @"http://119.254.102.77:8080/bkweb/bkc/recommend.html";
//        if (btn.tag == 101 || btn.tag == 102) {
//            btn.selected = NO;
//            [btn setBackgroundColor:[UIColor whiteColor]];
//        }
//        
//    }else if (btn.tag == 101){
//        btn.selected = YES;
//        [btn setBackgroundColor:[UIColor orangeColor]];
//
//        self.currentUrl = @"http://119.254.102.77:8080/bkweb/bkc/rank.html";
//        if (btn.tag == 100 || btn.tag == 102) {
//            btn.selected = NO;
//            [btn setBackgroundColor:[UIColor whiteColor]];
//        }
//    }else if (btn.tag == 102){
//        btn.selected = YES;
//        [btn setBackgroundColor:[UIColor orangeColor]];
//        self.currentUrl = @"http://119.254.102.77:8080/bkweb/bkc/sort.html";
//        if (btn.tag == 100 || btn.tag == 101) {
//            btn.selected = NO;
//            [btn setBackgroundColor:[UIColor whiteColor]];
//        }
//    }
//    
//
//    
//    
//}

- (void)leftBtnAction:(UIButton *)btn
{
    NSLog(@"测试");
    if (btn.tag == 20) {
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }else{
//        LoginViewController * loginVC = [[LoginViewController alloc]init];
//        UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        [self presentViewController:navi animated:YES completion:nil];
        [[AppDelegate shareInstance] setLoginVC];
    }
//    self.isLogin = !self.isLogin;
    
//    if (self.isLogin == NO) {
//        [[self.leftBtnItem.subviews lastObject]removeFromSuperview];
//        [self.leftBtnItem setTitle:@"登录" forState:UIControlStateNormal];
//        [self.slidingViewController anchorTopViewToRightAnimated:YES];
//        
//        
//    }else{
//        [self.leftBtnItem setTitle:nil forState:UIControlStateNormal];
//        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
//        iv.image = [UIImage imageNamed:@"左"];
//        [self.leftBtnItem addSubview:iv];
        //为了调试
    
        
        
        
    //}
    
}

- (void)pushLeftVC
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
//- (void)pushMapVC
//{
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
//     MapViewController * mapVC = [[MapViewController alloc]init];
////    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:mapVC];
////   
////    [self presentViewController:navi animated:YES completion:nil];
//    [self.navigationController pushViewController:mapVC animated:YES];
//}
- (void)sendOrderAction:(UIButton *)btn
{
    NSLog(@"发单");
    CreateOrderViewController * createVC = [[CreateOrderViewController alloc]init];
    createVC.source = 1;
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:createVC];
    [self presentViewController:navi animated:YES completion:nil];
    
    
}

- (void)changeSegIndex:(UISegmentedControl *)control
{
    NSLog(@"%ld",(long)control.selectedSegmentIndex);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"切换");
    //    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / kMainScreenWidth;
    
    //[self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, kMainScreenWidth, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   
    NSString * urlString = request.URL.absoluteString;
//    NSString * encode = [urlString ]
     NSLog(@"request.URL = %@",urlString);
    //NSLog(@"mainString = %@",mainString);
    NSString * testStr = @"http://119.254.102.77:8080/bkweb/bkc/serviceinformation.html?test=1&ppp=222";
    NSArray * arr = [testStr componentsSeparatedByString:@"?"];
    NSLog(@"---- arr = %@",arr);
    NSString * paramStr = [arr lastObject];
    NSLog(@"-------- paramStr = %@",paramStr);
    
    if ([urlString isEqualToString:@"http://119.254.102.77:8080/bkweb/bkc/serviceinformation.html?test=1&ppp=222"]) {
        MineFundViewController * mapVC = [[MineFundViewController alloc]initWithNibName:@"MineFundViewController"  bundle:nil];
        [self.navigationController pushViewController:mapVC animated:YES];
    }
    
    NSLog(@"%ld",(long)navigationType);
    return YES;
}
- (UIStatusBarStyle) preferredStatusBarStyle {
    //状态栏变色
    return UIStatusBarStyleLightContent;
}

- (void)createDVSwitch
{
    WEAK_SELF(weakSelf);
    NSString * token = [UserInfoTool getToken];
    self.currentUrl = [NSString stringWithFormat:@"%@recommend.jsp?access_token=%@",URL_BASE_H5,token];
    NSLog(@"weakSelf.currentUrl = %@",weakSelf.currentUrl);
    CGRect segmentedFrame = CGRectMake(50, 25, kMainScreenWidth- 100, 30);
    NSArray * segArr = [[NSArray alloc]initWithObjects:@"我要求帮",@"我要去帮",nil];
    self.switcher = [[DVSwitch alloc]initWithStringsArray:segArr];
    self.switcher.frame = segmentedFrame;
    self.switcher.backgroundColor = [UIColor whiteColor];
    self.switcher.sliderColor = [UIColor orangeColor];
    self.switcher.layer.borderColor = [[UIColor orangeColor]CGColor];
//    [self.switcher forceSelectedIndex:0 animated:YES];
    [self.naviBar addSubview:self.switcher];
    
    //我要求帮
    self.firstView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-69)];
    self.firstView.backgroundColor = [UIColor whiteColor];
    //[self.firstView showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self initFirstView];
    [self.mainView addSubview:self.firstView];
    //我要去帮
    self.secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-69)];
    self.secondView.backgroundColor = [UIColor whiteColor];
    //[self.secondView showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self initSecondView];
    self.secondView.hidden = YES;
    [self.mainView addSubview:self.secondView];
    
    //switcher 回调方法
    
    [self.switcher setPressedHandler:^(NSUInteger index) {
        switch (index) {
            case 0:
            {
                weakSelf.firstView.hidden = NO;
                weakSelf.secondView.hidden = YES;
                weakSelf.currentUrl = [NSString stringWithFormat:@"%@recommend.jsp?access_token=%@",URL_BASE_H5,token];
                NSLog(@"weakSelf.currentUrl = %@",weakSelf.currentUrl);
                [weakSelf.mainWebView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weakSelf.currentUrl]]];
                

            }
            break;
            case 1:
            {
                weakSelf.firstView.hidden = YES;
                weakSelf.secondView.hidden = NO;
                weakSelf.currentUrl = [NSString stringWithFormat:@"%@recommend1.jsp?access_token=%@",URL_BASE_H5,token];
                NSLog(@"weakSelf.currentUrl = %@",weakSelf.currentUrl);
                [weakSelf.mainWebView2 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weakSelf.currentUrl]]];

            }
            break;
            default:
            break;
        }
    }];
    
    

}

- (void)initFirstView
{

    WEAK_SELF(weakSelf);
    //首页三栏
    
    
    
    
    
    //
    CGFloat viewWidth = CGRectGetWidth(self.firstView.frame);
    self.segmentedControl1 = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 50)];
    //    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl1.type = HMSegmentedControlTypeText;
    self.segmentedControl1.sectionTitles = @[@"推荐",@"排行",@"分类"];
    self.segmentedControl1.selectedSegmentIndex = 0;
    self.segmentedControl1.backgroundColor = [UIColor whiteColor];
    self.segmentedControl1.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl1.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    self.segmentedControl1.selectionIndicatorColor = [UIColor orangeColor];
    self.segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl1.tag = 3;
    NSString * token = [UserInfoTool getToken];
    [self.segmentedControl1 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"%d",index);
        switch (index) {
            case 0:
            {
                weakSelf.currentUrl = [NSString stringWithFormat:@"%@recommend.jsp?access_token=%@",URL_BASE_H5,token];
                NSLog(@"weakSelf.currentUrl = %@",weakSelf.currentUrl);

            }
                break;
            case 1:
            {
                //weakSelf.currentUrl = [URL_BASE_H5 stringByAppendingString:@"rank.jsp"];
                weakSelf.currentUrl = [NSString stringWithFormat:@"%@rank.jsp?access_token=%@",URL_BASE_H5,token];
                NSLog(@"weakSelf.currentUrl = %@",weakSelf.currentUrl);
            }
                break;
            case 2:
            {
                //weakSelf.currentUrl = [URL_BASE_H5 stringByAppendingString:@"sort.jsp"];
                weakSelf.currentUrl = [NSString stringWithFormat:@"%@sort.jsp?access_token=%@",URL_BASE_H5,token];
                NSLog(@"weakSelf.currentUrl = %@",weakSelf.currentUrl);
            }
                break;
                
            default:
                break;
                
        }
        
        [weakSelf.mainWebView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weakSelf.currentUrl]]];
        //[weakSelf.mainWebView1 reload];
    }];
    
    [self.firstView addSubview:self.segmentedControl1];
    self.mainWebView1= [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl1.frame), kMainScreenWidth, kMainScreenHeight - CGRectGetMaxY(self.segmentedControl1.frame)- 64)];
    [self.firstView addSubview:self.mainWebView1];
    
//    if (!_bridge1) {
        [WebViewJavascriptBridge enableLogging];
        self.bridge1 = [WebViewJavascriptBridge bridgeForWebView:self.mainWebView1 webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"ObjC received message from JS: %@", data);
            responseCallback(@"Response for message from ObjC");
        }];
        
        
        //        [_bridge send:@"A string sent from ObjC to JS" responseCallback:^(id response) {
        //            NSLog(@"sendMessage got response: %@", response);
        //        }];
        //NSString * token = [UserInfoTool getToken];
        //    if (token.length > 0) {
        //        id data = @{ @"access_token": token};
        //        [_bridge callHandler:@"accessTokenCallBack" data:data responseCallback:^(id response) {
        //            NSLog(@"testJavascriptHandler responded: %@", response);
        //        }];
        //        [_bridge send:data responseCallback:^(id responseData) {
        //            NSLog(@"testJavascriptHandler responded: %@", responseData);
        //        }];
        
        //    }
        QuickOrderViewController * quickOrderVC = [[QuickOrderViewController alloc]init];
        UINavigationController * navi1 = [[UINavigationController alloc]initWithRootViewController:quickOrderVC];
        [self.bridge1 registerHandler:@"serviceIdCallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"serviceIdCallBack called: %@", data);
            NSDictionary * dict = data;
            //NSString * cid = [dict objectForKey:@"cid"];
            NSString * serviceId = [dict objectForKey:@"param"];
            //NSString * password = [dict objectForKey:@"password"];
            //NSLog(@"%@",cid);
            NSLog(@"%@",serviceId);
            //NSLog(@"%@",password);
            quickOrderVC.currentToken = token;
            quickOrderVC.serviceID = serviceId;
            quickOrderVC.source = 1;
            [weakSelf presentViewController:navi1 animated:YES completion:nil];
            
            
            //        responseCallback(@{@"userName": [UserInfoTool getUserName],@"password": [UserInfoTool getPWD],@"cid": [UserInfoTool getClientID]});
            responseCallback(@"回传数据");
        }];
        
        [self.bridge1 registerHandler:@"rankCallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"serviceIdCallBack called: %@", data);
            NSDictionary * dict = data;
            //NSString * cid = [dict objectForKey:@"cid"];
            NSString * param = [dict objectForKey:@"param"];
            //NSString * password = [dict objectForKey:@"password"];
            //NSLog(@"%@",cid);
            //NSLog(@"%@",serviceId);
            //NSLog(@"%@",password);
            quickOrderVC.currentToken = token;
            quickOrderVC.serviceID = param;
            quickOrderVC.source = 1;
            
            [weakSelf presentViewController:navi1 animated:YES completion:nil];
            
            
            //        responseCallback(@{@"userName": [UserInfoTool getUserName],@"password": [UserInfoTool getPWD],@"cid": [UserInfoTool getClientID]});
            responseCallback(@"回传数据");
        }];
        
        SortViewController * sortVC =[[SortViewController alloc]init];
        UINavigationController * navi2 = [[UINavigationController alloc]initWithRootViewController:sortVC];
        [self.bridge1 registerHandler:@"parentIdCallBack" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"serviceIdCallBack called: %@", data);
            NSDictionary * dict = data;
            //NSString * cid = [dict objectForKey:@"cid"];
            NSString * param = [dict objectForKey:@"param"];
            //NSString * password = [dict objectForKey:@"password"];
            //NSLog(@"%@",cid);
            //NSLog(@"%@",serviceId);
            //NSLog(@"%@",password);
            sortVC.source = 1;
            sortVC.labelID  = param;
            
            [weakSelf presentViewController:navi2 animated:YES completion:nil];
            
            
            //        responseCallback(@{@"userName": [UserInfoTool getUserName],@"password": [UserInfoTool getPWD],@"cid": [UserInfoTool getClientID]});
            responseCallback(@"回传数据");
        }];
   //}
    
    
    
    
    
    //self.mainWebView1.delegate = self;
    
    [self.mainWebView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.currentUrl]]];
    
    UIButton * btn = [UIButton new];
    [self.firstView addSubview:btn];
    [self.firstView bringSubviewToFront:btn];
    //    [btn showPlaceHolderWithLineColor:[UIColor blackColor]];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.firstView.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.firstView.mas_bottom).with.offset(-25);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [btn addTarget:self action:@selector(sendOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    //    btn.backgroundColor = [UIColor blackColor];
    [btn setImage:[UIImage imageNamed:@"首页-发单"] forState:UIControlStateNormal];
    
    

    
    
}

- (void)initSecondView
{
    WEAK_SELF(weakSelf);
    UIView * btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, RECTFIX_HEIGHT(44))];
    btnView.backgroundColor = [UIColor whiteColor];
    [self.secondView addSubview:btnView];
    
    self.btn1 = [[HomeBtn alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, btnView.frame.size.height) andTitle:@"全部类型"];
    //[self.btn1 showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.btn1 addTarget:self action:@selector(optionListOpen:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.tag = HBTNTAG;
    [btnView addSubview:self.btn1];

    
    self.btn2 = [[HomeBtn alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.btn1.frame), 0, SCREEN_WIDTH/3, btnView.frame.size.height) andTitle:@"最新发布"];
    //[self.btn2 showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.btn2 addTarget:self action:@selector(optionListOpen:) forControlEvents:UIControlEventTouchUpInside];
    self.btn2.tag = HBTNTAG + 1;
    [btnView addSubview:self.btn2];
    
    self.btn3 = [[HomeBtn alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.btn2.frame), 0, SCREEN_WIDTH/3, btnView.frame.size.height) andTitle:@"全部标签"];
    [self.btn3 addTarget:self action:@selector(optionListOpen:) forControlEvents:UIControlEventTouchUpInside];
    self.btn3.tag = HBTNTAG + 2;
    [btnView addSubview:self.btn3];
    
    //data tableView
    self.dataTV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btnView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(btnView.frame) - kNaviMaxY)];
    //[self.dataTV showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.dataTV.delegate = self;
    self.dataTV.dataSource = self;
    self.dataTV.tag = TVTAG;
    [self.secondView addSubview:self.dataTV];
    
    
    //下拉刷新
    [self.dataTV addLegendHeaderWithRefreshingBlock:^{
        weakSelf.curPage = 1;
        [weakSelf.dataArr removeAllObjects];
        [weakSelf getOrderListWithPage:weakSelf.curPage];
    }];
    //上拉加载
    [self.dataTV addLegendFooterWithRefreshingBlock:^{
        weakSelf.curPage++;
        [weakSelf getOrderListWithPage:weakSelf.curPage];
    }];
    
    //maskView
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, kNaviMaxY + RECTFIX_HEIGHT(44), SCREEN_WIDTH, SCREEN_HEIGHT - RECTFIX_HEIGHT(44) - kNaviMaxY)];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.5;
    [self.secondView addSubview:self.maskView];
    self.maskView.hidden = YES;
    
    //ptypeList
    self.ptypeList = [[UITableView alloc]initWithFrame:CGRectMake(0, btnView.frame.size.height, SCREEN_WIDTH, 0)];
    self.ptypeList.delegate = self;
    self.ptypeList.dataSource = self;
    self.ptypeList.hidden = YES;
    self.ptypeList.tag = TVTAG + 1;
    self.ptypeList.alpha = 1;
    [self.secondView addSubview:self.ptypeList];
    [self.secondView bringSubviewToFront:self.ptypeList];
    
    //disList
    self.disList = [[UITableView alloc]initWithFrame:CGRectMake(0, btnView.frame.size.height, SCREEN_WIDTH, 0)];
    self.disList.delegate = self;
    self.disList.dataSource = self;
    self.disList.hidden = YES;
    self.disList.tag = TVTAG + 2;
    self.disList.alpha = 1;
    [self.secondView addSubview:self.disList];
    [self.secondView bringSubviewToFront:self.disList];
    
    //labelList
    self.labelList = [[UITableView alloc]initWithFrame:CGRectMake(0, btnView.frame.size.height, SCREEN_WIDTH, 0)];
    self.labelList.delegate = self;
    self.labelList.dataSource = self;
    self.labelList.hidden = YES;
    self.labelList.tag = TVTAG + 3;
    self.labelList.alpha = 1;
    [self.secondView addSubview:self.labelList];
    [self.secondView bringSubviewToFront:self.labelList];
    
    
    
    
    
    

    
    
    

}

- (void)optionListOpen:(HomeBtn *)btn
{
    btn.isTaped = !btn.isTaped;
    
    
    switch (btn.tag - HBTNTAG) {
        case 0:
        {
            [self.ptypeList reloadData];
            btn.bottomLine.hidden = NO;
            btn.titleLbl.textColor = [UIColor colorWithHexString:@"FA9924"];
            btn.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong-pre2x"];
            
            self.btn2.bottomLine.hidden = YES;
            self.btn2.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
            self.btn2.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            self.btn2.isTaped = NO;
            self.btn3.isTaped = NO;
            self.btn3.bottomLine.hidden = YES;
            self.btn3.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
            self.btn3.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            self.disList.hidden = YES;
            self.labelList.hidden = YES;
            
        
            
            CGRect optionFrame = self.ptypeList.frame;
            optionFrame.size.height = self.ptypeArr.count * RECTFIX_HEIGHT(44);
            self.ptypeList.frame = optionFrame;
            self.maskView.hidden = NO;
            self.ptypeList.hidden = NO;
            [self.ptypeList reloadData];
            if (btn.isTaped == NO) {
                self.ptypeList.hidden = YES;
                self.maskView.hidden = YES;
                btn.bottomLine.hidden = YES;
                btn.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
                btn.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            }
            
        
            
        }
            
            break;
        case 1:
        {
            [self.disList reloadData];
            btn.bottomLine.hidden = NO;
            btn.titleLbl.textColor = [UIColor colorWithHexString:@"FA9924"];
            btn.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong-pre2x"];
            
            self.btn1.bottomLine.hidden = YES;
            self.btn1.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
            self.btn1.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            self.btn1.isTaped = NO;
            self.btn3.isTaped = NO;
            self.btn3.bottomLine.hidden = YES;
            self.btn3.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
            self.btn3.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            self.ptypeList.hidden = YES;
            self.labelList.hidden = YES;
            
            CGRect optionFrame = self.disList.frame;
            optionFrame.size.height = self.disArr.count * RECTFIX_HEIGHT(44);
            self.disList.frame = optionFrame;
            self.maskView.hidden = NO;
            self.disList.hidden = NO;
            [self.disList reloadData];
            if (btn.isTaped == NO) {
                self.disList.hidden = YES;
                self.maskView.hidden = YES;
                btn.bottomLine.hidden = YES;
                btn.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
                btn.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            }
            
            
            
            
        }
            
            break;

        case 2:
        {
            [self.labelList reloadData];
            btn.bottomLine.hidden = NO;
            btn.titleLbl.textColor = [UIColor colorWithHexString:@"FA9924"];
            btn.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong-pre2x"];

            self.btn1.bottomLine.hidden = YES;
            self.btn1.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
            self.btn1.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            self.btn1.isTaped = NO;
            self.btn2.isTaped = NO;
            self.btn2.bottomLine.hidden = YES;
            self.btn2.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
            self.btn2.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            self.ptypeList.hidden = YES;
            self.disList.hidden = YES;
            
            CGRect optionFrame = self.labelList.frame;
            optionFrame.size.height = self.labelArr.count * RECTFIX_HEIGHT(44);
            self.labelList.frame = optionFrame;
            self.maskView.hidden = NO;
            self.labelList.hidden = NO;
            [self.labelList reloadData];
            if (btn.isTaped == NO) {
                self.labelList.hidden = YES;
                self.maskView.hidden = YES;
                btn.bottomLine.hidden = YES;
                btn.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
                btn.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            }
            
            
        
        }
            
            break;

            
        default:
            break;
    }
//    if (btn.isTaped == YES) {
//        btn.bottomLine.hidden = NO;
//        btn.titleLbl.textColor = [UIColor colorWithHexString:@"FA9924"];
//        btn.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong-pre2x"];
//    }else{
//        btn.bottomLine.hidden = YES;
//        btn.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
//        btn.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
//    }
    
    NSLog(@"测试打开选项表");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag - TVTAG) {
        case 0:
            return self.dataArr.count;
            break;
        case 1:
            return self.ptypeArr.count;
            break;
        case 2:
            return self.disArr.count;
            break;
        case 3:
            return self.labelArr.count;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag - TVTAG == 1) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell.textLabel.text = self.ptypeArr[indexPath.row];
        if (indexPath.row == self.curPtype) {
            cell.textLabel.textColor = [UIColor colorWithHexString:@"FA9924"];
        }else{
            cell.textLabel.textColor = [UIColor blackColor];
        }
        
        
        return cell;
    }else if (tableView.tag - TVTAG == 2){
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
         cell.textLabel.text = self.disArr[indexPath.row];
        if (indexPath.row == self.curDis) {
            cell.textLabel.textColor = [UIColor colorWithHexString:@"FA9924"];
        }else{
            cell.textLabel.textColor = [UIColor blackColor];
        }
        
        return cell;
    }else if (tableView.tag - TVTAG == 3){
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        }
        cell.textLabel.text = self.labelArr[indexPath.row];
        if (indexPath.row == self.curlabel) {
            cell.textLabel.textColor = [UIColor colorWithHexString:@"FA9924"];
        }else{
            cell.textLabel.textColor = [UIColor blackColor];
        }
        
        return cell;
    }else if(tableView.tag - TVTAG == 0){
        Cell_Helplist * cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (!cell) {
            cell = [[Cell_Helplist alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
        }
        Model_OrderHelpList * model = self.dataArr[indexPath.row];
//        cell.textLabel.text = model.descrip;
        cell.model = model;
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger j =  tableView.tag - TVTAG;
    if (j == 1 || j == 2 || j==3) {
        if (self.btn1.isTaped == YES) {
            self.curPtype = indexPath.row;
            self.btn1.bottomLine.hidden = YES;
            self.btn1.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
            self.btn1.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            self.btn1.titleLbl.text = self.ptypeArr[indexPath.row];
            self.btn1.isTaped = NO;
            self.ptypeList.hidden = YES;
            [self.ptypeList reloadData];
            
        }else if (self.btn2.isTaped == YES){
            self.curDis = indexPath.row;
            self.btn2.bottomLine.hidden = YES;
            self.btn2.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
            self.btn2.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            self.btn2.titleLbl.text = self.disArr[indexPath.row];
            self.btn2.isTaped = NO;
            self.disList.hidden = YES;
            [self.disList reloadData];
            
        }else if (self.btn3.isTaped == YES){
            self.curlabel = indexPath.row;
            self.btn3.bottomLine.hidden = YES;
            self.btn3.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
            self.btn3.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
            self.btn3.titleLbl.text = self.labelArr[indexPath.row];
            self.btn3.isTaped = NO;
            self.labelList.hidden = YES;
            [self.labelList reloadData];
            
        }
        self.maskView.hidden = YES;
        NSLog(@"%d",self.curPtype);
        NSLog(@"%d",self.curDis);
        NSLog(@"%d",self.curlabel);
        
        
        
        [self.dataTV.header beginRefreshing];
    }else{
        Model_OrderHelpList * model = self.dataArr[indexPath.row];
        OrderDetail_AViewController * detailVC = [[OrderDetail_AViewController alloc]init];
        detailVC.curID = model.process_recode_id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
        
    
    
    
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag - TVTAG == 0) {
        return RECTFIX_HEIGHT(145);
    }else{
        return 44;
    }
}


#pragma mark - Request
///获取父标签
- (void)requestParentLabel
{
    WEAK_SELF(weakSelf);
    [AFNHttpTools getDataWithUrl:@"label/getParentLabel" andParameters:nil successed:^(NSDictionary *dict) {
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"json = %@",json);
        Model_SearchParentLabel * searchModel = [[Model_SearchParentLabel alloc]initWithString:json error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            [weakSelf.labelArr removeAllObjects];
            [weakSelf.labelModelArr removeAllObjects];
            [weakSelf.labelModelArr addObjectsFromArray:searchModel.responseText];
            [weakSelf.labelArr addObject:@"全部标签"];
            if (searchModel.responseText && searchModel.responseText.count >0) {
                for (int i = 0; i< searchModel.responseText.count; i++) {
                    Model_ParentLabel * parentLabel = searchModel.responseText[i];
                    NSString * labelName = parentLabel.name;
                    [weakSelf.labelArr addObject:labelName];
                }
            }
        }else{
            NSLog(@"返回信息 = %@",searchModel.message);
        }
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}

///获得订单列表
-(void)getOrderListWithPage:(NSInteger)page
{
    WEAK_SELF(weakSelf);
    NSString * curlabelID ;
    if (self.curlabel == 0) {
        curlabelID = nil;
    }else{
        Model_ParentLabel * curlabel = self.labelModelArr[self.curlabel-1];
        NSLog(@"%@",curlabel.name);
        curlabelID = curlabel.id;
    }
    
    NSString * lat =[NSString stringWithFormat:@"%f",self.currentLocation.coordinate.latitude];
    NSString * lon =[NSString stringWithFormat:@"%f",self.currentLocation.coordinate.longitude];
    [OrderRequestTool requestOrderListWithPage:page andLatitude:lat andLongitude:lon andSequence:self.curDis+1 andLabel:curlabelID andPtype:self.curPtype andSuccessed:^(id model) {
        [weakSelf.dataTV.header endRefreshing];
        [weakSelf.dataTV.footer endRefreshing];
        Model_SearchHelpList * searchModel = model;
        NSLog(@"%@",searchModel.state);
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            NSLog(@"%d",weakSelf.dataArr.count);
            NSLog(@"array = %@",searchModel.responseText);
            if (searchModel.responseText.count == 0) {
                [weakSelf.dataTV reloadData];
                weakSelf.curPage-- ;
                CGRect dataTVFrame = weakSelf.dataTV.frame;
                dataTVFrame.size.height = weakSelf.dataArr.count * RECTFIX_HEIGHT(145);
                if (dataTVFrame.size.height > (SCREEN_HEIGHT - RECTFIX_HEIGHT(44) - kNaviMaxY)) {
                    dataTVFrame.size.height = SCREEN_HEIGHT - RECTFIX_HEIGHT(44) - kNaviMaxY;
                }
                weakSelf.dataTV.frame = dataTVFrame;
                [weakSelf.secondView makeToast:@"没有更多数据了" duration:ToastDuration position:CSToastPositionCenter];
                
            }else{
                [weakSelf.dataArr addObjectsFromArray:searchModel.responseText];
                CGRect dataTVFrame = weakSelf.dataTV.frame;
                dataTVFrame.size.height = weakSelf.dataArr.count * RECTFIX_HEIGHT(145);
                if (dataTVFrame.size.height > (SCREEN_HEIGHT - RECTFIX_HEIGHT(44) - kNaviMaxY)) {
                    dataTVFrame.size.height = SCREEN_HEIGHT - RECTFIX_HEIGHT(44) - kNaviMaxY;
                }
                weakSelf.dataTV.frame = dataTVFrame;
                [weakSelf.dataTV reloadData];
            }
            
        }else{
//            [weakSelf.secondView makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
        }
    } andFailed:^(NSError *err) {
        [weakSelf.dataTV.header endRefreshing];
        [weakSelf.dataTV.footer endRefreshing];
//        [weakSelf.secondView makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    self.currentLocation = userLocation.location;
    NSLog(@"latitude = %f",self.currentLocation.coordinate.latitude);
    NSLog(@"longitude = %f",self.currentLocation.coordinate.longitude);
}


@end
