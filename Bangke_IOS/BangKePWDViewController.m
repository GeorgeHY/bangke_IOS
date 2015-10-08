//
//  BangKePWDViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "BangKePWDViewController.h"

@interface BangKePWDViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * titleArr;

@end

@implementation BangKePWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(submitAction)];
    [rightItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    self.title = @"设置密码";
    NSArray * arr1 = [NSArray arrayWithObject:@"账号保护"];
    NSArray * arr2 = [NSArray arrayWithObject:@"手势密码锁定"];
    self.titleArr = [NSMutableArray arrayWithObjects:arr1,arr2, nil];
    [self createUI];
}

- (void)createUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
//            cell.accessoryType = UITableViewCellAccessoryNone;
            UISwitch * switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(kMainScreenWidth*0.8, 10, 50, 50)];
            [cell.contentView addSubview:switchBtn];
            //        [switchBtn showPlaceHolderWithLineColor:[UIColor blackColor]];
            switchBtn.on = YES;
            switchBtn.onTintColor = [UIColor orangeColor];
            [switchBtn addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];

    }
    cell.textLabel.text = [[self.titleArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)submitAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)switchChange
{
    NSLog(@"switchChange");
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    if (section == 1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
        view.backgroundColor = [UIColor lightGrayColor];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kMainScreenWidth-20, 30)];
        label.numberOfLines = 0;
        label.text = @"开启账号保护后，在不常用的手机上登陆帮客，需要验证手机号码";
        label.font = [UIFont systemFontOfSize:14];
        [label sizeToFit];
        [view addSubview:label];
        return view;

        
    }else{
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
        view.backgroundColor = [UIColor lightGrayColor];
        return view;

    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0 && indexPath.row == 1) {
//        BindPhoneNumViewController * bindVC = [[BindPhoneNumViewController alloc]initWithNibName:@"BindPhoneNumViewController" bundle:nil];
//        [self.navigationController pushViewController:bindVC animated:YES];
//    }
}


@end
