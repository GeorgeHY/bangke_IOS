//
//  DistanceListViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/7/20.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "DistanceListViewController.h"

@interface DistanceListViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * disArr;

@end

@implementation DistanceListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    self.disArr = [NSArray arrayWithObjects:@"1km",@"2km",@"3km",@"4km",@"5km",@"6km",@"7km",@"8km",@"9km",@"10km", nil];
    
}

- (void)createUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.disArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.disArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * distance = self.disArr[indexPath.row];
    self.currentDis(distance);
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)returnDistance:(CallBackDis)distance
{
    if (distance) {
        self.currentDis = distance;
    }
}

@end
