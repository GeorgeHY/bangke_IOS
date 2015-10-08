//
//  BillViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "BillViewController.h"
#import "Cell_Bill.h"
//#import "Model_Bill.h"
#import "REMenu.h"
#import "UserInfoTool.h"
#import "Model_SearchBill.h"
#import "MJRefresh.h"

#define ROWS @"10"

static NSString * cellIdentifier = @"Cell_Bill";


@interface BillViewController () <UITableViewDelegate,UITableViewDataSource,REMenuDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) REMenu * menu;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSString * currentStype;
@property (nonatomic, strong) UIButton * menuBtn;
@property (nonatomic, assign) NSInteger curTotal;//当前数据总数
@property (nonatomic, assign) NSInteger curPage;//当前页数
@property (nonatomic, strong) UIImageView * arrowIV;
@end

@implementation BillViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WEAK_SELF(weakSelf);
    self.dataArr = [NSMutableArray array];
    self.navigationController.navigationBar.hidden = YES;
    UINavigationBar * naviBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [naviBar setBarTintColor:[UIColor colorWithHexString:NAVICOLOR]];
    [self.view addSubview:naviBar];
    UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"箭头17px_03"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:leftBtn];
    
    //barBtn
    self.menuBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, kStatusBarHeight, 120, 44)];
    self.menuBtn.center = CGPointMake(kMainScreenWidth/2, naviBar.frame.size.height/2+10);
    [self.menuBtn setTitle:@"收支明细" forState:UIControlStateNormal];
    [self.menuBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    self.menuBtn.backgroundColor = [UIColor clearColor];
    [naviBar addSubview:self.menuBtn];
    //箭头
    self.arrowIV = [[UIImageView alloc]init];
    [naviBar addSubview:self.arrowIV];
    [self.arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.menuBtn.mas_centerY).with.offset(2);
        make.left.mas_equalTo(weakSelf.menuBtn.mas_right).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(15, 8));
        
    }];
    self.arrowIV.image = [UIImage imageNamed:@"nav_xialajiantou_2x"];
    
    
    
    //remenu
    //第一个菜单View
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 200, 40)];
    UIImageView * iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, view1.frame.size.height-10, view1.frame.size.height-10)];
    iv1.image = [UIImage imageNamed:@"收支明细-下拉-3_03"];
    [view1 addSubview:iv1];
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iv1.frame)+20, 10, kMainScreenWidth-CGRectGetMaxX(iv1.frame)-40,  view1.frame.size.height-10)];
    label1.text = @"全部";
    [view1 addSubview:label1];
    view1.backgroundColor = [UIColor whiteColor];
    //第二个菜单View
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    UIImageView * iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, view2.frame.size.height-10, view2.frame.size.height-10)];
    iv2.image = [UIImage imageNamed:@"收支明细-下拉-1_03"];
    [view2 addSubview:iv2];
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iv2.frame)+20, 10, kMainScreenWidth-CGRectGetMaxX(iv2.frame)-40,  view2.frame.size.height-10)];
    label2.text = @"收入";
    [view2 addSubview:label2];
    view2.backgroundColor = [UIColor whiteColor];
    //第三个菜单View
    UIView * view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    UIImageView * iv3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, view3.frame.size.height-10, view3.frame.size.height-10)];
    iv3.image = [UIImage imageNamed:@"收支明细-下拉-2_03"];
    [view3 addSubview:iv3];
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iv3.frame)+20, 10, kMainScreenWidth-CGRectGetMaxX(iv3.frame)-40,  view3.frame.size.height-10)];
    label3.text = @"支出";
    [view3 addSubview:label3];
    view3.backgroundColor = [UIColor whiteColor];
    
    
    REMenuItem * allItem = [[REMenuItem alloc]initWithCustomView:view1 action:^(REMenuItem *item) {
        NSLog(@"全部");
        iv1.image =[UIImage imageNamed:@"收支明细-下拉-3_03"];
        label1.textColor = [UIColor colorWithHexString:@"FA9924"];
        //复原
        iv2.image = [UIImage imageNamed:@"收支明细-下拉-1_03"];
        iv3.image = [UIImage imageNamed:@"收支明细-下拉-2_03"];
        label2.textColor = [UIColor colorWithHexString:@"333333"];
        label3.textColor = [UIColor colorWithHexString:@"333333"];
        self.currentStype = @"ALL";
//        [self.menuBtn setTitle:@"全部" forState:UIControlStateNormal];
        [self.tableView.header beginRefreshing];
        
        
    }];
    REMenuItem * inItem = [[REMenuItem alloc]initWithCustomView:view2 action:^(REMenuItem *item) {
        NSLog(@"收入");
        iv2.image =[UIImage imageNamed:@"收支明细-下拉-6_03"];
        label2.textColor = [UIColor colorWithHexString:@"FA9924"];
        //复原
        iv1.image = [UIImage imageNamed:@"收支明细-下拉-5_03"];
        iv3.image = [UIImage imageNamed:@"收支明细-下拉-2_03"];
        label1.textColor = [UIColor colorWithHexString:@"333333"];
        label3.textColor = [UIColor colorWithHexString:@"333333"];
        self.currentStype = @"income";
//        [self.menuBtn setTitle:@"收入" forState:UIControlStateNormal];
        [self.tableView.header beginRefreshing];
        
        
    }];
    REMenuItem * outItem = [[REMenuItem alloc]initWithCustomView:view3 action:^(REMenuItem *item) {
        NSLog(@"支出");
        iv3.image =[UIImage imageNamed:@"收支明细-下拉-4_03"];
        label3.textColor = [UIColor colorWithHexString:@"FA9924"];
        //复原
        iv1.image = [UIImage imageNamed:@"收支明细-下拉-5_03"];
        iv2.image = [UIImage imageNamed:@"收支明细-下拉-1_03"];
        label1.textColor = [UIColor colorWithHexString:@"333333"];
        label2.textColor = [UIColor colorWithHexString:@"333333"];
        self.currentStype = @"out";
//        [self.menuBtn setTitle:@"支出" forState:UIControlStateNormal];
        [self.tableView.header beginRefreshing];
        
    }]
    ;
    self.menu = [[REMenu alloc]initWithItems:@[allItem,inItem,outItem]];
    self.menu.borderColor = [UIColor colorWithHexString:@"AAAAAA"];
    self.menu.separatorColor = [UIColor colorWithHexString:@"AAAAAA"];
    self.menu.separatorHeight = 1;
    //    self.view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 84, 320, 568-64)];
    //    [self.view addSubview:self.view4];
    [self.menu close];
    [self.menu showInView:self.tableView];
    if (!self.currentStype.length > 0) {
        self.currentStype = @"ALL";
        self.curPage = 1;
    }
    if (self.tableView) {
        [self.tableView.header beginRefreshing];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;
    
    
    if (!self.currentStype.length > 0) {
        self.currentStype = @"ALL";
        self.curPage = 1;
    }
    [self createUI];
}

- (void)createUI
{
    WEAK_SELF(weakSelf);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"Cell_Bill" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf.dataArr removeAllObjects];
        weakSelf.curPage = 1;
        [weakSelf requestDataWithStype:weakSelf.currentStype andPage:1];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        if (weakSelf.curPage * ROWS.integerValue >= weakSelf.curTotal) {
            [weakSelf.view makeToast:@"没有更多数据了" duration:ToastDuration position:CSToastPositionCenter];
            [weakSelf.tableView.footer endRefreshing];
        }else{
            weakSelf.curPage++;
            [weakSelf requestDataWithStype:weakSelf.currentStype andPage:weakSelf.curPage];
        }
        
    }];
    
    [self.view addSubview:self.tableView];
    
    
    
    
}

- (void)requestDataWithStype:(NSString *)stype
                     andPage:(NSInteger)page
{
    WEAK_SELF(weakSelf);
    [AFNHttpTools requestWithUrl:@"permissions/baseuser/moneylist" successed:^(NSDictionary *dict) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"json = %@",json);
        Model_SearchBill * searchModel = [[Model_SearchBill alloc]initWithString:json error:nil];
        NSLog(@"searchModel.state = %@",searchModel.state);
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            self.curTotal = searchModel.responseText.total.integerValue;
            [self.dataArr addObjectsFromArray:searchModel.responseText.rows];
            [self.tableView reloadData];
        }else if ([searchModel.state isEqualToString:dStateTokenInvalid]) {
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            [self.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
        }
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",err);
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    } andKeyVaulePairs:@"access_token",[UserInfoTool getToken],@"stype",stype,@"page",[NSString stringWithFormat:@"%d",page],@"rows",ROWS, nil];
}

#pragma mark - Action
-(void)btnAction
{
    if (self.menu.isOpen)
        return [self.menu close];
    
    [self.menu showInView:self.tableView];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_Bill * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Model_Bill * model = self.dataArr[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
