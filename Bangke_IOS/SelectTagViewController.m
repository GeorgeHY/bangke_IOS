//
//  SelectTagViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/4/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "SelectTagViewController.h"
#import "Masonry.h"
#import "MMPlaceHolder.h"
#import "Cell_Tag.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "Model_SelectTag.h"
#import "DistanceListViewController.h"
#import "Model_SearchParentLabel.h"
#import "Cell_SelectTag.h"
#import "Model_Request.h"
static NSString * cellIdentifier = @"Cell_Tag";
@interface SelectTagViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
//@property(nonatomic, strong) UICollectionView * tagCollection;
@property (nonatomic, strong) UITableView * tagTableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UIButton * btn1;
@property (nonatomic, strong) NSMutableDictionary * selectDic;
@property (nonatomic, strong) NSString * currentDis;//当前选择距离

@end

@implementation SelectTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    self.selectDic = [[NSMutableDictionary alloc]init];
    self.currentDis = @"5km";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.title = @"标签设置";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem setTintColor:[UIColor orangeColor]];
    [self createUI];
    [self requestData];
}

- (void)requestData
{
    [AFNHttpTools getDataWithUrl:@"label/getParentLabel" andParameters:nil successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        
        Model_SearchParentLabel * searchModel = [[Model_SearchParentLabel alloc]initWithString:jsonStr error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            [self.dataArr addObjectsFromArray:searchModel.responseText];
        }
            [self.tagTableView reloadData];
    }failed:^(NSError *err) {
        NSLog(@"err = %@",err);
    }];
}

-(void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    //tip
    UILabel * tipLbl = [UILabel new];
    [self.view addSubview:tipLbl];
    NSInteger padding = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    WEAK_SELF(weakSelf);
    [tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(padding);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.equalTo(@30);
    }];
    tipLbl.text = @"选择标签后将推送附近的任务给你,最多只可选择七种标签";
    tipLbl.textAlignment = NSTextAlignmentCenter;
    tipLbl.backgroundColor = [UIColor yellowColor];
    tipLbl.textColor = [UIColor redColor];
    tipLbl.font = [UIFont systemFontOfSize:12];
    
    //选择距离
    UIView * disView = [UIView new];
    [self.view addSubview:disView];
    [disView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLbl.mas_bottom).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.equalTo(@40);
    }];
    disView.backgroundColor = [UIColor redColor];
    
    UILabel * lbl1= [UILabel new];
    [disView addSubview:lbl1];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(disView.mas_left).with.offset(0);
        make.top.equalTo(disView.mas_top).with.offset(0);
        make.width.equalTo(@80);
        make.height.equalTo(disView.mas_height);
    }];
    lbl1.text = @"推送距离";
    lbl1.textAlignment = NSTextAlignmentCenter;
    lbl1.textColor = [UIColor whiteColor];
    
    self.btn1 = [UIButton new];
    [disView addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(disView.mas_right).with.offset(0);
        make.top.equalTo(disView.mas_top).with.offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(disView.mas_height);
        
    }];
    [self.btn1 setTitle:@"5km >" forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(selectDistance) forControlEvents:UIControlEventTouchUpInside];
    
    //标签列表
//    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    self.tagCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 30 + 40, kMainScreenWidth, kMainScreenHeight-(CGRectGetMaxY(self.navigationController.navigationBar.frame) + 30 + 40)) collectionViewLayout:flowLayout];
//    self.tagCollection.delegate = self;
//    self.tagCollection.dataSource = self;
//    self.tagCollection.backgroundColor = [UIColor whiteColor];
//    [self.tagCollection registerClass:[Cell_Tag class] forCellWithReuseIdentifier:cellIdentifier];
////    [self.tagCollection showPlaceHolder];
//    [self.view addSubview:self.tagCollection];
    self.tagTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNaviMaxY + 30 + 40, kMainScreenWidth, kMainScreenHeight-(kNaviMaxY + 30 + 40))];
    self.tagTableView.delegate = self;
    self.tagTableView.dataSource = self;
    [self.tagTableView registerClass:[Cell_SelectTag class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.tagTableView];
    
    
    
}


#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectDistance
{
    NSLog(@"选择距离");
    WEAK_SELF(weakSelf);
    DistanceListViewController * disListVC = [[DistanceListViewController alloc]init];
    [disListVC returnDistance:^(NSString *distance) {
        [self.btn1 setTitle:[NSString stringWithFormat:@"%@ >",distance]forState:UIControlStateNormal];
        weakSelf.currentDis = distance;
    }];
    [self.navigationController pushViewController:disListVC animated:YES];
    
    
}
- (void)saveAction
{
    WEAK_SELF(weakSelf);
    NSString * label = @"";
    NSLog(@"%d",self.selectDic.allValues.count);
    for (NSInteger i = 0; i < self.selectDic.allValues.count; i++) {
        Model_ParentLabel * model = self.selectDic.allValues[i];
        NSLog(@"model.id = %@",model.id);
        if (i != self.selectDic.allValues.count - 1) {
            label = [label stringByAppendingString:[NSString stringWithFormat:@"%@,",model.id]];
        }else{
            label = [label stringByAppendingString:model.id];
        }
    }
    NSLog(@"label = %@",label);
    NSArray * subDisStr = [self.currentDis componentsSeparatedByString:@"km"];
    NSString * tempDis = [subDisStr firstObject];
    
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
    [param setValue:[NSString stringWithFormat:@"%@000",tempDis] forKey:@"distance"];
    [param setValue:label forKey:@"lable"];
    NSLog(@"param%@",param);
    [AFNHttpTools putDataWithUrl:@"permissions/baseuser/userLable" andParameters:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"%@",jsonStr);
        Model_Request * model = [[Model_Request alloc]initWithString:jsonStr error:nil];
        [weakSelf.view makeToast:model.message duration:ToastDuration position:CSToastPositionCenter];
        if ([model.state isEqualToString:dStateSuccess]) {
            [[AppDelegate shareInstance] setHomePageVC];
//            for (UIViewController * tempVC in self.navigationController.viewControllers) {
//                if ([tempVC isKindOfClass:[LoginViewController class]]) {
//                    [self.navigationController popToViewController:tempVC animated:YES];
//                }
//                
//            }
        }
    } failed:^(NSError *err) {
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];

    
    

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_SelectTag * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Model_ParentLabel * model = self.dataArr[indexPath.row];
    cell.model = model;
    NSArray * value = [self.selectDic allKeys];
    if ([value containsObject:[NSString stringWithFormat:@"%d",indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_SelectTag * cell = (Cell_SelectTag *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        if (self.selectDic.allValues.count < 7) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.selectDic setObject:cell.model forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        }else{
            [self.view makeToast:@"最多只能选择7个标签" duration:ToastDuration position:CSToastPositionCenter];
        }
        
    }else{
        [self.selectDic removeObjectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
}

//#pragma mark UICollectionViewDataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 9;
//}


//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    Cell_Tag * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    
////    Model_SelectTag * model = self.dataArr[indexPath.row];
////    cell.model = model;
//    
//    return cell;
//}

//#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return CGSizeMake((kMainScreenWidth-40)/3, 150);
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 1;
//    
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 1;
//}
//
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}
//
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

@end
