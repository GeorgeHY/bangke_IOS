//
//  BindWithIdentiCodeVC.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "BindWithIdentiCodeVC.h"
#import "Model_Request.h"

@interface BindWithIdentiCodeVC ()
@property (nonatomic, strong) UITextField * identiCodeTF;
@end

@implementation BindWithIdentiCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submitAction)];
    [rightItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.title = @"绑定手机号";

    [self createUI];
}

-(void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    WEAK_SELF(weakSelf);
    UILabel * label = [UILabel new];
    [self.view addSubview:label];
//    [label showPlaceHolderWithLineColor:[UIColor blackColor]];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.mas_equalTo(weakSelf.view.mas_top).with.offset(64);
        make.height.equalTo(@40);
    }];
    label.text = [NSString stringWithFormat:@"  我们已发送验证码短信到手机(%@),请注意查收",self.phoneNum];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor yellowColor];
    
    
    self.identiCodeTF = [UITextField new];
    [self.view addSubview:self.identiCodeTF];
    //    [self.identiCodeTF showPlaceHolder];
    [self.identiCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(label.mas_bottom).with.offset (0);
        make.height.equalTo(@60);
        
    }];
    self.identiCodeTF.backgroundColor = [UIColor whiteColor];
    self.identiCodeTF.placeholder = @"请输入验证码";
    //    self.identiCodeTF.layer.masksToBounds = YES;
    //    self.identiCodeTF.layer.cornerRadius = 5;
    
    UIView * identiCodeLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 60)];
    //    UIImageView * iv2  = [UIImageView new];
    //    iv2.image = [UIImage imageNamed:@"登陆-锁"];
    //    [identiCodeLV addSubview:iv2];
    //    [iv2 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(identiCodeLV).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    //    }];
    UILabel * lbl2 = [[UILabel alloc]initWithFrame:identiCodeLV.bounds];
    lbl2.text = @"验证码";
    lbl2.textAlignment = NSTextAlignmentCenter;
    
    [identiCodeLV addSubview:lbl2];
    
    UIView * identiCodeRV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 60)];
    UIButton * btn2 = [UIButton new];
    btn2.backgroundColor = [UIColor orangeColor];
    [identiCodeRV addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(identiCodeRV).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    [btn2 addTarget:self action:@selector(getIdentiCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    
//    self.identiCodeTF.leftView = identiCodeLV;
//    self.identiCodeTF.leftViewMode = UITextFieldViewModeAlways;
    self.identiCodeTF.rightView = identiCodeRV;
    self.identiCodeTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    
    
    
    
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)submitAction
{
    NSLog(@"提交");
    
    if ([self.identiCodeTF.text isEqualToString:[UserInfoTool getIdentiCode]]) {
        if ([UserInfoTool getToken]&&![[UserInfoTool getToken] isEqualToString:@""]) {
            [self UpdateTelephoneWithToken:[UserInfoTool getToken]];
        }else{
            //登陆
        }
    }else{
        [self.view makeToast:@"验证码输入错误" duration:ToastDuration position:CSToastPositionCenter];
    }
    
    
    
//    BindWithIdentiCodeVC * bindIdentiVC = [[BindWithIdentiCodeVC alloc]init];
//    bindIdentiVC.phoneNum = @"12435678901";
//    [self.navigationController pushViewController:bindIdentiVC animated:YES];
    
}
- (void)getIdentiCodeAction
{
    WEAK_SELF(weakSelf);
    
    
    [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"sms/sendVeriSms?phoneNumber=%@",self.phoneNum] andParameters:nil successed:^(NSDictionary *dict) {
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
    
    
//    [AFNHttpTools getDataWithUrl:@"sms/send" andParameters:nil successed:^(NSDictionary *dict) {
//        NSString * state = [dict objectForKey:@"state"];
//        NSString * message = [dict objectForKey:@"message"];
//        if ([state isEqualToString:dStateSuccess]) {
////            NSString * responseText = [dict objectForKey:@"responseText"];
////            [UserInfoTool saveIdentiCode:responseText];
//        }else{
//            [weakSelf.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
//        }
//        
//    } failed:^(NSError *err) {
//        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
//    }];
}


- (void)UpdateTelephoneWithToken:(NSString *)token
{
    WEAK_SELF(weakSelf);
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    [param setValue:self.phoneNum forKey:@"telephone"];
    
    [AFNHttpTools requestWithUrl:@"permissions/updateTelephone" andPostDict:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_Request * model = [[Model_Request alloc]initWithString:jsonStr error:nil];
        if ([model.state isEqualToString:dStateSuccess]) {
            [weakSelf.view makeToast:model.message duration:ToastDuration position:CSToastPositionCenter];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
    } failed:^(NSError *err) {
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}

@end
