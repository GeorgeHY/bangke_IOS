//
//  OrderModeViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/14.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "OrderModeViewController.h"
#import "SelectHelpPeopleViewController.h"

@interface OrderModeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) NSArray * subTitleArr;
@end

@implementation OrderModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    self.title = @"订单模式";
    [self initDataArr];
    [self initTableView];
    
}
- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}
- (void)initDataArr
{
    self.titleArr = [NSArray arrayWithObjects:@"抢单",@"竞单", nil];
    self.subTitleArr = [NSArray arrayWithObjects:@"只有一个人可以抢到订单",@"多人竞单，价优者得", nil];
}

#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //邀单相关设置
//    if (indexPath.row == 2) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    UILabel * subTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, kMainScreenWidth* 0.6, cell.frame.size.height)];
//    subTitleLbl.backgroundColor = [UIColor yellowColor];
    [cell.contentView addSubview:subTitleLbl];
    subTitleLbl.text = self.subTitleArr[indexPath.row];
    subTitleLbl.textAlignment = NSTextAlignmentLeft;
    subTitleLbl.textColor = [UIColor lightGrayColor];
    subTitleLbl.font = [UIFont systemFontOfSize:14];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {//邀单
//        SelectHelpPeopleViewController * selectPeopleVC = [[SelectHelpPeopleViewController alloc]init];
//        [selectPeopleVC returnTypeModel:self.decideType];
//        [self.navigationController pushViewController:selectPeopleVC animated:YES];
    }else{
        Model_TypeCallBack * model = [[Model_TypeCallBack alloc]init];
        if (indexPath.row == 0) {
            [UserInfoTool deleteInviteFlag];
            model.type = 3;
            self.decideType(model);
        }else{
            [UserInfoTool deleteInviteFlag];
            model.type = 1;
            self.decideType(model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - block
-(void)returnTypeModel:(CallBackTypeModel)model
{
    self.decideType = model;
}

@end
