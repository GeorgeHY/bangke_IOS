//
//  PasswordUpdateViewController.m
//  Bangke_IOS
//
//  Created by admin on 15/8/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "PasswordUpdateViewController.h"
#import "Model_Request.h"

@interface PasswordUpdateViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField * oldPwdTF;
@property (nonatomic, strong) UITextField * pwd1TF;
@property (nonatomic, strong) UITextField * pwd2TF;
@end

@implementation PasswordUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    //    self.phoneNum = @"13900000000";
    //
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem setTintColor:[UIColor orangeColor]];
    [self createUI];
}

-(void)createUI{
    //旧密码输入框
    self.oldPwdTF = [UITextField new];
    self.oldPwdTF.secureTextEntry = YES;
    self.oldPwdTF.delegate = self;
    [self.view addSubview:self.oldPwdTF];
    //    [self.phoneNumTF showPlaceHolder];
    WEAK_SELF(weakSelf);
    NSInteger padding = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    [self.oldPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(padding);
        make.height.equalTo(@60);
        
    }];
    self.oldPwdTF.backgroundColor = [UIColor whiteColor];
    self.oldPwdTF.placeholder = @"请输入原密码";
    //    self.phoneNumTF.layer.masksToBounds = YES;
    //    self.phoneNumTF.layer.cornerRadius = 5;
    
    UIView * oldPwdLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 60)];
    UIImageView * iv0  = [UIImageView new];
    iv0.image = [UIImage imageNamed:@"修改密码2-48"];
    [oldPwdLV addSubview:iv0];
    
    [iv0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(oldPwdLV).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    self.oldPwdTF.leftView = oldPwdLV;
    self.oldPwdTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    
    //################
    
    //密码1输入框
    self.pwd1TF = [UITextField new];
    self.pwd1TF.secureTextEntry = YES;
    self.pwd1TF.delegate = self;
    [self.view addSubview:self.pwd1TF];
    //    [self.phoneNumTF showPlaceHolder];
    [self.pwd1TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.oldPwdTF.mas_bottom).with.offset(0);
        make.height.equalTo(@60);
        
    }];
    self.pwd1TF.backgroundColor = [UIColor whiteColor];
    self.pwd1TF.placeholder = @"请输入密码";
    //    self.phoneNumTF.layer.masksToBounds = YES;
    //    self.phoneNumTF.layer.cornerRadius = 5;
    
    UIView * phoneNumLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 60)];
    UIImageView * iv1  = [UIImageView new];
    iv1.image = [UIImage imageNamed:@"修改密码2-48"];
    [phoneNumLV addSubview:iv1];
    
    [iv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(phoneNumLV).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    self.pwd1TF.leftView = phoneNumLV;
    self.pwd1TF.leftViewMode = UITextFieldViewModeAlways;
    
    
    //密码2输入框
    self.pwd2TF = [UITextField new];
    self.pwd2TF.secureTextEntry = YES;
    self.pwd2TF.delegate = self;
    [self.view addSubview:self.pwd2TF];
    //    [self.identiCodeTF showPlaceHolder];
    [self.pwd2TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.pwd1TF.mas_bottom).with.offset (0);
        make.height.equalTo(@60);
        
    }];
    self.pwd2TF.backgroundColor = [UIColor whiteColor];
    self.pwd2TF.placeholder = @"请输入确认密码";
    //    self.identiCodeTF.layer.masksToBounds = YES;
    //    self.identiCodeTF.layer.cornerRadius = 5;
    
    UIView * identiCodeLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 60)];
    UIImageView * iv2  = [UIImageView new];
    iv2.image = [UIImage imageNamed:@"修改密码1-48"];
    [identiCodeLV addSubview:iv2];
    [iv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(identiCodeLV).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    self.pwd2TF.leftView = identiCodeLV;
    self.pwd2TF.leftViewMode = UITextFieldViewModeAlways;
    

}


#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
///发送修改密码请求
- (void)nextStep
{
    WEAK_SELF(weakSelf);
    if (![self.oldPwdTF.text isEqualToString:@""]&&![self.pwd1TF.text isEqualToString:@""]&&![self.pwd2TF.text isEqualToString:@""]) {
        if ([self.pwd2TF.text isEqualToString:self.pwd1TF.text]) {
            NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
           [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
            [param setValue:self.oldPwdTF.text forKey:@"password"];
            [param setValue:self.pwd1TF.text forKey:@"password1"];
            [param setValue:self.pwd2TF.text forKey:@"password2"];
            NSLog(@"param = %@",param);
            
            [AFNHttpTools requestWithUrl:@"permissions/updatePassword" andPostDict:param successed:^(NSDictionary *dict) {
                NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
                NSLog(@"jsonStr = %@",jsonStr);
                Model_Request * model = [[Model_Request alloc]initWithString:jsonStr error:nil];
                if ([model.state isEqualToString:dStateSuccess]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [weakSelf.view makeToast:[NSString stringWithFormat:@"%@,下次登录请使用新密码",model.message] duration:ToastDuration position:CSToastPositionCenter];
                }else{
                    [weakSelf.view makeToast:model.message duration:ToastDuration position:CSToastPositionCenter];
                }
            } failed:^(NSError *err) {
                NSLog(@"err = %@",err);
            }];
            
            
        }else{
            [self.view makeToast:@"密码前后输入不一致" duration:ToastDuration position:CSToastPositionCenter];
        }
        
        
    }else{
        [self.view makeToast:@"请输入全部信息" duration:ToastDuration position:CSToastPositionCenter];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
