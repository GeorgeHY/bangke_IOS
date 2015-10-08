//
//  FeedbackViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTV;

@end

@implementation FeedbackViewController

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
    self.title = @"意见反馈";
    [self createUI];
}

- (void)createUI
{
//    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submitAction)];
//    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - Action
- (void)submitAction
{
    NSLog(@"提交");
    NSString * token = [UserInfoTool getToken];
    if (token.length >0) {
        if (self.contentTV.text.length > 0) {
            [self sendMessageWithToken:token];
        }else{
            [self.view makeToast:@"请输入文字" duration:ToastDuration position:CSToastPositionCenter];
        }
        
    }
    //    BindWithIdentiCodeVC * bindIdentiVC = [[BindWithIdentiCodeVC alloc]init];
    //    bindIdentiVC.phoneNum = @"12435678901";
    //    [self.navigationController pushViewController:bindIdentiVC animated:YES];
    
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendMessageWithToken:(NSString *)token
{
    WEAK_SELF(weakSelf);
    [AFNHttpTools requestWithUrl:@"permissions/leave/message" successed:^(NSDictionary *dict) {
        NSString * state = [dict objectForKey:@"state"];
        NSString * message = [dict objectForKey:@"message"];
        if ([state isEqualToString:dStateSuccess]) {
            
            [weakSelf.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
        }else if ([state isEqualToString:dStateTokenInvalid]) {
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            [weakSelf.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    } andKeyVaulePairs:@"access_token",token,@"content",self.contentTV.text, nil];
}
@end
