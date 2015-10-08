//
//  PayTypeViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "PayTypeViewController.h"
#import "RegTools.h"

@interface PayTypeViewController () <UITextFieldDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITextField * inputTF;
@property (nonatomic, strong) UILabel * payTypeLabel;
@property (nonatomic, strong) UILabel * tipLabel2;

@end

@implementation PayTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    self.title = @"金额";
    [self createUI];
}

- (void)createUI
{
    WEAK_SELF(weakSelf);
    //输入金额

    self.inputTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 50)];
    self.inputTF.backgroundColor = [UIColor whiteColor];
    self.inputTF.placeholder = @"填写金额";
    self.inputTF.delegate = self;
    self.inputTF.layer.borderWidth = 1;
    self.inputTF.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    if (self.currentModel.price.length > 0) {
        self.inputTF.text = self.currentModel.price;
    }
    [self.view addSubview:self.inputTF];
    
    //leftView
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, self.inputTF.frame.size.height)];
//    leftView.backgroundColor = [UIColor redColor];
    UILabel * label1 = [[UILabel alloc]initWithFrame:leftView.bounds];
//    label1.backgroundColor = [UIColor blueColor];
    label1.text = @"金额";
    label1.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:label1];
    self.inputTF.leftView = leftView;
    self.inputTF.leftViewMode = UITextFieldViewModeAlways;
    
    //rightView
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.inputTF.frame.size.height)];
//    leftView.backgroundColor = [UIColor redColor];
    UILabel * label2 = [[UILabel alloc]initWithFrame:rightView.bounds];
//    label2.backgroundColor = [UIColor blueColor];
    label2.text = @"元";
    label2.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:label2];
    self.inputTF.rightView = rightView;
    self.inputTF.rightViewMode = UITextFieldViewModeAlways;
    
    //tip1
    UILabel * tiplabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.inputTF.frame), kMainScreenWidth, 30)];
    tiplabel1.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:tiplabel1];
    tiplabel1.text = @"服务金额的95%归接单者，5%用于平台的管理费。";
    tiplabel1.font =[UIFont systemFontOfSize:14];
    tiplabel1.textColor = [UIColor orangeColor];
    
    //选择支付方式btn
    UIButton * selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tiplabel1.frame), kMainScreenWidth, 50)];
    [self.view addSubview:selectBtn];
//    selectBtn.backgroundColor = [UIColor yellowColor];
    //隐藏功能
    //[selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    
    //label
    self.payTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, selectBtn.frame.size.height)];
    [selectBtn addSubview:self.payTypeLabel];
    self.payTypeLabel.text = @"保证金支付";
    //隐藏功能
    //self.payTypeLabel.text = @"请选择支付方式";
    //arrowIV
    UIImageView * arrowIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"首页菜单-箭头_07"]];
    arrowIV.frame = CGRectMake(kMainScreenWidth-30, 15, 10, 20);
    [selectBtn addSubview:arrowIV];
    //tip2
    self.tipLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(selectBtn.frame), kMainScreenWidth, 80)];
    self.tipLabel2.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.tipLabel2];
    self.tipLabel2.numberOfLines = 0;
    self.tipLabel2.text = @"当您选择使用保证金支付，对乙方来说，有了资金保障，会吸引更多的乙方来接单，您的订单的成功率将会大大提高。您的保证金需多于您提交的（成本金额+打赏金额）";
    self.tipLabel2.font =[UIFont systemFontOfSize:14];
    self.tipLabel2.textColor = [UIColor orangeColor];
    self.tipLabel2.hidden = NO;
    
    
    
    //提交按钮View
    UIView * submitView = [UIView new];
    [self.view addSubview:submitView];
//    [submitView showPlaceHolderWithLineColor:[UIColor blackColor]];
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(0);
        make.height.equalTo(@50);
    }];
    //提交按钮
    UIButton * submitBtn = [UIButton new];
    [submitView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(submitView.center);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.backgroundColor =[UIColor orangeColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    

}
#pragma mark - Action
- (void)selectAction
{
    NSLog(@"选择支付方式");
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"货到付款" otherButtonTitles:@"保证金支付", nil];
    [actionSheet showInView:self.view];
}

- (void)submitAction
{
    NSLog(@"提交");
    if ([RegTools regResultWithRechargeMoney:self.inputTF.text]) {
        Model_PayCallBack * model = [[Model_PayCallBack alloc]init];
        model.price = self.inputTF.text;
        if ([self.payTypeLabel.text isEqualToString:@"货到付款"]) {
            model.payType = 1;
            self.decidePay(model);
            [self.navigationController popViewControllerAnimated:YES];
        }else if([self.payTypeLabel.text isEqualToString:@"保证金支付"]){
            model.payType = 2;
            self.decidePay(model);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请选择支付方式" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//            alertView.delegate = self;
//            [alertView show];
            [self.view makeToast:@"请选择支付方式" duration:ToastDuration position:CSToastPositionCenter];
        }

    }else{
        [self.view makeToast:@"请输入正确金额" duration:ToastDuration position:CSToastPositionCenter];
    }
    
    
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PayBlock
-(void)returnPayModel:(CallBackPayModel)model
{
    NSLog(@"model = %@",model);
    self.decidePay = model;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.payTypeLabel.text = @"货到付款";
            self.tipLabel2.hidden = YES;
            break;
        case 1:
            self.payTypeLabel.text = @"保证金支付";
            self.tipLabel2.hidden = NO;
            break;
            
        default:
            break;
    }
}


@end
