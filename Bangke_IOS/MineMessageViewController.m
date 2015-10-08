//
//  MineMessageViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "MineMessageViewController.h"
#import "HMSegmentedControl.h"
#import "Cell_MineMsg.h"
#import "Model_Msg.h"
#import "Cell_SystemMsg.h"
@interface MineMessageViewController () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) HMSegmentedControl * segmentedControl;
@property (nonatomic, strong) NSMutableArray * dataArr1;
@property (nonatomic, strong) NSMutableArray * dataArr2;
@property (nonatomic, strong) NSMutableArray * dataArr3;
@property (nonatomic, strong) NSArray * iconArr;
@property (nonatomic, strong) NSArray * titleArr;


@end

@implementation MineMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self createUI];
    
//测试数据
    NSArray * arr1 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    NSArray * arr2 = [NSArray arrayWithObjects:@"one",@"two", nil];
    NSArray * arr3 = [NSArray arrayWithObjects:@"",@"Tuesday",@"Wednesday", nil];
    self.iconArr = [NSArray arrayWithObjects:@"圆角矩形 2",@"图层 1",@"图层 2",@"图层 3fuwu", nil];
    self.titleArr = [NSArray arrayWithObjects:@"0元抢积分",@"服务提醒",@"待办事项",@"服务中心", nil];
    
    self.dataArr1 = [NSMutableArray array];
    [self.dataArr1 addObjectsFromArray:arr1];
    self.dataArr2 = [NSMutableArray array];
    [self.dataArr2 addObjectsFromArray:arr2];
    self.dataArr3 = [NSMutableArray array];
    [self.dataArr3  addObjectsFromArray:arr3];
}
-(void)createUI
{
//segmentedControl
    self.segmentedControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 50)];
    self.segmentedControl.type = HMSegmentedControlTypeText;
    self.segmentedControl.sectionTitles = @[@"接单消息",@"发单消息",@"系统消息"];
//    UIImage * image1 = [UIImage imageNamed:@"收支明细-下拉-3_03"];
//    UIImage * image2 = [UIImage imageNamed:@"收支明细-下拉-4_03"];
//    UIImage * image3 = [UIImage imageNamed:@"收支明细-下拉-6_03"];
//    self.segmentedControl.sectionImages = @[image1,image2,image3];
    self.segmentedControl.selectedSegmentIndex = 1;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.tag = 3;
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(kMainScreenWidth * index, 0, kMainScreenWidth, kMainScreenHeight-114) animated:YES];
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
    [self.scrollView scrollRectToVisible:CGRectMake(kMainScreenWidth, 0, kMainScreenWidth, 300) animated:NO];
    [self.view addSubview:self.scrollView];
    self.scrollView.tag = 5;//避免与tableview冲突
    
//接单消息TableView
    UITableView * tv1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-114)];
    tv1.tag = 0;
    tv1.dataSource = self;
    tv1.delegate = self;
//    tv1.backgroundColor = [UIColor redColor];
    //[tv1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.scrollView addSubview:tv1];
//发单消息TableView
    UITableView * tv2 = [[UITableView alloc]initWithFrame:CGRectMake(kMainScreenWidth, 0, kMainScreenWidth, kMainScreenHeight-114)];
    tv2.tag = 1;
    tv2.dataSource = self;
    tv2.delegate = self;
//    tv2.backgroundColor = [UIColor yellowColor];
    //[tv2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [self.scrollView addSubview:tv2];
//系统消息TableView
    UITableView * tv3 = [[UITableView alloc]initWithFrame:CGRectMake(kMainScreenWidth * 2, 0, kMainScreenWidth, kMainScreenHeight-114)];
    tv3.tag = 2;
    tv3.dataSource = self;
    tv3.delegate = self;
//    tv3.backgroundColor = [UIColor blueColor];
    [tv3 registerNib:[UINib nibWithNibName:@"Cell_SystemMsg" bundle:nil] forCellReuseIdentifier:@"Cell_SystemMsg"];

    [self.scrollView addSubview:tv3];

    

    

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"-------TableView切换");
    if (scrollView.tag == 5) {
        NSInteger page = scrollView.contentOffset.x / kMainScreenWidth;
        
        [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return self.dataArr1.count;
    }else if (tableView.tag == 1){
        return self.dataArr2.count;
    }else if (tableView.tag == 2){
        return self.iconArr.count;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 0://接单消息
        {
            Cell_MineMsg * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[Cell_MineMsg alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            //if (indexPath.row == 0) {
                Model_Msg * model = [[Model_Msg alloc]init];
                model.title = @"我要买大豆皮";
                model.time = @"11:11";
                model.stateMsg = @"用户xxxxxxxxxx已成功抢单";
                cell.model = model;
            //}
            return cell;
        }
            
            break;
        case 1://发单消息
        {
            Cell_MineMsg * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[Cell_MineMsg alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            //if (indexPath.row == 0) {
                Model_Msg * model = [[Model_Msg alloc]init];
                model.title = @"我要卖大豆皮";
                model.time = @"22:22";
                model.stateMsg = @"用户aaaaaaaaaaaaaaaaaa已成功抢单";
                cell.model = model;
            //}
            return cell;
        }
            break;
        case 2://系统消息
        {
            Cell_SystemMsg * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_SystemMsg" forIndexPath:indexPath];
                         //cell.textLabel.text = self.dataArr3[indexPath.row];
            cell.iconIV.image = [UIImage imageNamed:self.iconArr[indexPath.row]];
            cell.titleLabel.text = self.titleArr[indexPath.row];
            return cell;
        }
            break;
        default:
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            return cell;
        }
            break;
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 0:
            return 130;
            break;
        case 1:
            return 130;
            break;
        case 2:
            return 70;
            break;
            
        default:
            return 40;
            break;
    }
}

#pragma mark - Action
- (void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (UIStatusBarStyle) preferredStatusBarStyle {
    //状态栏变色
    return UIStatusBarStyleLightContent;
}

@end
