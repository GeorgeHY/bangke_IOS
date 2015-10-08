//
//  LeftMenuViewController.m
//  MUGH
//
//  Created by iwind on 15/2/9.
//  Copyright (c) 2015年 MUGH. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "CONSTANT.h"
//#import "GlobalKeys.h"
//#import "LeftMenuCollectionViewCell.h"
#import "UIViewController+ECSlidingViewController.h"
//#import "DetailDemoViewController.h"
#import "UIColor+AddColor.h"
#import "Cell_LeftMenu.h"
#import "OrderViewController.h"
#import "ECSlidingViewController.h"
#import "BillViewController.h"
#import "MineFundViewController.h"
#import "MineCommunityViewController.h"
#import "MineMessageViewController.h"
#import "WeTalkListViewController.h"
#import "ScreeningViewController.h"
#import "MineInfoViewController.h"
#import "SettingViewController.h"
#import "UserInfoTool.h"
#import "Model_Request.h"
#import "UIButton+WebCache.h"
#import "UIView+BlocksKit.h"
#import "Model_SearchLeftMenu.h"
#import "Model_SearchReviewOrder.h"

static NSString *CellIdentifier = @"LeftMenuCell";
@interface LeftMenuViewController () <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate>
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UITableView *menuList;
@property (strong, nonatomic) UIView *optionView;
@property (strong, nonatomic) NSArray * menuItems;
@property (strong, nonatomic) NSMutableArray * iconArr;
@property (strong, nonatomic) UIButton * homePageBtn;
@property (nonatomic, strong) UINavigationController * homePageNavigationController;
@property (nonatomic, strong) NSDictionary * iconDic;
@property (nonatomic,strong) UIImageView * iv1;
@property (nonatomic,strong) NSArray * iconNameArr;
@property (nonatomic, strong)ECSlidingViewController * slidingVC;
//@property (nonatomic, strong)ECSlidingViewController * slidingVC2;
@property (nonatomic, strong) NSString * headUrl;
@property (nonatomic, strong) UIButton * headBtnImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * recommendLabel;//好评数
@property (nonatomic, strong) UIImageView * certifyIV;//是否认证图片

@end

@implementation LeftMenuViewController



-(void)viewDidLoad{
    
    [self createUI];
//    NSString * token = [UserInfoTool getToken];
//    if (token.length > 0) {
//        [self requestPersonHeadPhotoUrlWithToken:token];
//    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    NSString * token = [UserInfoTool getToken];
    if (token.length > 0) {
        [self requestPersonHeadPhotoUrlWithToken:token];
    }
    
    [UserInfoTool deleteCurrentPtype];
    [UserInfoTool deleteCurrentLabelID];
    [UserInfoTool deleteCurrentTVTag];
    
}
- (void)createUI {
    WEAK_SELF(weakSelf);
    NSLog(@"%@",NSStringFromCGRect([[UIScreen mainScreen]bounds]));
    
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UIImageView * bgView1 = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgView1.image = [UIImage imageNamed:@"首页菜单-背景"];
    [self.view addSubview:bgView1];
    bgView1.userInteractionEnabled = YES;
    //头view
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBounds.size.width, 195)];
    [bgView1 addSubview:self.topView];
    self.topView.userInteractionEnabled = YES;
    
    //用户头像btn
    UIButton * headBtn = [[UIButton alloc]initWithFrame:self.topView.bounds];
    [headBtn addTarget:self action:@selector(headBtnTapped) forControlEvents:UIControlEventTouchUpInside];
//    [headBtn showPlaceHolderWithLineColor:[UIColor whiteColor]];
//    [headBtn setImage:[UIImage imageNamed:@"img_3"] forState:UIControlStateNormal];
    headBtn.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:headBtn];
    
    
    
    //头像imageView
    
    
    self.headBtnImg  = [[UIButton alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(15), RECTFIX_HEIGHT(69), RECTFIX_WIDTH(84),RECTFIX_HEIGHT(84))];
    [self.headBtnImg setBackgroundImage:[UIImage imageNamed:@"img_3"] forState:UIControlStateNormal];
    
    self.headBtnImg.layer.masksToBounds = YES;
    self.headBtnImg.layer.cornerRadius = RECTFIX_WIDTH(42);
    self.headBtnImg.backgroundColor = [UIColor lightGrayColor];
    [self.headBtnImg addTarget:self action:@selector(modifyHeadPhoto) forControlEvents:UIControlEventTouchUpInside];
    //    headBtnIv.alpha = 0.5;
    [self.topView addSubview:self.headBtnImg];

    
    //用户昵称
    self.nameLabel = [UILabel new];
    [self.topView addSubview:self.nameLabel];
//    [nameLabel showPlaceHolderWithLineColor:[UIColor yellowColor]];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headBtnImg.mas_right).with.offset(RECTFIX_WIDTH(20));
        make.top.mas_equalTo(weakSelf.topView.mas_top).with.offset(89);
        make.size.mas_equalTo(CGSizeMake(RECTFIX_WIDTH(100), 20));
    }];
    
    
    
    self.nameLabel.text = @"张远山";
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    //推荐数
    self.recommendLabel = [UILabel new];
    [self.topView addSubview:self.recommendLabel];
//    [recommendLabel showPlaceHolderWithLineColor:[UIColor yellowColor]];
    [self.recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headBtnImg.mas_right).with.offset(22);
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).with.offset(17.5);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
    
    
    
    self.recommendLabel.text = @"推荐数50";
    self.recommendLabel.textColor = [UIColor whiteColor];
    self.recommendLabel.textAlignment = NSTextAlignmentLeft;
    self.recommendLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
    
    //认证
    self.certifyIV = [UIImageView new];
    [self.topView addSubview:self.certifyIV];
    //    [certifyIV showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.certifyIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLabel.mas_right).with.offset(0);
        make.centerY.mas_equalTo(weakSelf.nameLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(35, 15));
    }];
    self.certifyIV.image = [UIImage imageNamed:@"首页菜单-已认证_03"];
    //右箭头
    UIImageView * arrowIV = [UIImageView new];
    [self.topView addSubview:arrowIV];
//    [arrowIV showPlaceHolderWithLineColor:[UIColor redColor]];
    [arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.certifyIV.mas_right).with.offset(30);
        make.centerY.mas_equalTo(weakSelf.headBtnImg.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(8.5, 15));
    }];
    arrowIV.image = [UIImage imageNamed:@"首页菜单-箭头_07"];
    
    //背景view
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame),kMainScreenWidth, kMainScreenHeight * 0.55)];
    bgView.backgroundColor = [UIColor clearColor];
    [bgView1 addSubview: bgView];
    
    //menulist TableView
    self.menuList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kMainScreenWidth, kMainScreenBounds.size.height * 0.55) ];//276
    self.menuList.backgroundColor = [UIColor clearColor];
    [bgView addSubview: self.menuList];
    self.menuList.separatorStyle = UITableViewCellSelectionStyleNone;//点中没有颜色
    self.menuList.bounces = NO;
    self.menuList.delegate = self;
    self.menuList.dataSource = self;
    
    //设置view
    self.optionView = [UIView new];
    [bgView1 addSubview:self.optionView];
    [self.optionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView1.mas_left).with.offset(0);
        make.bottom.mas_equalTo(bgView1.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kMainScreenWidth, 100));
    }];
    self.optionView.userInteractionEnabled = YES;
    
    //设置btn
    
    
    UIButton * optionBtn = [UIButton new];
    [self.optionView addSubview:optionBtn];
//    [optionBtn showPlaceHolderWithLineColor:[UIColor whiteColor]];
    optionBtn.backgroundColor = [UIColor clearColor];
    [optionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionView.mas_left).with.offset(20);
        make.bottom.mas_equalTo(weakSelf.optionView.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        
    }];
    [optionBtn addTarget:self action:@selector(optionBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //按钮图标
    UIImageView * optionIV = [UIImageView new];
    [optionBtn addSubview:optionIV];
    [optionIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(optionBtn.mas_left).with.offset(10);
        make.centerY.mas_equalTo(optionBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    optionIV.image = [UIImage imageNamed:@"首页菜单-32设置_15"];
    //按钮文字
    UILabel * optionLabel = [UILabel new];
    [optionBtn addSubview:optionLabel];
    [optionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(optionIV.mas_right).with.offset(10);
        make.right.mas_equalTo(optionBtn.mas_right).with.offset(0);
        make.centerY.mas_equalTo(optionBtn.mas_centerY);
        make.height.equalTo(@20);
    }];
    optionLabel.text = @"设置";
    optionLabel.textColor = [UIColor whiteColor];
    optionLabel.font = [UIFont systemFontOfSize:16];
    optionLabel.alpha = 0.6;
    
    
    //取消btn
    UIButton * cancelBtn = [UIButton new];
    [self.optionView addSubview:cancelBtn];
//    [cancelBtn showPlaceHolderWithLineColor:[UIColor whiteColor]];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(optionBtn.mas_right).with.offset(20);
        make.bottom.mas_equalTo(weakSelf.optionView.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [cancelBtn addTarget:self action:@selector(cancelBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮图标
    UIImageView * cancelIV = [UIImageView new];
    [cancelBtn addSubview:cancelIV];
    [cancelIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cancelBtn.mas_left).with.offset(10);
        make.centerY.mas_equalTo(cancelBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    cancelIV.image = [UIImage imageNamed:@"首页菜单-退出_15"];
    
    //按钮文字
    UILabel * cancelLabel = [UILabel new];
    [cancelBtn addSubview:cancelLabel];
    [cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cancelIV.mas_right).with.offset(10);
        make.right.mas_equalTo(cancelBtn.mas_right).with.offset(0);
        make.centerY.mas_equalTo(cancelBtn.mas_centerY);
        make.height.equalTo(@20);
    }];

    cancelLabel.text = @"注销";
    cancelLabel.font = [UIFont systemFontOfSize:16];
    cancelLabel.textColor = [UIColor whiteColor];
    cancelLabel.alpha = 0.6;
    
    

    
    
    self.menuItems = [[NSArray alloc]initWithObjects:@"发的订单",@"接的订单",@"帮客资金",@"我的收货地址",@"我的消息",nil];
    
    self.iconNameArr = [[NSArray alloc]initWithObjects:@"首页菜单-1_11",@"首页菜单-2_11",@"首页菜单-4_11",@"首页菜单-5_11",@"首页菜单-6_11",nil];
    
    self.homePageNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
    
    [self.menuList registerClass:[Cell_LeftMenu class] forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - Action

- (void)modifyHeadPhoto
{
    NSLog(@"测试点击头像");
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}
///头像btn action
-(void)headBtnTapped{
    NSLog(@"跳转到个人信息");
    MineInfoViewController * infoVC = [[MineInfoViewController alloc]init];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:infoVC];
    infoVC.title = @"我的资料";
    [self presentViewController:navi animated:YES completion:nil];
}

///设置btn action
-(void)optionBtnTapped:(UIButton *)btn{
//    self.iv1 = [UIColor colorWithRed:47/255 green:39/255 blue:37/255 alpha:0.5];
    NSLog(@"设置");
    SettingViewController * settingVC = [[SettingViewController alloc]init];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:settingVC];
    settingVC.title = @"设置";
    [self presentViewController:navi animated:YES completion:nil];
//    DetailDemoViewController * detailVC = [[DetailDemoViewController alloc]init];
//    [self presentViewController:detailVC animated:YES completion:^{
////        btn.backgroundColor = [UIColor blackColor];
//    }];
    
}

///注销btn action
-(void)cancelBtnTapped:(UIButton*)btn{
    NSLog(@"注销");
    NSString * username = [UserInfoTool getUserName];
    if (username.length > 0) {
        [self unbindCidWithUserName:username];
    }
    [UserInfoTool deleteToken];
    [UserInfoTool deleteCurrentAccountID];
    self.slidingViewController.topViewController = self.homePageNavigationController;
    [self.slidingViewController resetTopViewAnimated:YES];
//    btn.backgroundColor = [UIColor lightGrayColor];
    
//    DetailDemoViewController * detailVC = [[DetailDemoViewController alloc]init];
//    [self presentViewController:detailVC animated:YES completion:^{
////        btn.backgroundColor = [UIColor blackColor];
//    }];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Cell_LeftMenu * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //图标
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(32.5, 10, 20, 20)];
    iv.image = [UIImage imageNamed:self.iconNameArr[indexPath.row]];
    [cell.contentView addSubview:iv];

    
    
    
    //文字
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iv.frame) + 20, 0, 150, cell.frame.size.height)];
//    [label showPlaceHolderWithLineColor:[UIColor redColor]];
    [cell.contentView addSubview:label];
    label.text = self.menuItems[indexPath.row];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"2e3d57"];
    
    //箭头图标
    UIImageView * rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+35, 12.5, 8.5, 15)];
    rightArrow.image = [UIImage imageNamed:@"首页菜单-箭头_07"];
    [cell.contentView  addSubview:rightArrow];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UINavigationController * navi;
    if (indexPath.row == 0) {//发的订单
        OrderViewController * orderVC = [[OrderViewController alloc]init];
        orderVC.source = 1;
        navi = [[UINavigationController alloc]initWithRootViewController:orderVC];
        self.slidingVC = [[ECSlidingViewController alloc]initWithTopViewController:navi];
        ScreeningViewController * screenVC = [[ScreeningViewController alloc]init];
        self.slidingVC.underRightViewController = screenVC;
        self.slidingVC.anchorLeftPeekAmount = 100;
        [self presentViewController:self.slidingVC animated:YES completion:nil];
        
    }else if (indexPath.row == 1){//接的订单
        OrderViewController * orderVC = [[OrderViewController alloc]init];
        orderVC.source = 2;
        navi = [[UINavigationController alloc]initWithRootViewController:orderVC];
        self.slidingVC = [[ECSlidingViewController alloc]initWithTopViewController:navi];
        ScreeningViewController * screenVC = [[ScreeningViewController alloc]init];
        self.slidingVC.underRightViewController = screenVC;
        self.slidingVC.anchorLeftPeekAmount = 100;
        [self presentViewController:self.slidingVC animated:YES completion:nil];
        
    }else if (indexPath.row == 2){//帮客资金
        MineFundViewController * fundVC = [[MineFundViewController alloc]initWithNibName:@"MineFundViewController" bundle:nil];
        navi = [[UINavigationController alloc]initWithRootViewController:fundVC];
        fundVC.title = @"我的资金";
        [self presentViewController:navi animated:YES completion:nil];
        
    }else if (indexPath.row == 3){//我的社区
        MineCommunityViewController * communityVC = [[MineCommunityViewController alloc]init];
        navi = [[UINavigationController alloc]initWithRootViewController:communityVC];
        communityVC.title = @"我的社区";
        [self presentViewController:navi animated:YES completion:nil];
    }else if (indexPath.row == 4){//我的消息
        MineMessageViewController * messageVC = [[MineMessageViewController alloc]init];
        navi = [[UINavigationController alloc]initWithRootViewController:messageVC];
        messageVC.title = @"我的消息";
        [self presentViewController:navi animated:YES completion:nil];
    }
    
    
    
}



-(void)viewDidDisappear:(BOOL)animated{
//        self.homePageBtn.backgroundColor = [UIColor colorWithHexString:@"#1b1a26"];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    //状态栏变色
    return UIStatusBarStyleLightContent;
}

#pragma mark - RequestAction
///解除个推绑定
- (void)unbindCidWithUserName:(NSString *)username
{
    [AFNHttpTools requestWithUrl:@"partner/aliasUnBindAll" successed:^(NSDictionary *dict) {
        NSLog(@"dict = %@",dict);
        NSString * state = [dict objectForKey:@"state"];
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
    } andKeyVaulePairs:@"userId",username, nil];
}
///获取用户头像url
- (void)requestPersonHeadPhotoUrlWithToken:(NSString *)token
{
    WEAK_SELF(weakSelf);
    [AFNHttpTools requestWithUrl:@"permissions/user/queryHeadImage" successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_SearchLeftMenu * searchModel = [[Model_SearchLeftMenu alloc]initWithString:jsonStr error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            weakSelf.headUrl = searchModel.responseText.head_portrait;
//            [weakSelf.headBtnImg sd_setImageWithURL:[NSURL URLWithString:weakSelf.headUrl] forState:UIControlStateNormal];
            [weakSelf.headBtnImg sd_setBackgroundImageWithURL:[NSURL URLWithString:weakSelf.headUrl] forState:UIControlStateNormal];
            if (searchModel.responseText.nickname && searchModel.responseText.nickname.length > 0&& ![searchModel.responseText.nickname isEqualToString:@""] ) {
                self.nameLabel.text = searchModel.responseText.nickname;
            }
            self.recommendLabel.text = searchModel.responseText.count;
            //是否认证需要添加图片
            if (searchModel.responseText.certification.integerValue == 2) {
                self.certifyIV.image = [UIImage imageNamed:@"首页菜单-已认证_03"];
            }else{
                self.certifyIV.image = [UIImage imageNamed:@"首页菜单-未认证_03"];
            }
            
        }else if ([searchModel.state isEqualToString:dStateTokenInvalid]) {
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            [weakSelf.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
        }
    } failed:^(NSError *err) {
        NSLog(@"%d",err.code);
        NSLog(@"err = %@",[err localizedDescription]);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    } andKeyVaulePairs:@"access_token",token, nil];
}

///修改用户头像
- (void)modifyPeopleHeadPhotoWithToken:(NSString *)token
                              andImageKey:(NSString *)imageKey
{
    WEAK_SELF(weakSelf);
    [AFNHttpTools requestWithUrl:@"permissions/user/updateUserHeadImage" successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        NSString * state = [dict objectForKey:@"state"];
        NSString * message = [dict objectForKey:@"message"];
        if ([state isEqualToString:dStateSuccess]) {
            [weakSelf.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
            //[weakSelf requestPersonHeadPhotoUrlWithToken:token];
        }else if ([state isEqualToString:dStateTokenInvalid]) {
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            [weakSelf.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    } andKeyVaulePairs:@"access_token",token,@"headimage",imageKey,nil];
}
///七牛上传
- (void)getQNKeyWithImage:(UIImage *)image
           andAccessToken:(NSString *)accessToken
{
    WEAK_SELF(weakSelf);
    [AFNHttpTools requestWithUrl:@"partner/getQiniuToken" andPostDict:nil successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_Request * requestModel = [[Model_Request alloc]initWithString:jsonStr error:nil];
        if ([requestModel.state isEqualToString:dStateSuccess]) {
            NSString * QNToken = requestModel.responseText;
            QNUploadManager * upManager = [QNUploadManagerTool sharedQNUploadManager];
                [upManager putData:UIImageJPEGRepresentation(image, 0.1) key:[@"IMG"stringByAppendingString:[TimeTool since1970Time]] token:QNToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    NSLog(@"key = %@",key);
                    [weakSelf modifyPeopleHeadPhotoWithToken:accessToken andImageKey:key];
                    
                    
                } option:nil];
                
                
            }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
    }];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"拍照");
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            
            imagePicker.sourceType = sourceType;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1:
        {
            NSLog(@"从手机相册选择");
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.sourceType = sourceType;
            [self presentViewController:imagePicker animated:YES completion:nil];
            break;
        }
        case 2:
        {
            NSLog(@"取消");
            [actionSheet dismissWithClickedButtonIndex:2 animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"--------使用照片");
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    //照相机选取
    //    NSLog(@"********使用照片");
    //
    //    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    //    [param setValue:self.nickName forKey:@"nickName"];
    //    [param setValue:[UserInfoTool getD_id] forKey:@"D_id"];
    //    UIImage * currentImage =  [info objectForKey:UIImagePickerControllerOriginalImage];
    //    [AFNHttpTools imageRequestWithUrl:@"account/uploadUserImg" postDict:param image:currentImage successed:^(NSDictionary *dict) {
    //        NSLog(@"%@",dict);
    //
    //    } failed:^(NSError *err) {
    //        NSLog(@"%@",err);
    //    }];
    //
    //    [picker dismissViewControllerAnimated:YES completion:^{
    //
    ////         [self.tableView reloadData];
    //    }];
    //照相机选取
    NSLog(@"********使用照片");
    UIImage * currentImage =  [info objectForKey:UIImagePickerControllerOriginalImage];
        NSString * token = [UserInfoTool getToken];
    if (token.length > 0) {
        [self getQNKeyWithImage:currentImage andAccessToken:token];
    }
    [self.headBtnImg setBackgroundImage:currentImage forState:UIControlStateNormal];

    
    

    [picker dismissViewControllerAnimated:YES completion:^{
        
        //         [self.tableView reloadData];
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消");
    [picker dismissViewControllerAnimated:YES completion:nil];
}




@end
