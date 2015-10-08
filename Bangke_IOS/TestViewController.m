//
//  TestViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/12.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "TestViewController.h"
#import "UIColor+AddColor.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];;

    
    UIView * testView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, kMainScreenWidth, kMainScreenHeight)];
    testView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:testView];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 50, 20)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [testView addSubview:btn];
    
}

- (void)closeAction:(UIButton *)btn
{
    NSLog(@"关闭");

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
