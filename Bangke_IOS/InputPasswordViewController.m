//
//  InputPasswordViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/4/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "InputPasswordViewController.h"
#import "SelectTagViewController.h"

@interface InputPasswordViewController ()
@property (nonatomic, strong) UITextField * pwd1TF;
@property (nonatomic, strong) UITextField * pwd2TF;
@end

@implementation InputPasswordViewController

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
    // Do any additional setup after loading the view.
}

-(void)createUI{
    //密码1输入框
    self.pwd1TF = [UITextField new];
    self.pwd1TF.secureTextEntry = YES;
    [self.view addSubview:self.pwd1TF];
    //    [self.phoneNumTF showPlaceHolder];
    WEAK_SELF(weakSelf);
    NSInteger padding = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    [self.pwd1TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(padding);
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

-(void)nextStep
{
    NSLog(@"完成");
    if (self.pwd1TF.text.length > 0 && self.pwd2TF.text.length > 0 ) {
        if ([self.pwd2TF.text isEqualToString:self.pwd1TF.text]) {
            [AFNHttpTools requestWithUrl:@"user/forgetuserpassword" successed:^(NSDictionary *dict) {
                NSLog(@"dict= %@",dict);
                NSString * state = [dict objectForKey:@"state"];
                NSString * message = [dict objectForKey:@"message"];
                if ([state isEqualToString:@"SUCCESS"]) {
                    [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                }
                
            } failed:^(NSError *err) {
                NSLog(@"err = %@",err);
            } andKeyVaulePairs:@"username",self.phoneNum,@"userpassword",self.pwd2TF.text, nil];
        }else{
            [self.view makeToast:@"两次输入的密码不一致" duration:ToastDuration position:CSToastPositionCenter];
        }
    }else{
        [self.view makeToast:@"请输入完整信息" duration:ToastDuration position:CSToastPositionCenter];
    }
    
    
   
    
    
    
    
}

@end
