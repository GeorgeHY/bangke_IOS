
//
//  MineFundViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/4/29.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "MineFundViewController.h"
#import "ChangePasswordViewController.h"
#import "Model_SearchMoney.h"
#import "AlipayAccountViewController.h"
#import "WithDrawViewController.h"
#import "AlipayTool.h"
#import "BillViewController.h"

@interface MineFundViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *freezeDisplay;
@property (weak, nonatomic) IBOutlet UIButton *withdrawDisplay;

@property (nonatomic, strong) UILabel * freezeLabel;
@property (nonatomic, strong) UILabel * withdrawLabel;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *withdrawBtn;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;





@end

@implementation MineFundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"账单" style:UIBarButtonItemStyleDone target:self action:@selector(pushBillVC:)];
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self createUI];
    
    
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self requestBalance];
    
}

- (void)createUI
{
    WEAK_SELF(weakSelf);
    
    //钱币图标iv
//    self.iconIV.layer.borderWidth = 1;
//    self.iconIV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.iconIV.image = [UIImage imageNamed:@"bg_yue_2x"];
    

        
    self.moneyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    
    
    //冻结中
    UILabel * label1 = [UILabel new];
    [self.freezeDisplay addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.freezeDisplay.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.freezeDisplay.mas_right).with.offset(0);
        make.top.mas_equalTo(weakSelf.freezeDisplay.mas_top).with.offset(8);
        make.height.equalTo(@(15));
    }];
    label1.text = @"冻结中";
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    self.freezeDisplay.layer.borderWidth = kBORDERWIDTH;
    self.freezeDisplay.layer.borderColor = [[UIColor colorWithHexString:@"E17824"]CGColor];
    self.freezeDisplay.layer.masksToBounds = YES;
    self.freezeDisplay.layer.cornerRadius = 5;
    
    
    self.freezeLabel = [UILabel new];
    [self.freezeDisplay addSubview:self.freezeLabel];
    [self.freezeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.freezeDisplay.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.freezeDisplay.mas_right).with.offset(0);
        make.top.mas_equalTo(label1.mas_bottom).with.offset(8);
        make.height.equalTo(@(15));
    }];
    self.freezeLabel.text = @"0";
    self.freezeLabel.textColor = [UIColor whiteColor];
    self.freezeLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //提现中
    UILabel * label2 = [UILabel new];
    [self.withdrawDisplay addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.withdrawDisplay.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.withdrawDisplay.mas_right).with.offset(0);
        make.top.mas_equalTo(weakSelf.withdrawDisplay.mas_top).with.offset(8);
        make.height.equalTo(@(15));
    }];
    label2.text = @"提现中";
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    
    self.withdrawDisplay.layer.borderWidth = kBORDERWIDTH;
    self.withdrawDisplay.layer.borderColor = [[UIColor colorWithHexString:@"E17824"]CGColor];
    self.withdrawDisplay.layer.masksToBounds = YES;
    self.withdrawDisplay.layer.cornerRadius = 5;
    
    self.withdrawLabel = [UILabel new];
    [self.withdrawDisplay addSubview:self.withdrawLabel];
    [self.withdrawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.withdrawDisplay.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.withdrawDisplay.mas_right).with.offset(0);
        make.top.mas_equalTo(label2.mas_bottom).with.offset(8);
        make.height.equalTo(@(15));
    }];
    self.withdrawLabel.text = @"0";
    self.withdrawLabel.textColor = [UIColor whiteColor];
    self.withdrawLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    //我的保证金label
    //人民币符号iv
    //钱数label


    //服务协议
    
    //充值btn
    self.rechargeBtn.layer.borderWidth = kBORDERWIDTH;
    self.rechargeBtn.layer.borderColor = [[UIColor colorWithHexString:@"C53200"]CGColor];
    self.rechargeBtn.layer.masksToBounds = YES;
    self.rechargeBtn.layer.cornerRadius = 5;
    //提现btn
    self.withdrawBtn.layer.borderWidth = kBORDERWIDTH;
    self.withdrawBtn.layer.borderColor = [[UIColor colorWithHexString:@"E17824"]CGColor];
    self.withdrawBtn.layer.masksToBounds = YES;
    self.withdrawBtn.layer.cornerRadius = 5;
    //我的账户
    self.accountBtn.layer.borderWidth = kBORDERWIDTH;
    self.accountBtn.layer.borderColor = [[UIColor colorWithHexString:@"01946F"]CGColor];
    self.accountBtn.layer.masksToBounds = YES;
    self.accountBtn.layer.cornerRadius = 5;
    
    
    
    
}

- (void)requestBalance
{
    WEAK_SELF(weakSelf);
    if ([UserInfoTool getToken] && ![[UserInfoTool getToken] isEqualToString:@""]) {
        [AlipayTool requestMoneyInfoWithToken:[UserInfoTool getToken] andSuccessed:^(id model) {
            Model_SearchMoney * searchModel = model;
            if ([searchModel.state isEqualToString:dStateFail]) {
                [weakSelf.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
            }else{
                self.freezeLabel.text  = searchModel.responseText.lock_money;
                self.withdrawLabel.text = searchModel.responseText.withdrawing;
                self.moneyLabel.text = searchModel.responseText.available_balance;
            }
        } andFailed:^(NSError *err) {
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];
    }
    
    
    
    
    
//    NSMutableDictionary * param = [NSMutableDictionary dictionaryWithObject:token forKey:@"access_token"];
//    [AFNHttpTools getDataWithUrl:@"permissions/baseuser/money" andParameters:param successed:^(NSDictionary *dict) {
//        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
//        Model_SearchMoney * searchModel = [[Model_SearchMoney alloc]initWithString:json error:nil];
//        NSLog(@"state = %@",searchModel.state);
//        if ([searchModel.state isEqualToString:dStateSuccess]) {
//            self.moneyLabel.text = searchModel.responseText.money;
//        }else if ([searchModel.state isEqualToString:dStateTokenInvalid]) {
//            [UserInfoTool deleteToken];
//            [APPLICATION setHomePageVC];
//        }else{
//            [self.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
//        }
//    } failed:^(NSError *err) {
//        NSLog(@"err = %@",[err localizedDescription]);
//        [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
//    }];
}

#pragma mark - Action
- (IBAction)rechargeAction:(UIButton *)sender {
    ChangePasswordViewController * rechargeVC = [[ChangePasswordViewController alloc]init];
    rechargeVC.source = 2;
    rechargeVC.title = @"充值";
    [self.navigationController pushViewController:rechargeVC animated:YES];
}
- (IBAction)GetCashAction:(UIButton *)sender {
    WithDrawViewController * withdrawVC = [[WithDrawViewController alloc]init];
    
    withdrawVC.title = @"提现";
    [self.navigationController pushViewController:withdrawVC animated:YES];
}

- (IBAction)pushMyAlipayVC:(UIButton *)sender {
    AlipayAccountViewController * alipayVC = [[AlipayAccountViewController alloc]init];
    [self.navigationController pushViewController:alipayVC animated:YES];
    
}

- (void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (UIStatusBarStyle) preferredStatusBarStyle {
    //状态栏变色
    return UIStatusBarStyleLightContent;
}

-(void)pushBillVC:(UIBarButtonItem *)item
{
    BillViewController * billVC = [[BillViewController alloc]init];
    [self.navigationController pushViewController:billVC animated:YES];
}


@end
