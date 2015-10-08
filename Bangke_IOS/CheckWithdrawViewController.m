//
//  CheckWithdrawViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/9/9.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "CheckWithdrawViewController.h"
#import "AlipayTool.h"
#import "Model_SearchRecharge.h"

@interface CheckWithdrawViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation CheckWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现核对";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(okAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.hidesBackButton = YES;
    
    [self createUI];
    
}

- (void)createUI
{
    self.displayLabel.text = [NSString stringWithFormat:@"你即将提现%@元给%@账户",self.money,self.currentAccount.alipay_account];
    UIView * passwordLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
    UILabel * label1  = [UILabel new];
    label1.text = @"确认密码:";
    [passwordLV addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(passwordLV).with.insets(UIEdgeInsetsMake(0, 10, 0, 0));
    }];
    self.passwordTF.secureTextEntry = YES;
    self.passwordTF.leftView = passwordLV;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.placeholder = @"请输入帮客密码";
}

#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)okAction
{
    [self.passwordTF resignFirstResponder];
    if ([self.passwordTF.text isEqualToString:[UserInfoTool getPWD]]) {
        WEAK_SELF(weakSelf);
                if ([UserInfoTool getToken] && ![[UserInfoTool getToken] isEqualToString:@""]) {
                    [AlipayTool requestWithdrawWithToken:[UserInfoTool getToken] andMoney:self.money andAccount:self.currentAccount.alipay_account andUsername:self.currentAccount.alipay_username andSuccessed:^(id model) {
                        Model_SearchRecharge * searchModel = model;
                        [weakSelf.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
                        
                    } andFailed:^(NSError *err) {
                        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
                    }];
                }
                

    }else{
        [self.view makeToast:@"密码输入错误，请重新输入" duration:ToastDuration position:CSToastPositionCenter];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}


@end
