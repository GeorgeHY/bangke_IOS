//
//  SelectHelpPeopleViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "SelectHelpPeopleViewController.h"
#import "HMSegmentedControl.h"
#import "Cell_Compete.h"
#import "Model_SearchUserAbbr.h"
#import "MJRefresh.h"
#import "CreateOrderViewController.h"
#import "Model_SearchInvite.h"
#define TableViewTag 200

@interface SelectHelpPeopleViewController () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) HMSegmentedControl * segmentedControl;
@property (nonatomic, strong) NSMutableArray * dataArr1;
@property (nonatomic, strong) NSMutableArray * dataArr2;
@property (nonatomic, strong) NSMutableArray * dataArr3;
@property (nonatomic, strong) NSMutableArray * dataArr4;
@property (nonatomic, strong) UITableView * currentTV;


@end

@implementation SelectHelpPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    self.title = @"邀单";
    [self createUI];
    [self initArr];
    
}

- (void)createUI
{
    //segmentedControl
    self.segmentedControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 50)];
    self.segmentedControl.type = HMSegmentedControlTypeText;
    //self.segmentedControl.sectionTitles = @[@"全部",@"我的朋友",@"商家",@"我的社区"];
    self.segmentedControl.sectionTitles = @[@"全部",@"商家",@"我的社区"];
    //    UIImage * image1 = [UIImage imageNamed:@"收支明细-下拉-3_03"];
    //    UIImage * image2 = [UIImage imageNamed:@"收支明细-下拉-4_03"];
    //    UIImage * image3 = [UIImage imageNamed:@"收支明细-下拉-6_03"];
    //    self.segmentedControl.sectionImages = @[image1,image2,image3];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.tag = 10;
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(kMainScreenWidth * index, 0, kMainScreenWidth, kMainScreenHeight-114) animated:YES];
        weakSelf.currentTV = (UITableView *)[weakSelf.scrollView viewWithTag:(TableViewTag + index)];
        [weakSelf.currentTV.header beginRefreshing];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    //scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame), kMainScreenWidth, kMainScreenHeight-114)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    [self.scrollView showPlaceHolderWithLineColor:[UIColor whiteColor]];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(kMainScreenWidth * 3, 300);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, kMainScreenWidth, 300) animated:NO];
    [self.view addSubview:self.scrollView];
    self.scrollView.tag = 5;//避免与tableview冲突
    
    //接单消息TableView
    UITableView * tv1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-114)];
    tv1.tag = TableViewTag;
    tv1.dataSource = self;
    tv1.delegate = self;
    tv1.backgroundColor = [UIColor redColor];
    [tv1 registerNib:[UINib nibWithNibName:@"Cell_Compete" bundle:nil] forCellReuseIdentifier:@"cell"];
    [tv1 addLegendHeaderWithRefreshingBlock:^{
        [weakSelf.dataArr1 removeAllObjects];
        [weakSelf requestDataWithType:nil andSj:nil];
    }];
    [self.scrollView addSubview:tv1];
    self.currentTV = tv1;
    
    [self.currentTV.header beginRefreshing];
    //发单消息TableView
    UITableView * tv2 = [[UITableView alloc]initWithFrame:CGRectMake(kMainScreenWidth, 0, kMainScreenWidth, kMainScreenHeight-114)];
    tv2.tag = TableViewTag + 1;
    tv2.dataSource = self;
    tv2.delegate = self;
    tv2.backgroundColor = [UIColor yellowColor];
    [tv2 registerNib:[UINib nibWithNibName:@"Cell_Compete" bundle:nil] forCellReuseIdentifier:@"cell"];
    [tv2 addLegendHeaderWithRefreshingBlock:^{
        [weakSelf.dataArr1 removeAllObjects];
        [weakSelf requestDataWithType:@"3" andSj:nil];
    }];
    
    [self.scrollView addSubview:tv2];
    //系统消息TableView
    UITableView * tv3 = [[UITableView alloc]initWithFrame:CGRectMake(kMainScreenWidth * 2, 0, kMainScreenWidth, kMainScreenHeight-114)];
    tv3.tag = TableViewTag + 2;
    tv3.dataSource = self;
    tv3.delegate = self;
    tv3.backgroundColor = [UIColor blueColor];
    [tv3 registerNib:[UINib nibWithNibName:@"Cell_Compete" bundle:nil] forCellReuseIdentifier:@"cell"];
    [tv3 addLegendHeaderWithRefreshingBlock:^{
        [weakSelf.dataArr1 removeAllObjects];
        [weakSelf requestDataWithType:nil andSj:@"sj"];
    }];
    
    [self.scrollView addSubview:tv3];
    
    //系统消息TableView
//    UITableView * tv4 = [[UITableView alloc]initWithFrame:CGRectMake(kMainScreenWidth * 3, 0, kMainScreenWidth, kMainScreenHeight-114)];
//    tv4.tag = 3;
//    tv4.dataSource = self;
//    tv4.delegate = self;
//    tv4.backgroundColor = [UIColor blueColor];
//    [tv4 registerNib:[UINib nibWithNibName:@"Cell_Compete" bundle:nil] forCellReuseIdentifier:@"cell"];
//    [self.scrollView addSubview:tv4];
}

- (void)initArr
{
    self.dataArr1 = [NSMutableArray array];
    self.dataArr2 = [NSMutableArray array];
    self.dataArr3 = [NSMutableArray array];
    self.dataArr4 = [NSMutableArray array];
}

#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ((tableView.tag - TableViewTag) == 0) {
        return self.dataArr1.count;
    }else if ((tableView.tag - TableViewTag) == 1){
        return self.dataArr1.count;
    }else if ((tableView.tag - TableViewTag) == 2){
        return self.dataArr1.count;
    }else{
        return 5;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_Compete * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch ((tableView.tag - TableViewTag)) {
        case 0:
        {
            Model_InviteUser * model = self.dataArr1[indexPath.row];
            cell.model = model;
        }
            break;
        case 1:
        {
            Model_InviteUser * model = self.dataArr1[indexPath.row];
            cell.model = model;
        }
            break;
        case 2:
        {
            Model_InviteUser * model = self.dataArr1[indexPath.row];
            cell.model = model;
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RECTFIX_HEIGHT(150);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView.tag == 0) {
    Model_InviteUser * userModel = self.dataArr1[indexPath.row];
    Model_TypeCallBack * model = [[Model_TypeCallBack alloc]init];
    model.type = 2;
    [model.peopleArr addObject:userModel.account];
    
    self.decideType(model);
    
//        [UserInfoTool saveCurrentAccountID:model.account];
//        [UserInfoTool saveInviteFlag:@"1"];
    for (UIViewController * endVc in self.navigationController.viewControllers) {
        if ([endVc isKindOfClass:[CreateOrderViewController class]]) {
            [self.navigationController popToViewController:endVc animated:YES];
        }
    }
//    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"-------TableView切换");
    if (scrollView.tag == 5) {
        NSInteger page = scrollView.contentOffset.x / kMainScreenWidth;
        self.currentTV = (UITableView *)[self.scrollView viewWithTag:TableViewTag + page];
        //        [self requestDataWithCategoryID:categoryID andPageIndex:@"1" andNums:@"3"];
        
        [self.currentTV.header beginRefreshing];
        
        [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    }
}
#pragma mark - Request
///
- (void)requestDataWithType:(NSString *)type
                      andSj:(NSString *)sj
{
    WEAK_SELF(weakSelf);
    NSString * token = [UserInfoTool getToken];
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    [param setValue:type forKey:@"type"];
    [param setValue:sj forKey:@"sj"];
    NSLog(@"param = %@",param);
    
    [AFNHttpTools requestWithUrl:@"permissions/user/queryUserList" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchInvite * searchModel = [[Model_SearchInvite alloc]initWithString:jsonStr error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            [weakSelf.currentTV.header endRefreshing];
            [weakSelf.dataArr1 addObjectsFromArray:searchModel.responseText];
            [weakSelf.currentTV reloadData];
        }else if ([searchModel.state isEqualToString:dStateTokenInvalid]) {
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            //[weakSelf.view makeToast:searchModel.message duration:1.0 position:CSToastPositionCenter];
            [weakSelf.currentTV.header endRefreshing];
            
        }

    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        //[weakSelf.view makeToast:dTips_connectionError duration:1.0 position:CSToastPositionCenter];
        [weakSelf.currentTV.header endRefreshing];
    }];
    
    
}

#pragma mark - block
- (void)returnTypeModel:(CallBackTypeModel)model
{
    if (model) {
        self.decideType = model;
    }
    
}



@end
