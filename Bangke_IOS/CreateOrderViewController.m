//
//  CreateOrderViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "CreateOrderViewController.h"
#import "Cell_CreateList.h"
#import "Model_CreateList.h"
#import "TestViewController.h"
#import "OrderModeViewController.h"
#import "PayTypeViewController.h"
#import "MineCommunityViewController.h"
#import "HelpContentViewController.h"
#import "AffirmOrderViewController.h"
#import "Model_SearchParentLabel.h"
#import "Model_SearchChildLabel.h"
#import "UserInfoTool.h"
@interface CreateOrderViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * titleArr;
@property (nonatomic, strong) NSMutableArray * ModelArr;
@property (nonatomic, strong) UIWindow * popWindow;
@property (nonatomic, strong) NSArray * iconArr;
@property (nonatomic, strong) UIButton * menuBtn;
@property (nonatomic, strong) UIView * menuView;
@property (nonatomic, strong) UITableView * leftTV;
@property (nonatomic, strong) UITableView * rightTV;
@property (nonatomic, assign) BOOL isMenuBtnSelect;
@property (nonatomic, strong) NSMutableArray * firstArr;
@property (nonatomic, strong) NSMutableArray * secondArr;
@property (nonatomic, strong) NSMutableArray * currentSecondArr;
@property (nonatomic, strong) NSString * currentOrderId;
@property (nonatomic, assign) NSInteger submitFlag;





@end

@implementation CreateOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self createUI];
    [self requestParentLabel];
    
    
    self.popWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    
    self.ModelArr = [NSMutableArray array];
    self.firstArr = [NSMutableArray array];
    self.secondArr = [NSMutableArray array];
    self.currentSecondArr = [NSMutableArray array];
    self.titleArr = [NSMutableArray array];
    NSArray * flagArr = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    
    NSString * bondType = nil;
    if (self.currentPayModel.payType == 1) {
        bondType = @"货到付款";
    }else{
        bondType = @"保证金支付";
    }
    
    if (self.source == 2) {
        
        self.titleArr = [NSMutableArray arrayWithObjects:@"邀单",self.currentContentModel.helpContent,[NSString stringWithFormat:@"%@%@元",bondType,self.currentPayModel.price],@"请输入收货地址",nil];
        self.iconArr = [NSArray arrayWithObjects:@"组 6",@"组 7",@"组 8",@"组 9", nil];
    }else{
        NSString * str = nil;
        if ([UserInfoTool getInviteFlag] != nil) {
            str = @"邀单";
            [self.titleArr replaceObjectAtIndex:0 withObject:str];
        }else{
            str = @"订单模式";
        }
        if (self.currentTypeModel.type == 2) {
            [self.titleArr removeAllObjects];
            self.titleArr = [NSMutableArray arrayWithObjects:@"邀单",@"请输入求助内容",@"请输入金额",@"请输入收货地址",nil];
        }else{
            [self.titleArr removeAllObjects];
            self.titleArr = [NSMutableArray arrayWithObjects:@"订单模式",@"请输入求助内容",@"请输入金额",@"请输入收货地址",nil];
        }
        self.iconArr = [NSArray arrayWithObjects:@"组 6",@"组 7",@"组 8",@"组 9", nil];
    }
    
    
    
    
    
    
    
//    self.firstArr = [NSArray arrayWithObjects:@"美妆",@"家政",@"咨询",@"跑腿",@"其他", nil];
//    self.secondArr = [NSArray arrayWithObjects:
//                      [NSArray arrayWithObjects:@"Item1",@"Item2", nil],
//                      [NSArray arrayWithObjects:@"Item1",@"Item2",@"Item3", nil],
//                      [NSArray arrayWithObjects:@"Item1",@"Item2",@"Item3",@"Item4", nil],
//                      [NSArray arrayWithObjects:@"Item1",@"Item2",@"Item3",@"Item4",@"Item5", nil],
//                      [NSArray arrayWithObjects:@"Item1",@"Item2",@"Item3",@"Item4",@"Item5",@"Item6", nil],
//                      nil];
    
    for (NSInteger i =  0 ; i<4; i++) {
        Model_CreateList * model = [[Model_CreateList alloc]init];
        model.content = self.titleArr[i];
        model.iconName = self.iconArr[i];
        model.flag = flagArr[i];
        [self.ModelArr addObject:model];
    }
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    self.submitFlag = 1;
    NSLog(@"inviteFlag = %@",[UserInfoTool getInviteFlag]);
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%ld",(long)self.currentPayModel.payType);
    
//    if ([UserInfoTool getInviteFlag] && [UserInfoTool getInviteFlag].length > 0 && ![[UserInfoTool getInviteFlag] isEqualToString:@""]) {
//        //[self.titleArr removeAllObjects];
//        self.titleArr = [NSMutableArray arrayWithObjects:@"邀单",@"请输入求助内容",@"请输入金额",@"请输入收货地址",nil];
//    }else{
//        self.titleArr = [NSMutableArray arrayWithObjects:@"订单模式",@"请输入求助内容",@"请输入金额",@"请输入收货地址",nil];
//    }
//    self.iconArr = [NSArray arrayWithObjects:@"组 6",@"组 7",@"组 8",@"组 9", nil];
//    //[self.ModelArr removeAllObjects];
//    for (NSInteger i =  0 ; i<4; i++) {
//        Model_CreateList * model = [[Model_CreateList alloc]init];
//        model.content = self.titleArr[i];
//        model.iconName = self.iconArr[i];
//        //model.flag = flagArr[i];
//        [self.ModelArr addObject:model];
//    }
//    [self.tableView reloadData];

    
    
    NSString * bondType = nil;
    if (self.currentPayModel.payType == 1) {
        bondType = @"货到付款";
    }else{
        bondType = @"保证金支付";
    }


    
        //            str = @"订单模式";
//        }
//        self.titleArr = [NSMutableArray arrayWithObjects:str,@"请输入求助内容",@"请输入金额",@"请输入收货地址",nil];
//        self.iconArr = [NSArray arrayWithObjects:@"组 6",@"组 7",@"组 8",@"组 9", nil];


    
}
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//}

- (void)createUI
{
    WEAK_SELF(weakSelf);
    
    //自定义naviBar
    UINavigationBar * naviBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
//    [naviBar showPlaceHolderWithLineColor:[UIColor blackColor]];
    [naviBar setBarTintColor:[UIColor colorWithHexString:NAVICOLOR]];
    [self.view addSubview:naviBar];
    
    //self.menuBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, kStatusBarHeight, 200, 44)];
    self.menuBtn = [[UIButton alloc]init];
    self.menuBtn.bounds = CGRectMake(0, 0, 200, 44);
    //[self.menuBtn showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.menuBtn.center = CGPointMake(kMainScreenWidth/2, naviBar.frame.size.height/2+10);
    if (self.source == 2) {
        [self.menuBtn setTitle:[NSString stringWithFormat:@"求帮-%@",self.currentLblName] forState:UIControlStateNormal];
    }else{
        [self.menuBtn setTitle:@"求帮-未选择标签" forState:UIControlStateNormal];
    }
    
    [self.menuBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    self.menuBtn.backgroundColor = [UIColor clearColor];
    [naviBar addSubview:self.menuBtn];
    self.isMenuBtnSelect = NO;
    
    
    
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, kStatusBarHeight, 20, 40)];
    [backBtn setImage:[UIImage imageNamed:@"箭头17px_03"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:backBtn];
    //tableview
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight-64-100)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tag = 105;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[Cell_CreateList class] forCellReuseIdentifier:@"Cell"];
    //下拉菜单
    //提交按钮
    
    UIView * btnView = [UIView new];
    [self.view addSubview:btnView];
//    [btnView showPlaceHolderWithLineColor:[UIColor blackColor]];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(0);
        make.height.equalTo(@100);
    }];
    UIButton * submit = [UIButton new];
    [btnView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btnView.mas_left).with.offset(20);
        make.right.mas_equalTo(btnView.mas_right).with.offset(-20);
        make.bottom.mas_equalTo(btnView.mas_bottom).with.offset(-30);
        make.height.equalTo(@40);
        
    }];
    submit.layer.masksToBounds = YES;
    submit.layer.cornerRadius = 5;
    [submit setTitle:@"提  交" forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor orangeColor];
    [submit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.menuView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight * 0.4)];
    self.menuView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.menuView];
    [self.view bringSubviewToFront:self.menuView];
    self.menuView.hidden = YES;
    
    self.leftTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth/2, self.menuView.frame.size.height)];
    [self.menuView addSubview:self.leftTV];
    self.leftTV.tag = 100;
    self.leftTV.delegate = self;
    self.leftTV.dataSource = self;
//    self.leftTV.backgroundColor = [UIColor yellowColor];
    
    self.rightTV = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTV.frame), 0, kMainScreenWidth/2, self.menuView.frame.size.height)];
    self.rightTV.tag = 101;
    self.rightTV.delegate = self;
    self.rightTV.dataSource = self;
    [self.menuView addSubview:self.rightTV];
//    self.rightTV.backgroundColor = [UIColor blueColor];
    
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) {
        return self.firstArr.count;
    }else if (tableView.tag == 101){
        return self.currentSecondArr.count;
    }else{
        return self.ModelArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
        }
        Model_ParentLabel * parentLabel = self.firstArr[indexPath.row];
        cell.textLabel.text = parentLabel.name;
        return cell;
    }else if (tableView.tag == 101){
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightCell"];
        }
        Model_ChildLabel * childLabel = self.currentSecondArr[indexPath.row];
        cell.textLabel.text = childLabel.name;
        return cell;
    }else{
        
        Cell_CreateList * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"forIndexPath:indexPath];
        if (self.source == 2) {
            if (indexPath.row == 0 || indexPath.row == 1) {
                cell.arrowIV.hidden = YES;
            }else{
                cell.arrowIV.hidden = NO;
            }
        }else{
            cell.arrowIV.hidden = NO;
        }
        Model_CreateList * model = self.ModelArr[indexPath.row];
        cell.model = model;
        return cell;
    }
    
    
    
    
//    [self.tableView setNeedsLayout];
    

    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        return 40;
    }else if (tableView.tag == 101){
        return 40;
    }else{
       return 95;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF(weakSelf);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.source == 1) {
        //首页发单按钮进入
        if (tableView.tag == 100) {
            //根据父标签id获取子标签
            Model_ParentLabel * parentLabel = self.firstArr[indexPath.row];
            [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"label/getLabelByPid/%@",parentLabel.id] andParameters:nil successed:^(NSDictionary *dict) {
                NSString * json = [AFNHttpTools jsonStringWithDict:dict];
                Model_SearchChildLabel * searchModel = [[Model_SearchChildLabel alloc]initWithString:json error:nil];
                if ([searchModel.state isEqualToString:dStateSuccess]) {
                    [weakSelf.currentSecondArr removeAllObjects];
                    [weakSelf.currentSecondArr addObjectsFromArray:searchModel.responseText];
                    [weakSelf.rightTV reloadData];
                }else{
                    NSLog(@"fail string = %@",searchModel.message);
                }
                
            } failed:^(NSError *err) {
                NSLog(@"err = %@",[err localizedDescription]);
                [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
            }];
            
            //        [self.currentSecondArr removeAllObjects];
            //        [self.currentSecondArr addObjectsFromArray:self.secondArr[indexPath.row]];
            //        [self.rightTV reloadData];
        }else if(tableView.tag == 101){
            //点击子标签
            self.menuView.hidden = YES;
            Model_ChildLabel * model = self.currentSecondArr[indexPath.row];
            self.currentLblID = model.id;
            [self.menuBtn setTitle:[NSString stringWithFormat:@"求帮-%@",model.name] forState:UIControlStateNormal];
            
        }else{
            if (indexPath.row == 0) {
                OrderModeViewController * modeVC = [[OrderModeViewController alloc]init];
                [modeVC returnTypeModel:^(Model_TypeCallBack *model) {
                    weakSelf.currentTypeModel = model;
                    NSString * type = nil;
                    Model_CreateList * listModel = self.ModelArr[indexPath.row];
                    if (model.type == 1) {
                        type = @"竞单";
                    }else if (model.type == 2) {
//                        type = [NSString stringWithFormat:@"邀单(%lu)",(unsigned long)model.peopleArr.count];
                    }else{
                        type = @"抢单";
                    }
                    listModel.content = type;
                    [tableView reloadData];
                }];
                [weakSelf.navigationController pushViewController:modeVC animated:YES];
                
            }else if (indexPath.row == 1){
                HelpContentViewController * helpVC = [[HelpContentViewController alloc]init];
                [helpVC returnContentModel:^(Model_ContentCallBack *model) {
                    weakSelf.currentContentModel = model;
                    Model_CreateList * listModel = weakSelf.ModelArr[indexPath.row];
                    listModel.content = model.helpContent;
                    [tableView reloadData];
                }];
                if (weakSelf.currentContentModel.helpContent.length > 0) {
                    helpVC.currentModel = weakSelf.currentContentModel;
                }
                [self.navigationController pushViewController:helpVC animated:YES];
            }else if (indexPath.row == 2){
                NSLog(@"%ld",(long)self.currentPayModel.payType);
                PayTypeViewController * payTypeVC = [[PayTypeViewController alloc]init];
                [payTypeVC returnPayModel:^(Model_PayCallBack *model) {
                    weakSelf.currentPayModel = model;
                    Model_CreateList * listModel = weakSelf.ModelArr[indexPath.row];
                    NSString * type = nil;
                    if (model.payType == 1) {
                        type = @"货到付款";
                    }else{
                        type = @"保证金付款";
                    }
                    listModel.content = [NSString  stringWithFormat:@"%@%@元",type,model.price];
                    [tableView reloadData];
                    
                    
                }];
                if (weakSelf.currentPayModel.price.length > 0) {
                    payTypeVC.currentModel = self.currentPayModel;
                }
                
                [weakSelf.navigationController pushViewController:payTypeVC animated:YES];
            }else if (indexPath.row == 3){
                MineCommunityViewController * addressVC = [[MineCommunityViewController alloc]init];
                addressVC.source = 2;
                [addressVC returnCommunityModel:^(Model_Community *model) {
                    weakSelf.currentCommunity = model;
                    Model_CreateList * listModel = weakSelf.ModelArr[indexPath.row];
                    listModel.content = model.receive_address;
                    [tableView reloadData];
                }];
                //            if (self.currentCommunity.receive_address.length > 0) {
                //                addressVC.currentModel = self.currentCommunity;
                //            }
                
                [self.navigationController pushViewController:addressVC animated:YES];
            }
            
        }
    }else{
        //页面进入
                if (tableView.tag == 105) {
                    if (indexPath.row == 2){
                        UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:@"修改支付方式" message:nil delegate:self cancelButtonTitle:@"货到付款" otherButtonTitles:@"保证金支付", nil];
                        [alerView show];
                    }else if (indexPath.row == 3){
                        MineCommunityViewController * addressVC = [[MineCommunityViewController alloc]init];
                        addressVC.source = 2;
                        [addressVC returnCommunityModel:^(Model_Community *model) {
                            weakSelf.currentCommunity = model;
                            Model_CreateList * listModel = weakSelf.ModelArr[indexPath.row];
                            listModel.content = model.receive_address;
                            [tableView reloadData];
                        }];
                        //            if (self.currentCommunity.receive_address.length > 0) {
                        //                addressVC.currentModel = self.currentCommunity;
                        //            }
                        
                        [self.navigationController pushViewController:addressVC animated:YES];
                    }
                }
    }
    
    




    
    
}

#pragma mark - Action
- (void)backAction
{
    [UserInfoTool deleteInviteFlag];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)closeAction:(UIButton *)btn
//{
//    NSLog(@"关闭");
//    [[[[UIApplication sharedApplication].delegate window] viewWithTag:1000] removeFromSuperview];
//}

- (void)submitAction
{
    if (self.submitFlag == 1) {
        [self requestCreateOrder];
        self.submitFlag++;
    }
    
//    AffirmOrderViewController * affirmVC = [[AffirmOrderViewController alloc]init];
//    [self.navigationController pushViewController:affirmVC animated:YES];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    //状态栏变色
    return UIStatusBarStyleLightContent;
}
- (void)btnAction
{
    NSLog(@"弹出菜单");
    self.isMenuBtnSelect = !self.isMenuBtnSelect;
    if (self.isMenuBtnSelect == NO) {
        self.menuView.hidden = YES;
    }else{
        self.menuView.hidden = NO;
    }

}
- (void)pushAffirmVC
{
    
    
}

#pragma mark - RequestAction
- (void)requestParentLabel
{
    [AFNHttpTools getDataWithUrl:@"label/getParentLabel" andParameters:nil successed:^(NSDictionary *dict) {
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"json = %@",json);
        Model_SearchParentLabel * searchModel = [[Model_SearchParentLabel alloc]initWithString:json error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            [self.firstArr removeAllObjects];
            [self.firstArr addObjectsFromArray:searchModel.responseText];
            [self.leftTV reloadData];
        }else{
            NSLog(@"返回信息 = %@",searchModel.message);
        }
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}
- (void)requestCreateOrder
{
    WEAK_SELF(weakSelf);
    AffirmOrderViewController * affirmVC = [[AffirmOrderViewController alloc]init];
    if (self.currentLblID.length > 0) {
        NSLog(@"self.currentCommunity = %@",self.currentCommunity);
        NSLog(@"self.currentContentModel = %@",self.currentContentModel);
        NSLog(@"self.currentPayModel = %@",self.currentPayModel);
        NSLog(@"self.currentTypeModel = %@",self.currentTypeModel);
        NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
        [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
        [param setValue:[NSString stringWithFormat:@"%ld",(long)self.currentTypeModel.type] forKey:@"processType"];
        if (self.currentTypeModel.type == 2) {
            NSString * accountID = self.currentTypeModel.peopleArr[0];
            [param setValue:accountID forKey:@"invitationAccountId"];
        }
//        if ([UserInfoTool getInviteFlag] != nil) {
//            [param setValue:@"2" forKey:@"processType"];
//            [param setValue:[UserInfoTool getCurrentAccountID] forKey:@"invitationAccountId"];
//        }else{
//            [param setValue:[NSString stringWithFormat:@"%d",self.currentTypeModel.type] forKey:@"processType"];
//        }
        
//        if (self.currentTypeModel.type == 2) {
//            
//        }
        [param setValue:self.currentLblID forKey:@"labelID"];
        [param setValue:self.currentContentModel.helpContent forKey:@"content"];
        NSLog(@"overtime = %@",self.currentContentModel.overTime);
        [param setValue:self.currentContentModel.overTime forKey:@"endTimeEx"];
//        NSString * isOrder = nil;
//        if (self.currentContentModel.isOrder == YES) {
//            isOrder = @"2";
//            [param setValue:self.currentContentModel.startTime forKey:@"make_time"];
//            
//        }else{
//            isOrder = @"1";
//            
//        }
        [param setValue:@"1" forKey:@"makeing"];
        [param setValue:self.currentPayModel.price forKey:@"cost_amount"];
        [param setValue:[NSString stringWithFormat:@"%d",self.currentPayModel.payType] forKey:@"bond"];
        
        [param setValue:self.currentCommunity.id forKey:@"addressId"];
        [param setValue:self.currentCommunity.phone forKey:@"phone"];
        [param setValue:self.currentCommunity.contact_name forKey:@"contact_name"];
        if (![self.currentContentModel.images isEqualToString:@""]) {
            [param setValue:self.currentContentModel.images forKey:@"images"];
        }
        
        
        NSLog(@"param = %@",param);
        
        [AFNHttpTools requestWithUrl:@"permissions/beingsingle/release" andPostDict:param successed:^(NSDictionary *dict) {
            NSLog(@"dict = %@",dict);
            NSString * state = [dict objectForKey:@"state"];
            NSString * message = [dict objectForKey:@"message"];
            if ([state isEqualToString:dStateSuccess]) {
                NSString * responseText = [dict objectForKey:@"responseText"];
                weakSelf.currentOrderId = responseText;
                if (weakSelf.currentOrderId.length > 0) {
                    affirmVC.orderID = weakSelf.currentOrderId;
                    [weakSelf.navigationController pushViewController:affirmVC animated:YES];
                }
            }else if ([state isEqualToString:dStateTokenInvalid]) {
                [UserInfoTool deleteToken];
                [APPLICATION setHomePageVC];
            }else{
                [weakSelf.view makeToast:message duration:1.0 position:CSToastPositionCenter];
            }
            
        } failed:^(NSError *err) {
            NSLog(@"err = %@",[err localizedDescription]);
        }];

    }else{
        [self.view makeToast:@"请选择标签" duration:1.0 position:CSToastPositionCenter];
    }
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            self.currentPayModel.payType = 1;
            Model_CreateList * listModel = self.ModelArr[2];
            listModel.content = [NSString  stringWithFormat:@"货到付款%@元",self.currentPayModel.price];
            [self.tableView reloadData];
        }
            break;
        case 1:
        {
            self.currentPayModel.payType = 2;
            Model_CreateList * listModel = self.ModelArr[2];
            listModel.content = [NSString  stringWithFormat:@"保证金支付%@元",self.currentPayModel.price];
            [self.tableView reloadData];
        }
            break;
            
        default:
            break;
    }
}



@end
