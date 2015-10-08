//
//  ReviewViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/11.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "ReviewViewController.h"
#import "Cell_Review.h"
#import "Model_Review.h"
#import "CircleStatus/NOCSView.h"
#import "NOCSPercentageColor.h"


static NSString * cellIdentifier = @"Cell_Review";
@interface ReviewViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NOCSView * csView;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    
    
}
- (void)createUI
{
    WEAK_SELF(weakSelf);
    //status view
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 150)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    self.csView  = [NOCSView new];
    [titleView addSubview:self.csView];
    [self.csView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleView.mas_centerY);
        make.left.mas_equalTo(titleView.mas_left).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    self.csView.backgroundColor = [UIColor lightGrayColor];
    
    [self.csView setPercentageColorArray:@[[[NOCSPercentageColor alloc]initWithTitle:@"好评23" color:[UIColor blueColor] percentage:0.5f],[[NOCSPercentageColor alloc]initWithTitle:@"中评15" color:[UIColor greenColor] percentage:0.3f]]];
    [self.csView setFillColor:[UIColor orangeColor]];
    self.csView.textLabel.font = [UIFont systemFontOfSize:10];
    UILabel * lbl1 = [[UILabel alloc]init];
    lbl1.center = CGPointMake(50, 40);
    lbl1.bounds = CGRectMake(0, 0, 50, 20);
    lbl1.backgroundColor = [UIColor redColor];
    lbl1.text = @"35";
    [self.csView.textLabel addSubview:lbl1];
    [self.csView.textLabel bringSubviewToFront:lbl1];
    UILabel * lbl2 = [[UILabel alloc]init];
    lbl2.center = CGPointMake(50, 60);
    lbl2.bounds = CGRectMake(0, 0,70 , 20);
    lbl2.backgroundColor = [UIColor redColor];
    lbl2.text = @"交易量";
    [self.csView.textLabel addSubview:lbl2];
    [self.csView.textLabel bringSubviewToFront:lbl2];
    [self.csView setShowsLegend:NO];
//    UIView * view = [UIView new];
//    [self.csView addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf.csView).with.insets(UIEdgeInsetsMake(0, 120, 0, 0));
//    }];
//    view.backgroundColor = [UIColor yellowColor];
        //table view
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), kMainScreenWidth, kMainScreenHeight-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[Cell_Review class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.tableView];
    //headerView
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 36)];
    headerView.backgroundColor = [UIColor yellowColor];
    UILabel * reviewCountLbl = [[UILabel alloc]initWithFrame:headerView.bounds];
    reviewCountLbl.text = @"评价(30)";
    [headerView addSubview:reviewCountLbl];
    self.tableView.tableHeaderView = headerView;

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_Review * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 36;
//}


@end
