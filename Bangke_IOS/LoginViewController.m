//
//  LoginViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/4/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "MMPlaceHolder.h"
#import "UIColor+AddColor.h"
#import "ChangePasswordViewController.h"
#import "RegisterViewController.h"
#import "UserInfoTool.h"
#import "AppDelegate.h"
#import "UserRequestTool.h"
#import "Model_SearchUser.h"

@interface LoginViewController() <UITextFieldDelegate>
@property (nonatomic, strong) UITextField * usernameTF;
@property (nonatomic, strong) UITextField * passwordTF;
@property (nonatomic, strong) NSString * currentAccount;//帮客ID

@end
@implementation LoginViewController

- (void)createUI
{
    WEAK_SELF(weakSelf);
    //背景图
    UIImageView * backgroundIV = [UIImageView new];
    backgroundIV.image = [UIImage imageNamed:@"登陆-背景"];
    [self.view addSubview:backgroundIV];
//    [backgroundIV showPlaceHolder];
    [backgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.top.equalTo (weakSelf.view.mas_top).with.offset(0);
        
    }];
    backgroundIV.userInteractionEnabled = YES;
    
    //logo
    UIImageView * logoIV = [UIImageView new];
    logoIV.image = [UIImage imageNamed:@"登陆logo"];
    [self.view addSubview:logoIV];
//    [logoIV showPlaceHolder];
    [logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundIV.mas_centerX);
        make.width.equalTo(@(kMainScreenWidth * 0.3));
        make.height.equalTo(@(kMainScreenWidth * 0.3));
        make.top.equalTo(backgroundIV.mas_top).with.offset(100);
        
    }];
    logoIV.layer.masksToBounds = YES;
    logoIV.layer.cornerRadius = ((kMainScreenWidth * 0.3)/2);
    
    UIButton * cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 50, 40)];
    [cancelBtn setTitle:@"首页" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [backgroundIV addSubview:cancelBtn];
    
    //登录名输入框
    self.usernameTF = [UITextField new];
    [backgroundIV addSubview:self.usernameTF];
    [self.usernameTF showPlaceHolder];
    [self.usernameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundIV.mas_left).with.offset(20);
        make.right.equalTo(backgroundIV.mas_right).with.offset(-20);
        make.top.equalTo(logoIV.mas_bottom).with.offset (50);
        make.height.equalTo(@40);
        
    }];
    self.usernameTF.backgroundColor = [UIColor whiteColor];
    self.usernameTF.placeholder = @"请输入手机号码";
    self.usernameTF.layer.masksToBounds = YES;
    self.usernameTF.layer.cornerRadius = 5;
    self.usernameTF.delegate = self;
//    self.usernameTF.text = @"admin";
    
    UIView * usernameLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView * iv1  = [UIImageView new];
    iv1.image = [UIImage imageNamed:@"登陆-电话"];
    [usernameLV addSubview:iv1];
    [iv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(usernameLV).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    self.usernameTF.leftView = usernameLV;
    self.usernameTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    //密码输入框
    self.passwordTF = [UITextField new];
    self.passwordTF.secureTextEntry = YES;
    [backgroundIV addSubview:self.passwordTF];
    [self.passwordTF showPlaceHolder];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundIV.mas_left).with.offset(20);
        make.right.equalTo(backgroundIV.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.usernameTF.mas_bottom).with.offset (10);
        make.height.equalTo(@40);
        
    }];
    self.passwordTF.backgroundColor = [UIColor whiteColor];
    self.passwordTF.placeholder = @"请输入密码";
    self.passwordTF.layer.masksToBounds = YES;
    self.passwordTF.layer.cornerRadius = 5;
    self.passwordTF.delegate = self;
//    self.passwordTF.text = @"admin";
    UIView * passwordLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView * iv2  = [UIImageView new];
    iv2.image = [UIImage imageNamed:@"登陆-锁"];
    [passwordLV addSubview:iv2];
    [iv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(passwordLV).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    self.passwordTF.leftView = passwordLV;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
    //忘记密码
    UIButton * forgetBtn = [UIButton new];
    [backgroundIV addSubview:forgetBtn];
//    [forgetBtn showPlaceHolder];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundIV.mas_right).with.offset(-20);
        make.top.equalTo(weakSelf.passwordTF.mas_bottom).with.offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"fa9924"] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //登陆btn
    UIButton * loginBtn = [UIButton new];
    [backgroundIV addSubview:loginBtn];
//    [loginBtn showPlaceHolder];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundIV.mas_left).with.offset(20);
        make.right.equalTo(backgroundIV.mas_right).with.offset(-20);
        make.top.equalTo(forgetBtn.mas_bottom).with.offset (20);
        make.height.equalTo(@40);
        
    }];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"fa9924"];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    //注册
    UIButton * registerBtn = [UIButton new];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundIV.mas_right).with.offset(-20);
        make.top.equalTo(loginBtn.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(160, 30));
    }];
    [registerBtn setTitle:@"您还没有注册吗？" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [registerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self createUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - Action

- (void)cancelAction
{
    [[AppDelegate shareInstance] setHomePageVC];
}

- (void)loginAction
{
    WEAK_SELF(weakSelf);
    NSString * cid = [UserInfoTool getGeXinClientID];
    NSLog(@"cid = %@",cid);
    [AFNHttpTools requestTokenWithUrl:@"oauth/token" successed:^(NSDictionary *dict) {
        NSLog(@"dict = %@",dict);
        NSString * value = [dict objectForKey:@"value"];
        NSString * access_token = [dict objectForKey:@"access_token"];
        if ((value&&![value isEqualToString:@""])||(access_token&&![access_token isEqualToString:@""])) {
            if (cid.length > 0) {
                [weakSelf sendGeXinCID:cid andUserName:weakSelf.usernameTF.text];
            }
            if (value&&![value isEqualToString:@""]) {
                [UserInfoTool saveToken:value];
                [UserRequestTool getconfigWithToken:value andSuccessed:nil andFailed:nil];
            }else{
                [UserInfoTool saveToken:access_token];
                [UserRequestTool getconfigWithToken:access_token andSuccessed:nil andFailed:nil];
            }
            
            [UserInfoTool saveUserName:weakSelf.usernameTF.text];
            [UserInfoTool savePWD:weakSelf.passwordTF.text];
//            EMError * error = nil;
//            NSDictionary * loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:weakSelf.usernameTF.text password:weakSelf.passwordTF.text error:&error];
//            if (!error && loginInfo) {
//                NSLog(@"环信登陆成功");
//            }
            [self returnAccountIDfromUserInfo];
            
            [[AppDelegate shareInstance] setHomePageVC];
            [[AppDelegate shareInstance].homeNavi.view addGestureRecognizer:[AppDelegate shareInstance].slidingViewController.panGesture];
//            [weakSelf dismissViewControllerAnimated:YES completion:^{
//                [[AppDelegate shareInstance].homeNavi.view addGestureRecognizer:[AppDelegate shareInstance].slidingViewController.panGesture];
//            }];
        }else{
            [weakSelf.view makeToast:@"登录失败" duration:ToastDuration position:CSToastPositionCenter];
        }
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",err);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    } andKeyVaulePairs:@"client_id",@"tonr",@"client_secret",@"secret",@"grant_type",@"password",@"username",self.usernameTF.text,@"password",self.passwordTF.text, nil];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)forgetAction:(UIButton *)btn
{
    NSLog(@"忘记密码");
    ChangePasswordViewController * changeVC = [[ChangePasswordViewController alloc]init];
    changeVC.source = 1;
    [self.navigationController pushViewController:changeVC animated:YES];

}

-(void)registerAction:(UIButton *)btn
{
    NSLog(@"注册事件");
    RegisterViewController * regVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    //状态栏变色
    return UIStatusBarStyleDefault;
}

- (void)sendGeXinCID:(NSString *)cid
         andUserName:(NSString *)username
{
    
    [AFNHttpTools requestWithUrl:@"partner/bingGeXinAppClient" successed:^(NSDictionary *dict) {
        NSLog(@"dict = %@",dict);
        NSString * state = [dict objectForKey:@"state"];
        if ([state isEqualToString:dStateSuccess]) {
            NSLog(@"cid上传成功");
        }else{
            NSLog(@"cid上传失败");
        }
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
    } andKeyVaulePairs:@"userId",username,@"clientId",cid, nil];
}

///查询个人信息返回帮客ID
-(void)returnAccountIDfromUserInfo
{
    WEAK_SELF(weakSelf);
    if ([UserInfoTool getToken] && ![[UserInfoTool getToken] isEqualToString:@""]) {
        [UserRequestTool requestPersonInfoWithToken:[UserInfoTool getToken] andSuccessed:^(id model) {
            Model_SearchUser * searchModel = model;
            if ([searchModel.state isEqualToString:dStateSuccess]) {
                //登陆环信
                [UserInfoTool saveCurrentAccountID:searchModel.responseText.account];
                [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:searchModel.responseText.account password:@"123456" completion:^(NSDictionary *loginInfo, EMError *error) {
                        NSLog(@"-------- loginInfo = %@",loginInfo);
                        NSLog(@"-------- error = %@",error);
                } onQueue:nil];
            }
        } andFailed:^(NSError *err) {
            NSLog(@"err = %@",err);
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];
    }
    
}

@end
