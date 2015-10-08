//
//  AddAliaccountViewController.m
//  Bangke_IOS
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "AddAliaccountViewController.h"
#import "AlipayTool.h"
#import "Model_Request.h"
@interface AddAliaccountViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField * accountTF;
@property (nonatomic, strong) UITextField * usernameTF;

@end

@implementation AddAliaccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加账户";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"绑定" style:UIBarButtonItemStyleDone target:self action:@selector(bindAlipayAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem setTintColor:[UIColor whiteColor]];
    
    
    self.navigationItem.hidesBackButton = YES;
    [self createUI];
    
}
- (void)createUI
{
    WEAK_SELF(weakSelf);
    //支付宝账户
    self.accountTF = [UITextField new];
    [self.view addSubview:self.accountTF];
    [self.accountTF showPlaceHolder];
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(64);
        make.height.equalTo(@60);
        
    }];
    self.accountTF.backgroundColor = [UIColor whiteColor];
    self.accountTF.placeholder = @"请输入账户名";
    self.accountTF.delegate = self;
    
    UIView * accountLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
    UILabel * label1  = [UILabel new];
    label1.text = @"支付宝账户";
    [accountLV addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(accountLV).with.insets(UIEdgeInsetsMake(0, 10, 0, 0));
    }];
    self.accountTF.leftView = accountLV;
    self.accountTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    
    
    //账户别名
    self.usernameTF = [UITextField new];
    [self.view addSubview:self.usernameTF];
    [self.usernameTF showPlaceHolder];
    [self.usernameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.accountTF.mas_bottom).with.offset(2);
        make.height.equalTo(@60);
        
    }];
    self.usernameTF.backgroundColor = [UIColor whiteColor];
    self.usernameTF.placeholder = @"请输入别名";
    self.usernameTF.delegate = self;
    
    
    UIView * usernameLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
    UILabel * label2  = [UILabel new];
    label2.text = @"账户别名";
    [usernameLV addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(usernameLV).with.insets(UIEdgeInsetsMake(0, 10, 0, 0));
    }];
    self.usernameTF.leftView = usernameLV;
    self.usernameTF.leftViewMode = UITextFieldViewModeAlways;
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)bindAlipayAction
{
    NSLog(@"测试");
    WEAK_SELF(weakSelf);
    if (self.accountTF.text && ![self.accountTF.text isEqualToString:@""] && self.usernameTF.text && ![self.usernameTF.text isEqualToString:@""]) {
        if ([UserInfoTool getToken]&& ![[UserInfoTool getToken] isEqualToString:@""]) {
            [AlipayTool requestBindAlipayWithToken:[UserInfoTool getToken] andAccount:self.accountTF.text andUsername:self.usernameTF.text andSuccessed:^(id model) {
                Model_Request * requestModel = model;
                [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
                if ([requestModel.state isEqualToString:dStateSuccess]) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            } andFailed:^(NSError *err) {
                [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
            }];
        }
    }else{
        [self.view makeToast:@"请输入完整信息" duration:ToastDuration position:CSToastPositionCenter];
    }
    
    
}




@end
