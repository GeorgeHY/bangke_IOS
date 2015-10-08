//
//  InviteOrCompeteListVC.m
//  Bangke_IOS
//
//  Created by iwind on 15/7/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "InviteOrCompeteListVC.h"
#import "Cell_Invite.h"
#import "Cell_Compete.h"
#import "Model_SearchInvite.h"
#import "UIView+BlocksKit.h"


static NSString * inviteIdentifier = @"inviteID";
static NSString * competeIdentifier = @"competeID";

@interface InviteOrCompeteListVC()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSString * curBiddingID;

@end

@implementation InviteOrCompeteListVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.hidesBackButton =　YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    [self createUI];
    [self requestData];
    
}

- (void)createUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (self.type == 1) {
        [self.tableView registerNib:[UINib nibWithNibName:@"Cell_Invite" bundle:nil] forCellReuseIdentifier:inviteIdentifier];
    }else{
        [self.tableView registerNib:[UINib nibWithNibName:@"Cell_Compete" bundle:nil] forCellReuseIdentifier:competeIdentifier];
    }
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == 1) {
        Cell_Invite * cell = [tableView dequeueReusableCellWithIdentifier:inviteIdentifier forIndexPath:indexPath];
        Model_InviteUser * model = self.dataArr[indexPath.row];
        cell.model = model;
        return cell;
    }else{
        Cell_Compete * cell = [tableView dequeueReusableCellWithIdentifier:competeIdentifier forIndexPath:indexPath];
        [cell.headIV bk_whenTapped:^{
            NSLog(@"进入用户评价详情");
        }];
        
        Model_InviteUser * model = self.dataArr[indexPath.row];
        cell.model = model;
        return cell;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.type == 1) {
        return 108;
    }else{
        return 120;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF(weakSelf);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.type == 2) {
        NSLog(@"选择竞单者");
        //竞单
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"是否选择当前用户" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        Model_InviteUser * model = self.dataArr[indexPath.row];
        self.curBiddingID = model.process_bidding_id;
        
    }
}

#pragma mark - Request
///选择竞单者
- (void)selectCompeteUser
{
    WEAK_SELF(weakSelf);
    NSString * token = [UserInfoTool getToken];
    if (token && ![token isEqualToString:@""]) {
        [OrderRequestTool selectCompeteUserWithToken:token andProcessId:self.currentOrderID andBiddingID:self.curBiddingID andSuccessed:^(id model) {
            Model_Request * requestModel = model;
            [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
            if ([requestModel.state isEqualToString:dStateSuccess]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } andFailed:^(NSError *err) {
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];
    }

}

- (void)requestData
{
    WEAK_SELF(weakSelf);
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:self.currentOrderID forKey:@"processId"];
    
    [AFNHttpTools requestWithUrl:@"order/querybindprocess" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchInvite * searchModel = [[Model_SearchInvite alloc]initWithString:jsonStr error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            [weakSelf.dataArr addObjectsFromArray:searchModel.responseText];
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view makeToast:searchModel.message duration:0.5 position:CSToastPositionCenter];
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [weakSelf.view makeToast:dTips_connectionError duration:0.5 position:CSToastPositionCenter];
    }];
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [self selectCompeteUser];
            
            break;
            
        default:
            break;
    }
}


@end
