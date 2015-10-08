//
//  AccountSafetyViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//
#define CELLHEIGHT 50
#define HEADERVIEWHEIGHT 10
#import "AccountSafetyViewController.h"
#import "BindPhoneNumViewController.h"
#import "BangKePWDViewController.h"
#import "PasswordUpdateViewController.h"

@interface AccountSafetyViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * titleArr;
@property (nonatomic, strong) NSString * bangkeID;
@property (nonatomic, strong) NSString * phoneNumber;


@end

@implementation AccountSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    self.title = @"账号与安全";
    
    NSArray * titleArr1 = [NSArray arrayWithObjects:@"帮客ID",@"手机号", nil];
    NSArray * titleArr2 = [NSArray arrayWithObjects:@"帮客密码", nil];
    
    self.titleArr = [NSMutableArray arrayWithObjects:titleArr1,titleArr2, nil];
    [self createUI];
    self.bangkeID = @"";
    self.phoneNumber = @"";
    if ([UserInfoTool getToken] && [UserInfoTool getToken].length > 0 && ![[UserInfoTool getToken] isEqualToString:@""] ) {
        [self requestUserIDandTelNumberwithToken:[UserInfoTool getToken]];
    }
    
    
}

- (void)createUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 3*CELLHEIGHT + self.titleArr.count * HEADERVIEWHEIGHT + 64)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.titleArr objectAtIndex:section]count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UILabel * label = [UILabel new];
    [cell.contentView addSubview:label];
//    [label showPlaceHolderWithLineColor:[UIColor blackColor]];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cell.contentView.mas_right).with.offset(-20);
        make.top.mas_equalTo(cell.contentView.mas_top).with.offset(0);
        make.bottom.mas_equalTo(cell.contentView.mas_bottom).with.offset(0);
        make.width.equalTo(@(RECTFIX_WIDTH(200)));
        
    }];
    label.textAlignment = NSTextAlignmentRight;
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        label.text = self.bangkeID;
    }else if (indexPath.section == 0 && indexPath.row == 1){
        label.text = self.phoneNumber;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        label.hidden = YES;
    }
    cell.textLabel.text = [[self.titleArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

#pragma  mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELLHEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADERVIEWHEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 1) {
        //绑定手机号
        BindPhoneNumViewController * bindVC = [[BindPhoneNumViewController alloc]initWithNibName:@"BindPhoneNumViewController" bundle:nil];
        bindVC.currentPhone = self.phoneNumber;
        [self.navigationController pushViewController:bindVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        PasswordUpdateViewController * pwdUpdateVC = [[PasswordUpdateViewController alloc]init];
        [self.navigationController pushViewController:pwdUpdateVC animated:YES];
    }
    
    
    
//    if (indexPath.section == 1 && indexPath.row == 1) {
//        BangKePWDViewController * bindVC = [[BangKePWDViewController alloc]init];
//        [self.navigationController pushViewController:bindVC animated:YES];
//    }
}

#pragma mark - Request
-(void)requestUserIDandTelNumberwithToken:(NSString *)token
{
    WEAK_SELF(weakSelf);
    [AFNHttpTools requestWithUrl:@"permissions/selectCenter" successed:^(NSDictionary *dict) {
        NSString * state = [dict objectForKey:@"state"];
        NSString * message = [dict objectForKey:@"message"];
        if ([state isEqualToString:dStateSuccess]) {
            NSDictionary * responseText = [dict objectForKey:@"responseText"];
            if (![responseText isKindOfClass:[NSNull class]]) {
                NSString * telephone = [responseText objectForKey:@"telephone"];
//                NSString * userID = [responseText objectForKey:@"userID"];
                if (![telephone isKindOfClass:[NSNull class]]) {
                    weakSelf.bangkeID = telephone;
                }
//                NSString * username = [responseText objectForKey:@"username"];
                
                if (telephone && ![telephone isEqualToString:@""]){
                    weakSelf.phoneNumber = telephone;
                }
            }
            [weakSelf.tableView reloadData];
        }
        
    } failed:^(NSError *err) {
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    } andKeyVaulePairs:@"access_token",token, nil];
}

@end
