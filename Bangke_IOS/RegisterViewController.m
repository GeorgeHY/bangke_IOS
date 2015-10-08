//
//  RegisterViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/4/28.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+AddColor.h"
#import "MMPlaceHolder.h"
#import "RegTools.h"
#import "UIView+Toast.h"
#import "SelectTagViewController.h"
#import "UserInfoTool.h"
#import "DVSwitch.h"
#import "UserRequestTool.h"
#import "Model_SearchUser.h"

@interface RegisterViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField * nickNameTF;
@property (nonatomic, strong) UITextField * phoneNumTF;
@property (nonatomic, strong) UITextField * passwordTF;
@property (nonatomic, strong) UITextField * passwordTF2;
@property (nonatomic, strong) UITextField * identiCodeTF;
@property (nonatomic, assign) BOOL selectBtnState;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}
-(void)createUI
{
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.title = @"注册";
//昵称输入框
    self.nickNameTF = [UITextField new];
    [self.view addSubview:self.nickNameTF];
    WEAK_SELF(weakSelf);
    NSInteger padding = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    [self.nickNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(padding);
        make.height.equalTo(@60);
        
    }];
    self.nickNameTF.backgroundColor = [UIColor whiteColor];
    self.nickNameTF.placeholder = @"请输入昵称";
    self.nickNameTF.delegate = self;

    
    UIView * nickNameLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    UIImageView * iv1  = [UIImageView new];
    iv1.image = [UIImage imageNamed:@"注册-1"];
    [nickNameLV addSubview:iv1];
    
    [iv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(nickNameLV).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    self.nickNameTF.leftView = nickNameLV;
    self.nickNameTF.leftViewMode = UITextFieldViewModeAlways;
    
//手机号输入框
    self.phoneNumTF = [UITextField new];
    [self.view addSubview:self.phoneNumTF];
    //    [self.phoneNumTF showPlaceHolder];
    [self.phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.nickNameTF.mas_bottom).with.offset(1);
        make.height.equalTo(@60);
        
    }];
    self.phoneNumTF.backgroundColor = [UIColor whiteColor];
    self.phoneNumTF.placeholder = @"请输入手机号";
    self.phoneNumTF.delegate = self;
    
    UIView * phoneNumLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    UIImageView * iv2  = [UIImageView new];
    iv2.image = [UIImage imageNamed:@"注册-2"];
    [phoneNumLV addSubview:iv2];
    
    [iv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(phoneNumLV).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    self.phoneNumTF.leftView = phoneNumLV;
    self.phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    
//验证码输入框
    self.identiCodeTF = [UITextField new];
    [self.view addSubview:self.identiCodeTF];
    //    [self.identiCodeTF showPlaceHolder];
    [self.identiCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.phoneNumTF.mas_bottom).with.offset (1);
        make.height.equalTo(@60);
        
    }];
    self.identiCodeTF.backgroundColor = [UIColor whiteColor];
    self.identiCodeTF.placeholder = @"请输入验证码";
    self.identiCodeTF.delegate = self;
    
    UIView * identiCodeLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    UIImageView * iv3  = [UIImageView new];
    iv3.image = [UIImage imageNamed:@"注册-3"];
    [identiCodeLV addSubview:iv3];
    [iv3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(identiCodeLV).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
//    UILabel * lbl2 = [[UILabel alloc]initWithFrame:identiCodeLV.bounds];
//    lbl2.text = @"验证码";
//    lbl2.textAlignment = NSTextAlignmentCenter;
//    
//    [identiCodeLV addSubview:lbl2];
    
    UIView * identiCodeRV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 60)];
    UIButton * btn3 = [UIButton new];
//    btn3.backgroundColor = [UIColor orangeColor];
    [identiCodeRV addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(identiCodeRV).with.insets(UIEdgeInsetsMake(11, 10, 11, 10));
    }];
//    [btn3 setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"注册-获取验证码_03"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(getIdentiCode) forControlEvents:UIControlEventTouchUpInside];
    
    self.identiCodeTF.leftView = identiCodeLV;
    self.identiCodeTF.leftViewMode = UITextFieldViewModeAlways;
    self.identiCodeTF.rightView = identiCodeRV;
    self.identiCodeTF.rightViewMode = UITextFieldViewModeAlways;
    
//密码输入输入框
    self.passwordTF = [UITextField new];
    [self.view addSubview:self.passwordTF];
    //    [self.identiCodeTF showPlaceHolder];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.identiCodeTF.mas_bottom).with.offset (1);
        make.height.equalTo(@60);
        
    }];
    self.passwordTF.backgroundColor = [UIColor whiteColor];
    self.passwordTF.placeholder = @"请输入密码";
    self.passwordTF.delegate = self;
    
    UIView * passwordLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    UIImageView * iv4  = [UIImageView new];
    iv4.image = [UIImage imageNamed:@"注册-4"];
    [passwordLV addSubview:iv4];
    [iv4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(passwordLV).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    
    self.passwordTF.leftView = passwordLV;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
//密码确认输入框
    self.passwordTF2 = [UITextField new];
    [self.view addSubview:self.passwordTF2];
    //    [self.identiCodeTF showPlaceHolder];
    [self.passwordTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.passwordTF.mas_bottom).with.offset (1);
        make.height.equalTo(@60);
        
    }];
    self.passwordTF2.backgroundColor = [UIColor whiteColor];
    self.passwordTF2.placeholder = @"请输入确认密码";
    self.passwordTF2.delegate = self;
    
    UIView * password2LV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    UIImageView * iv5  = [UIImageView new];
    iv5.image = [UIImage imageNamed:@"注册-4"];
    [password2LV addSubview:iv5];
    [iv5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(password2LV).with.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    
    self.passwordTF2.leftView = password2LV;
    self.passwordTF2.leftViewMode = UITextFieldViewModeAlways;

//注册按钮
    UIButton * loginBtn = [UIButton new];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-20);
        make.top.equalTo(self.passwordTF2.mas_bottom).with.offset (20);
        make.height.equalTo(@40);
        
    }];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"fa9924"];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    [loginBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
//同意协议
    UIButton *  selectBtn = [UIButton new];
    [self.view addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
        make.top.equalTo(loginBtn.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(25,25));
    }];
    [selectBtn setImage:[UIImage imageNamed:@"注册1-框_07"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.selectBtnState = NO;
    
    UILabel * lbl = [UILabel new];
    [self.view addSubview:lbl];
//    [lbl showPlaceHolder];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectBtn.mas_right).with.offset(10);
        make.centerY.mas_equalTo(selectBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(130,15));
    }];
    lbl.text = @"我已看过并同意帮客";
    lbl.font =[UIFont systemFontOfSize:14];
    
    UIButton * deleBtn = [UIButton new];
    [self.view addSubview:deleBtn];
    [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbl.mas_right).with.offset(0);
        make.height.mas_equalTo(lbl.mas_height);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-20);
        make.centerY.mas_equalTo(selectBtn.mas_centerY);
        
    }];
    [deleBtn setTitle:@"《用户使用协议》" forState:UIControlStateNormal];
    deleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [deleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    CGRect frame = textField.frame;
//    int offset = frame.origin.y + 32 - (kMainScreenHeight - 216.0);//键盘高度216
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.view.frame = CGRectMake(0.0f, -offset, kMainScreenWidth , kMainScreenHeight);
//    
//    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)agreeAction:(UIButton *)btn
{
    self.selectBtnState = !self.selectBtnState;
    if (self.selectBtnState == YES) {
        [btn setImage:[UIImage imageNamed:@"注册1-对_07"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"注册1-框_07"] forState:UIControlStateNormal];
    }
}
///获取验证码
- (void)getIdentiCode
{
    WEAK_SELF(weakSelf);
    if (self.phoneNumTF.text.length > 0) {
        if (![RegTools regResultWithString:self.phoneNumTF.text]) {
            [self.view makeToast:@"请输入正确的手机号" duration:ToastDuration position:CSToastPositionCenter];
        }else{
            [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"sms/sendVeriSms?phoneNumber=%@",self.phoneNumTF.text] andParameters:nil successed:^(NSDictionary *dict) {
                NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
                NSLog(@"jsonStr = %@",jsonStr);
                NSString * statusCode = [dict objectForKey:@"statusCode"];
                NSString * errorMsg = [dict objectForKey:@"errorMsg"];
                NSString * code = [dict objectForKey:@"code"];
                if ([statusCode isEqualToString:@"000000"]) {
                    [UserInfoTool saveIdentiCode:code];
                }else{
                    [weakSelf.view makeToast:errorMsg duration:ToastDuration position:CSToastPositionCenter];
                }
            } failed:^(NSError *err) {
                NSLog(@"err = %@",[err localizedDescription]);
                [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
            }];
        }
        
    }else{
        [self.view makeToast:@"请输入手机号" duration:ToastDuration position:CSToastPositionCenter];
    }
}
- (void)registerAction
{
    WEAK_SELF(weakSelf);
    if (self.nickNameTF.text.length > 0 && self.phoneNumTF.text.length >0 && self.passwordTF.text.length > 0 && self.passwordTF2.text.length > 0 && self.identiCodeTF.text.length > 0) {
        if ([self.passwordTF2.text isEqualToString:self.passwordTF.text]) {
            if (self.selectBtnState == YES) {
                if ([self.identiCodeTF.text isEqualToString:[UserInfoTool getIdentiCode]]) {
                    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
                    [param setValue:[UserInfoTool getGeXinClientID] forKey:@"CID"];
                    [param setValue:self.phoneNumTF.text forKey:@"username"];
                    [param setValue:self.nickNameTF.text forKey:@"nikeName"];
                    [param setValue:self.passwordTF.text forKey:@"userpassword"];
                    NSLog(@"param = %@",param);
                    
                    [AFNHttpTools requestWithUrl:@"user/registeruser" andPostDict:param successed:^(NSDictionary *dict) {
                        NSLog(@"dict = %@",dict);
                        NSString * state = [dict objectForKey:@"state"];
                        NSString * message = [dict objectForKey:@"message"];
                        if ([state isEqualToString:@"SUCCESS"]) {
                            NSString * token = [dict objectForKey:@"responseText"];
                            [UserInfoTool saveToken:token];
                            [weakSelf.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                            //注册成功登录
                            [weakSelf loginAction];
                            
                        }else{
                            [weakSelf.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                        }
                        
                    } failed:^(NSError *err) {
                        NSLog(@"err = %@",err);
                        [weakSelf.view makeToast:@"请求失败" duration:ToastDuration position:CSToastPositionCenter];
                    }];
                }else{
                    [self.view makeToast:@"验证码输入错误" duration:ToastDuration position:CSToastPositionCenter];
                }
                
                
                
            }else{
                [self.view makeToast:@"请先确认协议" duration:ToastDuration position:CSToastPositionCenter];
            }
        }else{
            [self.view makeToast:@"两次输入的密码不一致" duration:ToastDuration position:CSToastPositionCenter];
        }
        
        
    }else{
        [self.view makeToast:@"请填写所有信息" duration:ToastDuration position:CSToastPositionCenter];
    }
}

- (void)loginAction
{
    WEAK_SELF(weakSelf);
    NSString * cid = [UserInfoTool getGeXinClientID];
    NSLog(@"cid = %@",cid);
    [AFNHttpTools requestTokenWithUrl:@"oauth/token" successed:^(NSDictionary *dict) {
        NSLog(@"dict = %@",dict);
        NSString * value = [dict objectForKey:@"value"];
        if (value.length > 0) {
            if (cid.length > 0) {
                [weakSelf sendGeXinCID:cid andUserName:weakSelf.phoneNumTF.text];
            }
            [UserInfoTool saveToken:value];
            [UserInfoTool saveUserName:weakSelf.phoneNumTF.text];
            [self returnAccountIDfromUserInfo];
//            EMError * error = nil;
//            NSDictionary * loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:weakSelf.phoneNumTF.text password:weakSelf.passwordTF.text error:&error];
//            if (!error && loginInfo) {
//                NSLog(@"环信登陆成功");
//            }
            
            
            
            
        }else{
            [weakSelf.view makeToast:@"登录失败" duration:ToastDuration position:CSToastPositionCenter];
        }
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",err);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    } andKeyVaulePairs:@"client_id",@"tonr",@"client_secret",@"secret",@"grant_type",@"password",@"username",self.phoneNumTF.text,@"password",self.passwordTF2.text, nil];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
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
                    SelectTagViewController * selectVC = [[SelectTagViewController alloc]init];
                    [weakSelf.navigationController pushViewController:selectVC animated:YES];
                } onQueue:nil];
            }
        } andFailed:^(NSError *err) {
            NSLog(@"err = %@",err);
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];
    }
    
}




@end
