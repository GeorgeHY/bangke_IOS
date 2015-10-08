//
//  ChangePasswordViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/4/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "Masonry.h"
#import "InputPasswordViewController.h"
#import "AFNHttpTools.h"
#import "RegTools.h"
#import "UserInfoTool.h"
#import "Model_Request.h"
#import "AlipayTool.h"
#import "Model_SearchRecharge.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
@interface ChangePasswordViewController ()
@property (nonatomic, strong) UITextField * phoneNumTF;
@property (nonatomic, strong) UITextField * identiCodeTF;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    if (self.source == 1) {
        self.title = @"忘记密码";
    }
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.hidesBackButton = YES;
    [self createUI];
    
}

-(void)createUI{
    WEAK_SELF(weakSelf);
    NSInteger padding = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    //手机号输入框
    self.phoneNumTF = [UITextField new];
    [self.view addSubview:self.phoneNumTF];
//    [self.phoneNumTF showPlaceHolder];
    [self.phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(padding);
        make.height.equalTo(@60);
        
    }];
    self.phoneNumTF.backgroundColor = [UIColor whiteColor];
    if (self.source == 2) {
        self.phoneNumTF.placeholder = @"请输入金额";
    }else{
        self.phoneNumTF.placeholder = @"请输入手机号码";
//        self.phoneNumTF.text = @"18622680159";
    }
    
//    self.phoneNumTF.layer.masksToBounds = YES;
//    self.phoneNumTF.layer.cornerRadius = 5;
    
    UIView * phoneNumLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 60)];
//    UIImageView * iv1  = [UIImageView new];
//    iv1.image = [UIImage imageNamed:@"登陆-电话"];
//    [phoneNumLV addSubview:iv1];
    
    UILabel * lbl1 = [[UILabel alloc]initWithFrame:phoneNumLV.bounds];
    if (self.source == 1) {
        lbl1.text = @"手机号";
    }else{
        lbl1.text = @"金额(元)";
    }
    
    lbl1.textAlignment = NSTextAlignmentCenter;
    [phoneNumLV addSubview:lbl1];
//    [iv1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(phoneNumLV).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
//    }];
    self.phoneNumTF.leftView = phoneNumLV;
    self.phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    
    if (self.source == 1) {
        //验证码输入框
        self.identiCodeTF = [UITextField new];
        [self.view addSubview:self.identiCodeTF];
        //    [self.identiCodeTF showPlaceHolder];
        [self.identiCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
            make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
            make.top.equalTo(weakSelf.phoneNumTF.mas_bottom).with.offset (0);
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
        [btn2 setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(getIdentiCode) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        self.identiCodeTF.leftView = identiCodeLV;
        self.identiCodeTF.leftViewMode = UITextFieldViewModeAlways;
        self.identiCodeTF.rightView = identiCodeRV;
        self.identiCodeTF.rightViewMode = UITextFieldViewModeAlways;
    }
    
    
    
    
    
    
  
    
    
    
}
#pragma mark - Action
-(void)nextStep
{
    NSLog(@"下一步");
    WEAK_SELF(weakSelf);
    if (self.source == 1) {
        NSString * currentCode = [UserInfoTool getIdentiCode];
        if ([self.identiCodeTF.text isEqualToString:currentCode]) {
            InputPasswordViewController * inputVC = [[InputPasswordViewController alloc]init];
            inputVC.phoneNum = self.phoneNumTF.text;
            [self.navigationController pushViewController:inputVC animated:YES];
        }else{
            [self.view makeToast:@"验证码不正确" duration:ToastDuration position:CSToastPositionCenter];
        }
        
//        InputPasswordViewController * inputVC = [[InputPasswordViewController alloc]init];
//        [self.navigationController pushViewController:inputVC animated:YES];
        
        
    }else{
        NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
        if ([self.title isEqualToString:@"充值"]) {
            
            [param removeAllObjects];
            if ([RegTools regResultWithRechargeMoney:self.phoneNumTF.text]) {
                if ([UserInfoTool getToken] && ![[UserInfoTool getToken] isEqualToString:@""]) {
                    [AlipayTool requestRechargeWithToken:[UserInfoTool getToken] andMoney:self.phoneNumTF.text andSuccessed:^(id model) {
                        Model_SearchRecharge * searchModel = model;
                        if ([searchModel.state isEqualToString:dStateSuccess]) {
                            //调用支付宝充值
                            [self alipayActionWithRechargeInfo:searchModel.responseText];
                        }else{
                            [weakSelf.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
                        }
                    } andFailed:^(NSError *err) {
                         [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
                    }];
                }
                
            }else{
                [self.view makeToast:@"请输入正确金额" duration:ToastDuration position:CSToastPositionCenter];
            }
            
            
        }else{
            //提现请求
            [param removeAllObjects];
            if ([RegTools regResultWithRechargeMoney:self.phoneNumTF.text]) {
                
            }else{
                [self.view makeToast:@"请输入正确金额" duration:ToastDuration position:CSToastPositionCenter];
            }
            
        }
        
    }
    
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
///获取验证码
- (void)getIdentiCode
{
    WEAK_SELF(weakSelf);
    NSLog(@"测试获取验证码");
    if (self.phoneNumTF.text.length > 0 ) {
        if ([RegTools regResultWithString:self.phoneNumTF.text]) {
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
        }else{
            [self.view makeToast:@"请输入正确的手机号" duration:ToastDuration position:CSToastPositionCenter];
        }
        
    }else{
        [self.view makeToast:@"请输入手机号" duration:ToastDuration position:CSToastPositionCenter];
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
    order.notifyURL =  info.url; //回调URL
    
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

@end
