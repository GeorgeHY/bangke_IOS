//
//  WithDrawViewController.m
//  Bangke_IOS
//
//  Created by admin on 15/8/29.
//  Copyright (c) 2015年 iwind. All rights reserved.
//
#define CELLHEIGHT 44
#import "WithDrawViewController.h"
#import "Cell_AlipayAccount.h"
#import "AlipayTool.h"
#import "AddAliaccountViewController.h"
#import "Model_SearchUserAlipay.h"
#import "RegTools.h"
#import "Model_SearchRecharge.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "CheckWithdrawViewController.h"

static NSString * cellIdentifier = @"cell";

@interface WithDrawViewController () <UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UITextField * moneyTF;

@end

@implementation WithDrawViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestAlipayaccount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArr = [NSMutableArray array];
    //[self.dataArr addObject:@"1"];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(withdrawAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.hidesBackButton = YES;
    [self createUI];
}

- (void)createUI
{
    WEAK_SELF(weakSelf);
    //现金输入框
    self.moneyTF = [UITextField new];
    [self.view addSubview:self.moneyTF];
    [self.moneyTF showPlaceHolder];
    [self.moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(64);
        make.height.equalTo(@60);
        
    }];
    self.moneyTF.backgroundColor = [UIColor whiteColor];
    self.moneyTF.placeholder = @"请输入账户名";
    self.moneyTF.delegate = self;
    
    UIView * moneyLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
    UILabel * label1  = [UILabel new];
    label1.text = @"金额";
    [moneyLV addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(moneyLV).with.insets(UIEdgeInsetsMake(0, 10, 0, 0));
    }];
    self.moneyTF.leftView = moneyLV;
    self.moneyTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    //支付宝账户显示
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.mas_equalTo(weakSelf.moneyTF.mas_bottom).with.offset(10);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(0);
    }];
    
    
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    [self.tableView showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;//点中没有颜色
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
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArr[indexPath.row];
        cell.delegate = self;
        cell.rightUtilityButtons = [self rightButtons];
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"add"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"add"];
        }
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
                    [weakSelf.dataArr removeAllObjects];
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

- (void)withdrawAction
{
    
    [self.moneyTF resignFirstResponder];
    
    
    WEAK_SELF(weakSelf);
    if (!self.dataArr.count > 0) {
        [self.view makeToast:@"请先绑定支付宝账户" duration:ToastDuration position:CSToastPositionCenter];
    }else{
        Model_UserAlipay * currentAccount = [self.dataArr firstObject];
        
        if ([RegTools regResultWithRechargeMoney:self.moneyTF.text]) {
            CheckWithdrawViewController * checkVC = [[CheckWithdrawViewController alloc]initWithNibName:@"CheckWithdrawViewController" bundle:nil];
            checkVC.currentAccount = currentAccount;
            checkVC.money = weakSelf.moneyTF.text;
            [weakSelf.navigationController pushViewController:checkVC animated:YES];

        }else{
            [self.view makeToast:@"请输入正确金额" duration:ToastDuration position:CSToastPositionCenter];
        }
        
    }
}

#pragma mark - 调用支付宝
- (void)alipayActionWithRechargeInfo:(Model_RechargeInfo *)info
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088611034184895";
    NSString *seller = @"2088611034184895";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANu+FKbuBAn9ngOh8G/WqjNwiNkgfq7jf1svFHvTERRvaElkduYHTgZtS+guQmIDNRoDT1iIDa3dy4IhocicfOMreIdd5iadME2YZSNkhlbt9ooP3c+gAgAgp7SH+WBDKrrSRGMtAyGl4Tq3fjp2PfM0pflCM0iiStMYRq/WbOQhAgMBAAECgYA8+hAtCltgkloo0+Uug7kTMSUoa1X8HfEXUocynS1eKFQeGZzM1DYYnnez5DJTlGRF5ak8/fQdzTBN2htU2efldlND66ZmMmPQ++WpAc08y9qfVLbG4bVDLMAyu2EXSOwnM2BZC3aJPjgrisZEHKihauG+EXblfKwpseM4lGFLKQJBAPVc8ieGeJ3FkMZrzMqUhgsuZ3gVNP+YGkR3ero9/6fv58QHF4V1oBl7pMIEjPp3aTwLDLJd7FfizoFAFqdBKTcCQQDlRMvRPeXJckqiMDmVJ7GB6ecV8CMi4ASE5KQPnRpc9kwJtov8646Z3MqJT+ncG0B4GJ2+PrnLaSOO4GMxAKlnAkEA6QjR5MBOpmoRyqJv6qeNd+km1GIv5+FqcUSZB3IC8llkYkXqDRNeb1WDcdIoo2nuRNypvm5+HiqHvzJDUa8NmQJAaLt+p/0wpU+SjHifNWXGjuQ87iaexmWzasnPsFpCGslgfudnF4i7wcm8s/FPkX7ZeoM0PB4HXcaPucsDRPVabQJBANjNjMTCGxfF72g3y84bY6gvK/Kj6AvgYnMp8kHypDtF9aUzG4O3vFf+CxpvbEQsSw75KSKvHCTfVRDsj3IxAHY=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = info.process_recode_id; //订单ID（由商家自行制定）
    order.productName = info.descrip; //商品标题
    order.productDescription = info.descrip; //商品描述
    order.amount = info.money; //商品价格
    order.notifyURL = info.url; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"BangkePay";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
        
        //        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
