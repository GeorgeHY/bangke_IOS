//
//  ConnectPersonViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "ConnectPersonViewController.h"
#import "Cell_Invite.h"
#import "Model_Invite.h"
#import "Cell_Compete.h"
#import "Model_Compete.h"

static NSString * cellInviteIdent = @"Cell_Invite";
static NSString * cellCompeteIdent = @"Cell_Compete";
@interface ConnectPersonViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ConnectPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self createUI];
    if (self.type == 1) {
        self.title = @"竞单者";
    }else{
        self.title = @"邀单者";
    }
//    self.type = 2;
}

- (void)createUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1竞单2邀单
    switch (self.type) {
        case 1:
        {
            Cell_Compete * cell = [tableView dequeueReusableCellWithIdentifier:cellCompeteIdent];
            if (!cell) {
                cell = (Cell_Compete *)[[[NSBundle  mainBundle]  loadNibNamed:@"Cell_Compete" owner:self options:nil]  lastObject];
            }
            return cell;
        }
            break;
        case 2:
        {
            Cell_Invite * cell = [tableView dequeueReusableCellWithIdentifier:cellInviteIdent];
            if (!cell) {
                cell = (Cell_Invite *)[[[NSBundle  mainBundle]  loadNibNamed:@"Cell_Invite" owner:self options:nil]  lastObject];
            }
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.type) {
        case 1:
            return 150;
            break;
        case 2:
            return 110;
            break;
        default:
            return 44;
            break;
    }
}


@end
