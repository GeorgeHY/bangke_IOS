//
//  AppInfoViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/26.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "AppInfoViewController.h"
#import "Model_SearchAppInfo.h"
@interface AppInfoViewController()

@property (nonatomic, strong) UILabel * versionLabel;

@end


@implementation AppInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self createUI];
    [self getAppInfoWithType];

    


}

- (void)createUI
{
    self.versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, kMainScreenWidth-40, 50)];
    self.versionLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.versionLabel];
}

- (void)getAppInfoWithType
{
    [AFNHttpTools getDataWithUrl:[NSString stringWithFormat:@"version/%@",@"1"] andParameters:nil successed:^(NSDictionary *dict) {
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"json = %@",json);
        Model_SearchAppInfo * searchModel = [[Model_SearchAppInfo alloc]initWithString:json error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            NSLog(@"%@",searchModel.responseText.version_number);
        }else{
            [self.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
