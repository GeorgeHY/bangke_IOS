//
//  AlipayAccountViewController.m
//  Bangke_IOS
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#define CELLHEIGHT 44
#import "AlipayAccountViewController.h"
#import "Cell_AlipayAccount.h"
#import "AddAliaccountViewController.h"
#import "AlipayTool.h"
#import "Model_SearchUserAlipay.h"
#import "Model_Request.h"

static NSString * cellIdentifier = @"cell";

@interface AlipayAccountViewController ()<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation AlipayAccountViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestAlipayaccount];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的账户";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArr = [NSMutableArray array];
    //[self.dataArr addObject:@"1"];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.hidesBackButton = YES;
    
    
    [self createUI];
}

- (void)createUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, RECTFIX_HEIGHT(65)+64)];
//    [self.tableView showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArr.count >0) {
        return self.dataArr.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataArr.count > 0) {
        Cell_AlipayAccount * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[Cell_AlipayAccount alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArr[indexPath.row];
        cell.delegate = self;
        cell.rightUtilityButtons = [self rightButtons];
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"add"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"add"];
        }
        //cell.backgroundColor = [UIColor clearColor];
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        UILabel * label = [UILabel new];
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).with.insets(UIEdgeInsetsMake(RECTFIX_HEIGHT(15), 0, RECTFIX_HEIGHT(15), 0));
        }];
        label.text = @"添加支付宝账户";
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        return cell;
    }
    
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor redColor] icon:[UIImage imageNamed:@"bt_delete_2x.png"]];

    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewCellDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"测试");
            [self unbindAlipayaccount];
            
            break;
            
        default:
            break;
    }
    
}




#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return RECTFIX_HEIGHT(65);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataArr.count >0) {
        
    }else{
        AddAliaccountViewController * addAliVC = [[AddAliaccountViewController alloc]init];
        [self.navigationController pushViewController:addAliVC animated:YES];
    }
}

- (void) requestAlipayaccount
{
    WEAK_SELF(weakSelf);
    if ([UserInfoTool getToken] && ![[UserInfoTool getToken] isEqualToString:@""]) {
        [AlipayTool requestQueryUserAlipayInfoWithToken:[UserInfoTool getToken] andSuccessed:^(id model) {
            Model_SearchUserAlipay * searchModel = model;
            if ([searchModel.state isEqualToString:dStateSuccess]) {
                if (searchModel.responseText.alipay_account && ![searchModel.responseText.alipay_account isEqualToString:@""] && searchModel.responseText.alipay_username && ![searchModel.responseText.alipay_username isEqualToString:@""]) {
                    [weakSelf.dataArr addObject:searchModel.responseText];
                    [weakSelf.tableView reloadData];
                }
                
            }else{
                [weakSelf.view makeToast:@"查询失败" duration:ToastDuration position:CSToastPositionCenter];
            }
        } andFailed:^(NSError *err) {
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];
    }
    
}

- (void) unbindAlipayaccount
{
    WEAK_SELF(weakSelf);
    if ([UserInfoTool getToken] && ![[UserInfoTool getToken] isEqualToString:@""]) {
         [AlipayTool requestUnbindAlipayWithToken:[UserInfoTool getToken] andSuccessed:^(id model) {
             Model_Request * requestModel = model;
             [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
             if ([requestModel.state isEqualToString:dStateSuccess]) {
                 [weakSelf.dataArr removeAllObjects];
                 [weakSelf.tableView reloadData];
             }
         } andFailed:^(NSError *err) {
             [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
         }];
    }
   
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
