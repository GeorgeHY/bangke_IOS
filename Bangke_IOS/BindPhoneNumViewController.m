//
//  BindPhoneNumViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "BindPhoneNumViewController.h"
#import "BindWithIdentiCodeVC.h"
#import "RegTools.h"

@interface BindPhoneNumViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *currentPhoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation BindPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(nextStep)];
    [rightItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.title = @"绑定手机号";
    self.currentPhoneLabel.text = self.currentPhone;
    self.textField.delegate = self;
    
    //[self createUI];
}

- (void)createUI
{
    
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextStep
{
    NSLog(@"下一步");
    BindWithIdentiCodeVC * bindIdentiVC = [[BindWithIdentiCodeVC alloc]init];
    if (self.textField.text && ![self.textField.text isEqualToString:@""] ){
        if ([RegTools regResultWithString:self.textField.text]) {
            bindIdentiVC.phoneNum = self.textField.text;
            [self.navigationController pushViewController:bindIdentiVC animated:YES];
        }else{
            [self.view makeToast:@"请输入正确的手机号" duration:ToastDuration position:CSToastPositionCenter];
        }

        
    }else{
        [self.view makeToast:@"请输入手机号" duration:ToastDuration position:CSToastPositionCenter];
    }
    
    
}


@end
