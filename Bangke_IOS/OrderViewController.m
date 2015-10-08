




//
//  OrderViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#define ROWS @"10"
#define TVTAG 100

#import "OrderViewController.h"
#import "HMSegmentedControl.h"
#import "Cell_Order.h"
#import "Model_Order.h"
#import "HomePageViewController.h"
#import "ECSlidingViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "AssessmentViewController.h"
#import "ConnectPersonViewController.h"
#import "Model_SearchOrder.h"
#import "MJRefresh.h"
#import "OrderDetailViewController.h"
#import "AssessmentViewController.h"
#import "Model_SearchReviewOrder.h"
#import "ChatViewController.h"
#import "UserRequestTool.h"
#import "Model_SearchHeadPortrait.h"
#import "Model_SearchAccount.h"
#import "InviteOrCompeteListVC.h"
#import "Model_SearchReviewOrder.h"
#import "OrderDetail_AViewController.h"
@interface OrderViewController () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) HMSegmentedControl * segmentedControl;
@property (nonatomic, strong) NSMutableArray * dataArr1;
@property (nonatomic, strong) NSMutableArray * dataArr2;
@property (nonatomic, strong) UINavigationController * orderNavigationController;
@property (nonatomic, strong) UITableView * tv1;
@property (nonatomic, strong) UITableView * tv2;
@property (nonatomic, strong) UITableView * currentTableView;
@property (nonatomic, strong) Model_OrderDesc * currentModel;
@property (nonatomic, strong) NSString * currentTotal;
@property (nonatomic, assign) NSInteger currentPageIndex;
@end
//self.homePageNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
@implementation OrderViewController

+ (OrderViewController *)sharedInstance
{
    static OrderViewController * orderVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        orderVC = [[OrderViewController alloc]init];
    });
    return orderVC;
}


- (void)viewDidLoad {
    
//    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;

//    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(selectTagAction)];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"图层 3"] style:UIBarButtonItemStyleDone target:self action:@selector(selectTagAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
//    self.title = @"发的订单";
    if (self.source == PushSourceSendOrder) {
        self.title = @"发的订单";
    }else{
        self.title = @"接的订单";
    }
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [rightItem setTintColor:[UIColor orangeColor]];
    [self createUI];
//    NSArray * arr1 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",nil];
//    NSArray * arr2 = [NSArray arrayWithObjects:@"one",@"two",@"three",nil];
    self.dataArr1 = [NSMutableArray array];
    self.dataArr2 = [NSMutableArray array];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if ([self.currentTableView isKindOfClass:[NSNull class]]) {
//        self.currentTableView = self.tv1;
//    }
   NSString * token = [UserInfoTool getToken];
//    [self requestDataWithToken:token andPtype:@"1" andCompletion:@"complete" andPage:@"1" andRows:@"10" forTableView:self.currentTableView];
//    self.scrollView
//    [self requestDataWithToken:token andPtype:nil andCompletion:@"unfinished" andPage:@"1" andRows:@"10" andLabelID:nil forTableView:self.currentTableView];
    NSString * completion = nil;
    NSInteger currentTag = [UserInfoTool getCurrentTVTag].integerValue;
    NSLog(@"currentTag = %d",currentTag);
    if (currentTag == TVTAG ||currentTag == 0) {
        completion = @"unfinished";
    }else{
        completion = @"complete";
    }
    
   
    if ([UserInfoTool getCurrentTVTag].integerValue == 0) {
        [UserInfoTool saveCurrentTVTag:@"100"];
    }
     NSLog(@"tag = %d",[UserInfoTool getCurrentTVTag].integerValue);
    self.currentTableView  = (UITableView *)[self.scrollView viewWithTag:[[UserInfoTool getCurrentTVTag]integerValue]];
   // self.currentPtype = [UserInfoTool getCurrentPtype];
//    NSLog(@"self.currentPtype = %@",[UserInfoTool getCurrentPtype]);
//    NSLog(@"self.currentLabelID = %@",self.currentLabelID);
    NSLog(@"tag = %d",self.currentTableView.tag);
    
//    self.currentLabelID = [UserInfoTool get]
    if (self.currentTableView.tag == TVTAG) {
        [self.dataArr1 removeAllObjects];
        self.currentTableView = self.tv1;
    }else{
        [self.dataArr2 removeAllObjects];
        self.currentTableView = self.tv2;
    }
    [self requestDataWithToken:token andCompletion:completion andPage:@"1" andRows:ROWS forTableView:self.currentTableView];
}



- (void)createUI
{
    WEAK_SELF(weakSelf);
//    self.navigationController.navigationBar.hidden = YES;
//    UINavigationBar * navibar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, kMainScreenWidth, 64)];
//    [self.view addSubview:navibar];
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [navibar addSubview:btn];
//    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor redColor];
    

    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    self.segmentedControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 64, viewWidth, 50)];
    //    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.type = HMSegmentedControlTypeText;
    self.segmentedControl.sectionTitles = @[@"未完成订单",@"已完成订单"];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.tag = 3;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, kMainScreenHeight-114) animated:YES];
        switch (index) {
            case 0:
            {
                [UserInfoTool deleteCurrentTVTag];
                [UserInfoTool saveCurrentTVTag:@"100"];
                
                
                
            }
                break;
            case 1:
            {
                [UserInfoTool deleteCurrentTVTag];
                [UserInfoTool saveCurrentTVTag:@"101"];
                
                
                
            }
                break;
                
            default:
                break;
        }
        weakSelf.currentTableView = (UITableView *)[weakSelf.scrollView viewWithTag:(TVTAG + index)];
        [weakSelf.currentTableView.header beginRefreshing];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame), viewWidth, kMainScreenHeight-114)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    [self.scrollView showPlaceHolderWithLineColor:[UIColor whiteColor]];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 2, 300);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, viewWidth, 300) animated:NO];
    [self.view addSubview:self.scrollView];
    NSString * token = [UserInfoTool getToken];
    self.tv1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-114)];
    [self.tv1 addLegendHeaderWithRefreshingBlock:^{
        [weakSelf.dataArr1 removeAllObjects];
        weakSelf.currentPageIndex = 1;
        
//        [weakSelf requestDataWithToken:token andPtype:nil andCompletion:@"unfinished" andPage:@"1" andRows:@"10" forTableView:weakSelf.tv1];
        [weakSelf requestDataWithToken:token andCompletion:@"unfinished" andPage:[NSString stringWithFormat:@"%ld",(long)weakSelf.currentPageIndex] andRows:ROWS forTableView:weakSelf.tv1];
//        [weakSelf requestDataWithToken:token andPtype:@"2" andCompletion:@"unfinished" andPage:@"1" andRows:@"10" forTableView:weakSelf.tv1];
//        [weakSelf requestDataWithToken:token andPtype:@"3" andCompletion:@"unfinished" andPage:@"1" andRows:@"10" forTableView:weakSelf.tv1];
        
    }];
    
    [self.tv1 addLegendFooterWithRefreshingBlock:^{
        if (weakSelf.currentPageIndex == 0) {
            weakSelf.currentPageIndex = 1;
        }
        if ((weakSelf.currentPageIndex * ROWS.integerValue) >= weakSelf.currentTotal.integerValue) {
            [weakSelf.view makeToast:dTips_noMoreData duration:ToastDuration position:CSToastPositionCenter];
            [weakSelf.tv1.footer endRefreshing];
        }else{
            weakSelf.currentPageIndex++;
            [weakSelf requestDataWithToken:token andCompletion:@"unfinished" andPage:[NSString stringWithFormat:@"%ld",(long)weakSelf.currentPageIndex] andRows:ROWS forTableView:weakSelf.tv1];
        }
    }];
    
    self.tv1.tag = TVTAG;
    self.tv1.dataSource = self;
    self.tv1.delegate = self;
//    tv1.backgroundColor = [UIColor redColor];
    //[tv1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.scrollView.tag = 5;
    [self.scrollView addSubview:self.tv1];
    
    self.tv2 = [[UITableView alloc]initWithFrame:CGRectMake(kMainScreenWidth, 0, kMainScreenWidth, kMainScreenHeight-114)];
    [self.tv2 addLegendHeaderWithRefreshingBlock:^{
        [weakSelf.dataArr2 removeAllObjects];
        weakSelf.currentPageIndex = 1;
//        NSString * token = [UserInfoTool getToken];
//        [weakSelf requestDataWithToken:token andPtype:nil andCompletion:@"complete" andPage:@"1" andRows:@"10" forTableView:weakSelf.tv2];
        [weakSelf requestDataWithToken:token andCompletion:@"complete" andPage:[NSString stringWithFormat:@"%ld",(long)weakSelf.currentPageIndex] andRows:ROWS forTableView:weakSelf.tv2];
//        [weakSelf requestDataWithToken:token andPtype:@"2" andCompletion:@"complete" andPage:@"1" andRows:@"10" forTableView:weakSelf.tv2];
//        [weakSelf requestDataWithToken:token andPtype:@"3" andCompletion:@"complete" andPage:@"1" andRows:@"10" forTableView:weakSelf.tv2];
        
    }];
    
    [self.tv2 addLegendFooterWithRefreshingBlock:^{
        if ((weakSelf.currentPageIndex * ROWS.integerValue) >= weakSelf.currentTotal.integerValue) {
            [weakSelf.view makeToast:dTips_noMoreData duration:ToastDuration position:CSToastPositionCenter];
            [weakSelf.tv2.footer endRefreshing];
        }else{
            weakSelf.currentPageIndex++;
            [weakSelf requestDataWithToken:token andCompletion:@"unfinished" andPage:[NSString stringWithFormat:@"%ld",(long)weakSelf.currentPageIndex] andRows:ROWS forTableView:weakSelf.tv2];
        }
    }];


    self.tv2.tag = TVTAG + 1;
    self.tv2.dataSource = self;
    self.tv2.delegate = self;
//    tv2.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:self.tv2];
    
    self.currentTableView = self.tv1;
    
//    self.orderNavigationController = 
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag - TVTAG) {
        case 0:
        {
//            return [[self.dataArr1 objectAtIndex:section] count];
            return self.dataArr1.count;
        }
        case 1:
        {
//            return [[self.dataArr2 objectAtIndex:section] count];
            return self.dataArr2.count;
        }
            break;
//        case 2:
//        {
//            //            return [[self.dataArr2 objectAtIndex:section] count];
//            return 1;
//        }
//            break;
        default:
            return 5;
            break;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     Cell_Order * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[Cell_Order alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Model_OrderDesc * model = nil;
//评价
//    cell.btn3.tag = indexPath.row;
//    [cell.btn3 addTarget:self action:@selector(cellBtnAction3:) forControlEvents:UIControlEventTouchUpInside];
    
    //当前订单状态
    
    
    
    switch (tableView.tag - TVTAG) {
        case 0://未完成的订单
        {
            
            model = self.dataArr1[indexPath.row];
            NSLog(@"model = %@",model);
            self.currentModel = model;
            cell.model = model;
            NSInteger orderState = model.current_state.integerValue;
//            UIButton * btn1 = cell.btn1;
//            UIButton * btn2 = cell.btn2;
//            UIButton * btn3 = cell.btn3;
            
//按钮2的设置
            [cell.btn2 addTarget:self action:@selector(pushOrderDetailVC:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn2.tag = indexPath.row;
            
            
            
            
//按钮1的设置
            if (self.source == PushSourceSendOrder) {
                //发的订单
                if (cell.btn1) {
                    if (orderState == 2) {
                        if ([model.ptype isEqualToString:@"1"]) {//竞单
                            cell.btn1.hidden = NO;
                            [cell.btn1 setTitle:@"查看竞单者" forState:UIControlStateNormal];
                            [cell.btn1 addTarget:self action:@selector(reviewListAction:) forControlEvents:UIControlEventTouchUpInside];
                            cell.btn1.tag = indexPath.row;
                        }else if([model.ptype isEqualToString:@"2"]) {//邀单
                            cell.btn1.hidden = NO;
                            [cell.btn1 setTitle:@"查看邀单者" forState:UIControlStateNormal];
                            [cell.btn1 addTarget:self action:@selector(reviewListAction:) forControlEvents:UIControlEventTouchUpInside];
                            cell.btn1.tag = indexPath.row;
                        }else{//抢单
                            cell.btn1.hidden = YES;
                        }

                    }else if (orderState != 1 && orderState != 2 && orderState != 4){
                        cell.btn1.hidden = NO;
                        [cell.btn1 setTitle:@"联系对方" forState:UIControlStateNormal];
                        [cell.btn1 addTarget:self action:@selector(contactSellUserAction:) forControlEvents:UIControlEventTouchUpInside];
                        cell.btn1.tag = indexPath.row;
                        
                    }
                }
                
                if (orderState == 2) {
                    [cell.btn3 setTitle:@"取消订单" forState:UIControlStateNormal];
                    [cell.btn3 addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
                    cell.btn3.tag = indexPath.row;
                }else if (orderState >= 3){
                    [cell.btn3 setTitle:@"确认收货" forState:UIControlStateNormal];
                    [cell.btn3 addTarget:self action:@selector(confirmReciAction:) forControlEvents:UIControlEventTouchUpInside];
                    cell.btn3.tag = indexPath.row;
                }else{
                    NSLog(@"~~~~~~ orderState = %d",orderState);
                    NSLog(@"测试");
                }


            }else{
                //接的订单
                if (cell.btn1) {
                    cell.btn1.hidden = NO;
                    [cell.btn1 setTitle:@"联系对方" forState:UIControlStateNormal];
                    [cell.btn1 addTarget:self action:@selector(contactBuyUserAction:) forControlEvents:UIControlEventTouchUpInside];
                    cell.btn1.tag = indexPath.row;
                }
                if (orderState != 11) {
                    [cell.btn3 setTitle:@"确认发货" forState:UIControlStateNormal];
                    [cell.btn3 addTarget:self action:@selector(confirmSendGoods:) forControlEvents:UIControlEventTouchUpInside];
                    cell.btn3.tag = indexPath.row;
                }else{
                    [cell.btn3 setTitle:@"已发货" forState:UIControlStateNormal];
                    //[cell.btn3 addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
                }
                
            }
            
//按钮3的设置
 //           if (self.source == PushSourceSendOrder) {
                //发的订单
                
//                if (orderState == 2) {
//                    [cell.btn3 setTitle:@"取消订单" forState:UIControlStateNormal];
//                    [cell.btn3 addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
//                    cell.btn3.tag = indexPath.row;
//                }else if (orderState >= 3){
//                    [cell.btn3 setTitle:@"确认收货" forState:UIControlStateNormal];
//                    [cell.btn3 addTarget:self action:@selector(confirmReciAction:) forControlEvents:UIControlEventTouchUpInside];
//                    cell.btn3.tag = indexPath.row;
//                }else{
//                    NSLog(@"测试");
//                }
                
//            }else{
//                if (model.current_state.integerValue != 11) {
//                    [cell.btn3 setTitle:@"确认发货" forState:UIControlStateNormal];
//                    [cell.btn3 addTarget:self action:@selector(confirmSendGoods:) forControlEvents:UIControlEventTouchUpInside];
//                    cell.btn3.tag = indexPath.row;
//                }else{
//                    
//                }
//                
//            }
            
//            [btn1 addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [btn2 addTarget:self action:@selector(btnAction2:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [btn3 addTarget:self action:@selector(btnAction3:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
        {
            //已完成的订单
            model = self.dataArr2[indexPath.row];
            self.currentModel = model;
            cell.model = model;
            NSInteger orderState = model.current_state.integerValue;
            NSLog(@"%@",model.evaluate_state);
            
//            UIButton * btn1 = cell.btn1;
//            UIButton * btn2 = cell.btn2;
//            UIButton * btn3 = cell.btn3;
            
            [cell.btn2 addTarget:self action:@selector(pushOrderDetailVC:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn2.tag = indexPath.row;
            
            if (self.source == PushSourceSendOrder) {
                //发的订单
                [cell.btn1 setTitle:@"联系对方" forState:UIControlStateNormal];
                [cell.btn1 addTarget:self action:@selector(contactSellUserAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.btn1.tag = indexPath.row;
                
            }else{
                [cell.btn1 setTitle:@"联系对方" forState:UIControlStateNormal];
                [cell.btn1 addTarget:self action:@selector(contactBuyUserAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.btn1.tag = indexPath.row;
            }
            
            
            [cell.btn3 setTitle:@"评价" forState:UIControlStateNormal];
            cell.btn3.tag = indexPath.row;
            if (orderState == 6) {
                if (model.evaluate_state.integerValue == 0) {
                    [cell.btn3 setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
                    [cell.btn3 addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
                }else{
                    [cell.btn3 setTitleColor:[UIColor colorWithHexString:@"BEBEBE"] forState:UIControlStateNormal];
                    [cell.btn3 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
                }
                
            }else{
                [cell.btn3 setTitleColor:[UIColor colorWithHexString:@"BEBEBE"] forState:UIControlStateNormal];
            }
            
            
            
            
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - Action
///取消订单
- (void)cancelOrderAction:(UIButton *)btn
{
    WEAK_SELF(weakSelf);
    NSString * token = [UserInfoTool getToken];
    Model_Order * curModel = self.dataArr1[btn.tag];
    if (token && ![token isEqualToString:@""]) {
        [OrderRequestTool cancelOrderWithToken:token andProcessID:curModel.id andFlagApprove:@"1" andSuccessed:^(id model) {
            Model_Request * requestModel = model;
            [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
            if ([requestModel.state isEqualToString:dStateSuccess]) {
                [weakSelf.dataArr1 removeObjectAtIndex:btn.tag];
                [weakSelf.currentTableView reloadData];
            }
        } andFailed:^(NSError *err) {
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];
    }
    
}
///确认发货
- (void)confirmSendGoods:(UIButton *)btn
{
    WEAK_SELF(weakSelf);
    Model_Order * curModel = self.dataArr1[btn.tag];
    [OrderRequestTool confirmOrderWithProcessID:curModel.id andSuccessed:^(id model) {
        Model_Request * requestModel = model;
        [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
        if ([requestModel.state isEqualToString:dStateSuccess]) {
            weakSelf.currentModel.current_state = @"11";
            [weakSelf.dataArr1 replaceObjectAtIndex:btn.tag withObject:weakSelf.currentModel];
            [weakSelf.currentTableView reloadData];
        }
    } andFailed:^(NSError *err) {
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}
///确认收货
-(void)confirmReciAction:(UIButton *)btn
{
    WEAK_SELF(weakSelf);
    Model_Order * curModel = self.dataArr1[btn.tag];
   [OrderRequestTool confirmFinishOrderWithProcessID:curModel.id andSuccessed:^(id model) {
       Model_Request * requestModel = model;
       [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
       if ([requestModel.state isEqualToString:dStateSuccess]) {
           [weakSelf.dataArr1 removeObjectAtIndex:btn.tag];
           [weakSelf.currentTableView reloadData];
       }
   } andFailed:^(NSError *err) {
       [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
   }];
}

//查看订单详情
- (void)pushOrderDetailVC:(UIButton *)btn
{
    WEAK_SELF(weakSelf);
    
    Model_Order * curModel = [[Model_Order alloc]init];
    if (self.currentTableView.tag == TVTAG) {
        curModel = self.dataArr1[btn.tag];
    }else{
        curModel = self.dataArr2[btn.tag];
    }
    
    
    OrderDetail_AViewController * detailVC = [[OrderDetail_AViewController alloc]init];
    detailVC.curID = curModel.id;
    [weakSelf.navigationController pushViewController:detailVC animated:YES];
    
    
    
}

//- (void)btnAction1:(UIButton *)btn
//{
//    NSLog(@"-------- btnAction1");
//}
//- (void)btnAction2:(UIButton *)btn
//{
//    NSLog(@"-------- btnAction2");
//    
//    OrderDetailViewController * orderDetailVC = [[OrderDetailViewController alloc]init];
//    NSLog(@"orderID = %@",self.currentModel.id);
//    orderDetailVC.orderID = self.currentModel.id;
//    
//    [self.navigationController pushViewController:orderDetailVC animated:YES];
//    
//}
- (void)evaluateAction:(UIButton *)btn
{
    NSLog(@"评价点击");
    NSLog(@"btn.tag = %d",btn.tag);
    
    
    
    NSLog(@"self.currentTableView.tag = %ld",(long)self.source);
    NSLog(@"self.currentTableView.tag = %ld",self.currentTableView.tag);
    
    if (self.currentTableView.tag - TVTAG == 1) {
        AssessmentViewController * assessVC = [[AssessmentViewController alloc]init];
        Model_OrderDesc * model = self.dataArr2[btn.tag];
        assessVC.model = model;
        if (self.source == PushSourceSendOrder) {
            assessVC.reviewType = ReviewTypeSendHelp;
        }else{
            assessVC.reviewType = ReviewTypeHelpTo;
        }
        [self.navigationController pushViewController:assessVC animated:YES];

    }
    //
//    NSLog(@"-------- btnAction3");
////    if (self.segmentedControl.selectedSegmentIndex == 1) {
////        AssessmentViewController * assessVC = [[AssessmentViewController alloc]init];
////        [self.navigationController pushViewController:assessVC animated:YES];
//
////    }
//    
}

- (void)selectTagAction
{
    NSLog(@"筛选");
    [UserInfoTool saveCurrentTVTag:[NSString stringWithFormat:@"%ld",(long)self.currentTableView.tag]];
    [self.slidingViewController anchorTopViewToLeftAnimated:YES];
}

-(void)contactBuyUserAction:(UIButton *)btn
{
    NSLog(@"测试你好");
    WEAK_SELF(weakSelf);
    //获取发单者账户
    Model_Order * curModel;
    if (self.currentTableView.tag - TVTAG == 0) {
        curModel = self.dataArr1[btn.tag];
    }else{
        curModel = self.dataArr2[btn.tag];
    }
    
    [OrderRequestTool queryBuyUserNameWithProcessID:curModel.id andSuccessed:^(id model) {
        Model_SearchAccount * requestModel = model;
        if ([requestModel.state isEqualToString:dStateSuccess]) {
            //根据账户获取用户头像
            [UserRequestTool returnHeadPortraitInfofromAccount:requestModel.responseText.account andSuccessed:^(id model) {
                Model_SearchHeadPortrait * searchModel = model;
                if ([searchModel.state isEqualToString:dStateSuccess]) {
//                    if (searchModel.responseText.head_portrait_url && ![searchModel.responseText.head_portrait_url isEqualToString:@""]) {
                        //跳转聊天页面
                        [weakSelf pushChatVCwithAccount:requestModel.responseText.account andHeadUrl:searchModel.responseText.head_portrait_url andModel:requestModel.responseText];
                    //}
                }
            } andFailed:^(NSError *err) {
                NSLog(@"err = %@",err);
            }];
        }
    } andFailed:^(NSError *err) {
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}

- (void)contactSellUserAction:(UIButton*)btn
{
    NSLog(@"测试你好");
    WEAK_SELF(weakSelf);
    //获取发单者账户
    Model_Order * curModel;
    if (self.currentTableView.tag - TVTAG == 0) {
        curModel = self.dataArr1[btn.tag];
    }else{
        curModel = self.dataArr2[btn.tag];
    }
    [OrderRequestTool querySellUserNameWithProcessID:curModel.id andSuccessed:^(id model) {
        Model_SearchAccount * requestModel = model;
        if ([requestModel.state isEqualToString:dStateSuccess]) {
            //根据账户获取用户头像
            [UserRequestTool returnHeadPortraitInfofromAccount:requestModel.responseText.account andSuccessed:^(id model) {
                Model_SearchHeadPortrait * searchModel = model;
                if ([searchModel.state isEqualToString:dStateSuccess]) {
                    //                    if (searchModel.responseText.head_portrait_url && ![searchModel.responseText.head_portrait_url isEqualToString:@""]) {
                    //跳转聊天页面
                    [weakSelf pushChatVCwithAccount:requestModel.responseText.account andHeadUrl:searchModel.responseText.head_portrait_url andModel:requestModel.responseText];
                    //}
                }
            } andFailed:^(NSError *err) {
                NSLog(@"err = %@",err);
            }];
        }
    } andFailed:^(NSError *err) {
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}
///跳转到聊天界面
-(void)pushChatVCwithAccount:(NSString *)account
                  andHeadUrl:(NSString *)url
                    andModel:(Model_InviteUser *)model
{
    ChatViewController * chatVC = [[ChatViewController alloc]initWithChatter:account isGroup:NO];
    chatVC.title = model.nickname;
    [self.navigationController pushViewController:chatVC animated:YES];
}


- (void)reviewListAction:(UIButton *)btn
{
    Model_Order * curModel = self.dataArr1[btn.tag];
    InviteOrCompeteListVC * listVC = [[InviteOrCompeteListVC alloc]init];
    listVC.currentOrderID = curModel.id;
    if (curModel.ptype.integerValue == 2) {//获取邀单者列表
        listVC.type = 1;
        listVC.title = @"邀单者";
        
    }else if (curModel.ptype.integerValue == 1){//获取竞单者列表
        listVC.type = 2;
        listVC.title = @"竞单者";
        
    }
    
    [self.navigationController pushViewController:listVC animated:YES];
    
    
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------ indexPath.section = %d,indexPath.row = %d",indexPath.section,indexPath.row);
    ConnectPersonViewController * connectVC = [[ConnectPersonViewController alloc]init];
    if (indexPath.section == 1) {
        connectVC.type = 1;
        [self.navigationController pushViewController:connectVC animated:YES];
    }else if (indexPath.section ==2){
        connectVC.type = 2;
        [self.navigationController pushViewController:connectVC animated:YES];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSLog(@"切换");
    if (scrollView.tag == 5) {
        NSInteger page = scrollView.contentOffset.x / kMainScreenWidth;
        NSLog(@"page = %d",page);
        if (page == 0) {
            self.currentTableView = self.tv1;
            
        }else{
            self.currentTableView = self.tv2;
        }
        
        [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    }
    
    //    CGFloat pageWidth = scrollView.frame.size.width;
   
    
}
- (void)backAction
{
    NSLog(@"返回");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIStatusBarStyle) preferredStatusBarStyle {
    //状态栏变色
    return UIStatusBarStyleLightContent;
}

#pragma mark - Request

- (void)requestDataWithToken:(NSString *)token
               andCompletion:(NSString *)completion
                     andPage:(NSString *)page
                     andRows:(NSString *)rows
                forTableView:(UITableView *)tableView
{
    
    NSLog(@"tableView = %@",tableView);
    WEAK_SELF(weakSelf);
    NSLog(@"page = %@",page);
    NSLog(@"rows = %@",rows);
    NSString * currentUrl = nil;
    if (self.source == PushSourceSendOrder) {
        currentUrl = @"permissions/order/myrelease";
    }else{
        currentUrl = @"permissions/order/mypickup";
    }
    
    
//    if (!ptype.length>0) {
//        ptype = @"";
//    }
//    if (!labelID.length>0) {
//        labelID = @"";
//    }
    NSLog(@"tableView.tag = %d",tableView.tag);
    
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    [param setValue:completion forKey:@"completion"];
    [param setValue:page forKey:@"page"];
    [param setValue:rows forKey:@"rows"];
    
    [param setValue:[UserInfoTool getCurrentPtype] forKey:@"ptype"];
    [param setValue:[UserInfoTool getCurrentLabelID] forKey:@"lableID"];

    
    NSLog(@"param = %@",param);
    [AFNHttpTools requestWithUrl:currentUrl andPostDict:param successed:^(NSDictionary *dict) {
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"json = %@",json);
        Model_SearchOrder * searchModel = [[Model_SearchOrder alloc]initWithString:json error:nil];
        weakSelf.currentTotal = searchModel.responseText.total;
        NSLog(@"%@",searchModel.state);
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            [tableView.header endRefreshing];
            [tableView.footer endRefreshing];
            if (tableView.tag == TVTAG) {
                [self.dataArr1 addObjectsFromArray:searchModel.responseText.rows];
                
            }else{
                [self.dataArr2 addObjectsFromArray:searchModel.responseText.rows];
            }
            [tableView reloadData];
            //存储数据
            //刷新tableview
            //            if([ptype isEqualToString:@"3"]){//最后一个获取完结束刷新
            //                [tableView.header endRefreshing];
            //            }
        }else if ([searchModel.state isEqualToString:dStateTokenInvalid]) {
            [self.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            [self.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
            //            if([ptype isEqualToString:@"3"]){//最后一个获取完结束刷新
            [tableView.header endRefreshing];
            [tableView.footer endRefreshing];
            //            }
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        //        if([ptype isEqualToString:@"3"]){//最后一个获取完结束刷新
        [tableView.header endRefreshing];
        [tableView.footer endRefreshing];
        //        }
    }];
    
    
    
    
    
//    [AFNHttpTools requestWithUrl:currentUrl successed:^(NSDictionary *dict) {
//        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
//        NSLog(@"json = %@",json);
//        Model_SearchOrder * searchModel = [[Model_SearchOrder alloc]initWithString:json error:nil];
//        NSLog(@"%@",searchModel.state);
//        if ([searchModel.state isEqualToString:dStateSuccess]) {
//            [tableView.header endRefreshing];
//            if (tableView.tag == 100) {
//                [self.dataArr1 addObjectsFromArray:searchModel.responseText.rows];
//                
//            }else{
//                [self.dataArr2 addObjectsFromArray:searchModel.responseText.rows];
//            }
//            [tableView reloadData];
//            //存储数据
//            //刷新tableview
////            if([ptype isEqualToString:@"3"]){//最后一个获取完结束刷新
////                [tableView.header endRefreshing];
////            }
//        }else{
//            [self.view makeToast:searchModel.message duration:1.0 position:CSToastPositionCenter];
////            if([ptype isEqualToString:@"3"]){//最后一个获取完结束刷新
////                [tableView.header endRefreshing];
////            }
//        }
//    } failed:^(NSError *err) {
//        NSLog(@"err = %@",[err localizedDescription]);
//        [self.view makeToast:dTips_connectionError duration:1.0 position:CSToastPositionCenter];
////        if([ptype isEqualToString:@"3"]){//最后一个获取完结束刷新
////            [tableView.header endRefreshing];
////        }
//    }andKeyVaulePairs:@"access_token",token,@"completion",completion,@"page",page,@"rows",rows,@"ptype",ptype,@"lableID",labelID, nil];
}

- (void)refreshTVData
{
    self.currentTableView = (UITableView *)[self.scrollView viewWithTag:[UserInfoTool getCurrentTVTag].integerValue];
    [self.currentTableView.header beginRefreshing];
}

-(void)dealloc
{
    NSLog(@"测试");
//    [UserInfoTool deleteCurrentLabelID];
//    [UserInfoTool deleteCurrentPtype];
//    [UserInfoTool deleteCurrentTVTag];
}










@end
