//
//  SettingViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountSafetyViewController.h"
#import "FeedbackViewController.h"
#import "AppInfoViewController.h"

@interface SettingViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * titleArr;
@property (nonatomic, strong) NSMutableArray * iconArr;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
//    self.title = @"设置";
    [self createUI];
    NSArray * titleArr1 = [NSArray arrayWithObjects:@"账号与安全", nil];
    NSArray * titleArr2 = [NSArray arrayWithObjects:@"获取最新版本",@"意见反馈", @"清除缓存",@"消息通知",nil];
    NSArray * titleArr3 = [NSArray arrayWithObjects:@"关于我们", nil];
    self.titleArr = [NSMutableArray arrayWithObjects:titleArr1,titleArr2,titleArr3, nil];
    
    NSArray * iconArr1 = [NSArray arrayWithObjects:@"设置_03", nil];
    NSArray * iconArr2 = [NSArray arrayWithObjects:@"设置2_03",@"设置3_03", @"设置4_03",@"设置5_03",nil];
    NSArray * iconArr3 = [NSArray arrayWithObjects:@"设置6_03", nil];
    self.iconArr = [NSMutableArray arrayWithObjects:iconArr1,iconArr2,iconArr3,nil];
    
    
}

-(void)createUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth,RECTFIX_HEIGHT(50)*6 + RECTFIX_HEIGHT(10)*3)];
//    [self.tableView  showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"FAFAFA"];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(20,10 ,30, 30)];
//    iv.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:iv];
    iv.image = [UIImage imageNamed:[[self.iconArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iv.frame)+20, 0, kMainScreenWidth * 0.5, 50)];
    [cell.contentView addSubview:label];
    label.textColor = [UIColor colorWithHexString:@"333333"];
    label.text = [[self.titleArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //还要加一个判断
    if (indexPath.section == 0 && indexPath.row == 0) {
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, 60, 50)];
//        [label1 showPlaceHolderWithLineColor:[UIColor blackColor]];
        [cell.contentView addSubview:label1];
        label1.font = [UIFont systemFontOfSize:14];
        label1.textColor = [UIColor redColor];
        label1.textAlignment = NSTextAlignmentRight;
        label1.text = @"未保护";
    }
    //消息通知开关
    if (indexPath.section == 1 && indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        UISwitch * switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+25, 10, 50, 50)];
        [cell.contentView addSubview:switchBtn];
//        [switchBtn showPlaceHolderWithLineColor:[UIColor blackColor]];
        switchBtn.on = YES;
        switchBtn.onTintColor = [UIColor orangeColor];
        [switchBtn addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
    }
    return cell;
}

#pragma mark - Action
- (void)switchChange
{
    NSLog(@"开关切换");
}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RECTFIX_HEIGHT(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return RECTFIX_HEIGHT(10);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"FAFAFA"];
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        //账号与安全
        AccountSafetyViewController * accountVC = [[AccountSafetyViewController alloc]init];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        //意见反馈
        FeedbackViewController * feedbackVC = [[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        //版本信息
        AppInfoViewController * appInfoVC = [[AppInfoViewController alloc]init];
        [self.navigationController pushViewController:appInfoVC animated:YES];
    }
    
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    //状态栏变色
    return UIStatusBarStyleLightContent;
}


@end
