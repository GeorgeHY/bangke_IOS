//
//  ScreeningViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/14.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "ScreeningViewController.h"
#import "Cell_ScreenTag.h"
#import "Model_SelectTag.h"
#import "UIViewController+ECSlidingViewController.h"
#import "Model_SearchParentLabel.h"
#import "OrderViewController.h"
#define PeekWidth 100

static NSString * cellIdentifier_cv = @"Cell_ScreenTag";
@interface ScreeningViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * tagArr;
@property (nonatomic, strong) UINavigationController * homePageNavigationController;
@property (nonatomic, strong) NSString * currentLabelID;
@property (nonatomic, strong) NSString * currentPtype;
@end

@implementation ScreeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray * arr1 = [NSArray arrayWithObjects:@"美妆",@"饮食",@"电影",@"休闲",@"美妆",@"美妆",@"美妆", nil];
    self.tagArr = [NSMutableArray array];
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(PeekWidth, 0, kMainScreenWidth-PeekWidth, kMainScreenHeight)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    [self initTitleView];
    [self initTableView];
    [self initCollectionView];
    self.homePageNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
    [self requestParentLabel];
    
}

- (void)initTitleView
{
    WEAK_SELF(weakSelf);
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.bgView.frame.size.width, 50)];
//    self.titleView.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:self.titleView];
    //筛选
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 40)];
    [self.titleView addSubview:label];
    label.text = @"筛选";
    
    UIButton * btn = [UIButton new];
    [self.titleView addSubview:btn];
//    btn.backgroundColor = [UIColor blueColor];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.titleView.mas_right).with.offset(0);
        make.top.mas_equalTo(weakSelf.titleView.mas_top).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.titleView.mas_bottom).with.offset(0);
        make.width.equalTo(@100);
    }];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)initTableView
{
    //订单模式
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), self.bgView.frame.size.width, 44)];
    [self.bgView addSubview:titleView];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleView.frame.size.width-10, titleView.frame.size.height)];
    label.text = @"订单模式";
    [titleView addSubview:label];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.bgView.frame.size.width, 176)];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.bgView addSubview:self.tableView];
    self.array = [NSArray  arrayWithObjects:@"全部",@"抢单",@"竞单",@"邀单", nil];
}

- (void)initCollectionView
{
    //选择标签
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.bgView.frame.size.width, 44)];
    [self.bgView addSubview:titleView];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, titleView.frame.size.width-10, titleView.frame.size.height)];
    label.text = @"选择标签";
    [titleView addSubview:label];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.bgView.frame.size.width, kMainScreenHeight - CGRectGetMaxY(titleView.frame)) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.bgView addSubview:self.collectionView];
}


#pragma mark - Action
- (void)submitAction
{
    NSLog(@"完成");
    
    self.slidingViewController.topViewController = self.homePageNavigationController;
    [self.slidingViewController resetTopViewAnimated:YES];
    NSString * token = [UserInfoTool getToken];
//    [OrderViewController sharedInstance].currentLabelID = self.currentLabelID;
//    [OrderViewController sharedInstance].currentPtype = self.currentPtype;
    [UserInfoTool saveCurrentPtype:self.currentPtype];
    [[OrderViewController sharedInstance] refreshTVData];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            self.currentPtype = nil;
            break;
        case 1:
            [UserInfoTool saveCurrentPtype:@"3"];
            break;
        case 2:
            [UserInfoTool saveCurrentPtype:@"1"];
            break;
        case 3:
            [UserInfoTool saveCurrentPtype:@"2"];
            break;
        default:
            break;
    }
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsRegistered = NO;
    if (nibsRegistered == NO ) {
        UINib * nib = [UINib nibWithNibName:@"Cell_ScreenTag" bundle:nil];
        [self.collectionView  registerNib:nib forCellWithReuseIdentifier:cellIdentifier_cv];
        nibsRegistered = YES;
    }
    Cell_ScreenTag * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_cv forIndexPath:indexPath];
    Model_ParentLabel * model = self.tagArr[indexPath.row];
    cell.model = model;
    
    UIView * selectedView = [[UIView alloc]initWithFrame:cell.bounds];
    selectedView.backgroundColor = [UIColor colorWithHexString:@"FA9924"];
    cell.selectedBackgroundView = selectedView;
    
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 2;
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Model_ParentLabel * model = self.tagArr[indexPath.row];
    NSLog(@"model.tagID = %@",model.id);
    [UserInfoTool saveCurrentLabelID:model.id];
    
}



-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.bgView.frame.size.width-30)/2, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}




#pragma mark - Request
- (void)requestParentLabel
{
    
    [AFNHttpTools getDataWithUrl:@"label/getParentLabel" andParameters:nil successed:^(NSDictionary *dict) {
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"json = %@",json);
        Model_SearchParentLabel * searchModel = [[Model_SearchParentLabel alloc]initWithString:json error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            [self.tagArr removeAllObjects];
            [self.tagArr addObjectsFromArray:searchModel.responseText];
            [self.collectionView reloadData];
        }else{
            NSLog(@"返回信息 = %@",searchModel.message);
        }
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [self.view makeToast:dTips_connectionError duration:1.0 position:CSToastPositionCenter];
    }];
}




@end
