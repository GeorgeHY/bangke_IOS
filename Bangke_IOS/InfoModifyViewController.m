//
//  InfoModifyViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/25.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "InfoModifyViewController.h"
#import "Model_SearchUser.h"

@interface InfoModifyViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITextField * tf;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation InfoModifyViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.currentKey isEqualToString:@"性别"]) {
        self.tableView.hidden = NO;
        self.tf.hidden = YES;
    }else{
        self.tableView.hidden = YES;
        self.tf.hidden = NO;
    }
    
    
    if ([self.currentModifyInfo isEqualToString:@"女"]) {
        self.currentIndex = 1;
    }else if ([self.currentModifyInfo isEqualToString:@"男"]){
         self.currentIndex = 0;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改信息";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    [rightItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self createUI];
}

- (void)createUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNaviMaxY, SCREEN_WIDTH, RECTFIX_HEIGHT(88))];
    //[self.tableView showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tf = [[UITextField alloc]initWithFrame:CGRectMake(0, kNaviMaxY, kMainScreenWidth, 50)];
    self.tf.backgroundColor = [UIColor greenColor];
    self.tf.text = self.currentModifyInfo;
    [self.view addSubview:self.tf];
}

#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)saveAction
{
    NSLog(@"保存");
    NSLog(@"self.currentKey = %@",self.currentKey);
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    NSString * paramKey = nil;
    if ([self.currentKey isEqualToString:@"昵称"]) {
        paramKey = @"nickname";
    }else if ([self.currentKey isEqualToString:@"年龄"]){
        paramKey = @"age";
    }else if ([self.currentKey isEqualToString:@"性别"]){
        paramKey = @"sex";
    }else if ([self.currentKey isEqualToString:@"个人简介"]){
        paramKey = @"introduction";
    }
    [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
    if ([self.currentKey isEqualToString:@"性别"]) {
        
        [param setValue:[NSString stringWithFormat:@"%d",self.currentIndex + 1] forKey:@"sex"];
    }else{
        [param setValue:self.tf.text forKey:paramKey];
    }
    
    
    NSLog(@"param = %@",param);
    [AFNHttpTools putDataWithUrl:@"permissions/user/userInfo" andParameters:param successed:^(NSDictionary *dict) {
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"json = %@",json);
        Model_SearchUser * searchModel = [[Model_SearchUser alloc]initWithString:json error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            [self.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([searchModel.state isEqualToString:dStateTokenInvalid]) {
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            [self.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"男";
    }else{
        cell.textLabel.text = @"女";
    }
    
    
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==self.currentIndex){
        return UITableViewCellAccessoryCheckmark;
    }
    else{
        return UITableViewCellAccessoryNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row==self.currentIndex){
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:self.currentIndex
                                                   inSection:0];
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    self.currentIndex=indexPath.row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RECTFIX_HEIGHT(44);
}

@end
