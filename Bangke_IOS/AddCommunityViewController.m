//
//  AddCommunityViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/19.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#define TFTAG 500

#import "AddCommunityViewController.h"
#import "Model_Community.h"
#import "RegTools.h"
#import "UserInfoTool.h"
#import "Model_SearchCommunity.h"
#import "Model_Search.h"
#import "MapViewController.h"


@interface AddCommunityViewController () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) UITextField * nameTF;
@property (nonatomic, strong) UITextField * contactTF;
@property (nonatomic, strong) UITextField * phoneNumTF;
@property (nonatomic, strong) UITextView * addressTV;
@property (nonatomic, strong) UITableView * searchList;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSString * currentCommunity_id;
@property (nonatomic, strong) CurrentLocation * curLocation;//接收回传

@end

@implementation AddCommunityViewController
@synthesize delegate;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateNaviBar];
    
}

- (void)viewDidLoad {
    NSLog(@"self.type = %d",self.type);
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    
    [self createUI];
    [self initSearchList];
    
}

- (void)updateNaviBar
{
//    if (self.type == 3) {
        self.navigationController.navigationBar.hidden = NO;
//    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(okAction:)];
//    if (self.type == 1) {
//        self.title = @"编辑社区信息";
////        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"增加" style:UIBarButtonItemStyleDone target:self action:@selector(okAction:)];
//        
//        [rightItem setTitle:@"完成"];
//    }else{
//        self.title = @"添加新社区";
//        [rightItem setTitle:@"增加"];
//    }

    
    [rightItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    if (self.type == 1) {
        self.title = @"编辑社区信息";
    }else{
        self.title = @"添加新社区";
    }
    
}
- (void)createUI
{
    //社区名称
    self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 50)];
    self.nameTF.placeholder = @"  请输入社区名称";
    self.nameTF.layer.borderWidth =1;
    self.nameTF.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.nameTF.delegate = self;
    self.nameTF.tag = TFTAG + 1;
    if (self.type == 1) {
        self.nameTF.text = self.currentCommunity.lbs_address;
    }else if (self.type == 3){
        self.nameTF.text = self.currentAddCommunity.name;
    }
    [self.view addSubview:self.nameTF];

    
//    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.nameTF.frame.size.height)];
//    UIButton * searchBtn = [[UIButton alloc]initWithFrame:rightView.bounds];
//    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
//    searchBtn.backgroundColor = [UIColor redColor];
//    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
//    [rightView addSubview:searchBtn];
//    self.nameTF.rightView = rightView;
//    self.nameTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    //请完善收获信息
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameTF.frame)+10, kMainScreenWidth, 40)];
    label.text = @"请完善收货信息";
    [self.view addSubview:label];
    
    //联系人
    self.contactTF = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+10, kMainScreenWidth, 50)];
    self.contactTF.placeholder = @"  联系人";
    self.contactTF.layer.borderWidth =1;
    self.contactTF.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.contactTF.delegate = self;
    if (self.type == 1) {
        self.contactTF.text = self.currentCommunity.contact_name;
    }
    [self.view addSubview:self.contactTF];
    
    //手机号码
    self.phoneNumTF = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contactTF.frame), kMainScreenWidth, 50)];
    self.phoneNumTF.placeholder = @"  手机号码";
    self.phoneNumTF.layer.borderWidth =1;
    self.phoneNumTF.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.phoneNumTF.delegate = self;
    if (self.type == 1) {
        self.phoneNumTF.text = self.currentCommunity.phone;
    }
    [self.view addSubview:self.phoneNumTF];
    
    //详细地址
    self.addressTV = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneNumTF.frame), kMainScreenWidth, 100)];
    self.addressTV.layer.borderWidth =1;
    self.addressTV.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.addressTV.delegate = self;
    if (self.type == 1) {
        self.addressTV.text = self.currentCommunity.receive_address;
    }
    [self.view addSubview:self.addressTV];

}

- (void)initSearchList
{
    self.searchList = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameTF.frame), kMainScreenWidth, kMainScreenHeight-CGRectGetMaxY(self.nameTF.frame))];
    self.searchList.delegate = self;
    self.searchList.dataSource =self;
    [self.view addSubview:self.searchList];
    self.searchList.backgroundColor = [UIColor blueColor];
    self.searchList.hidden = YES;
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)okAction:(UIButton *)btn
{
    
    if (self.type ==2) {//新增社区
        NSLog(@"新增社区");
        if (self.nameTF.text.length > 0 && self.contactTF.text.length > 0 && self.phoneNumTF.text.length > 0 && self.addressTV.text.length > 0 ) {
            if ([RegTools regResultWithString:self.phoneNumTF.text]) {
                NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
                [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
                [param setValue:self.addressTV.text forKey:@"receive_address"];
                [param setValue:self.nameTF.text forKey:@"lbs_address"];
                [param setValue:self.contactTF.text forKey:@"contact_name"];
                [param setValue:self.phoneNumTF.text forKey:@"phone"];
                [param setValue:@"1" forKey:@"default_select"];
                [param setValue:self.curLocation.latitude forKey:@"latitude"];
                [param setValue:self.curLocation.longitude forKey:@"longitude"];
                NSLog(@"param = %@",param);
                
                [AFNHttpTools requestWithUrl:@"permissions/address" andPostDict:param successed:^(NSDictionary *dict) {
                    NSLog(@"dict = %@",dict);
                    NSString * state = [dict objectForKey:@"state"];
                    NSString * message = [dict objectForKey:@"message"];
                    if ([state isEqualToString:dStateSuccess]) {
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else if ([state isEqualToString:dStateTokenInvalid]) {
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                        [UserInfoTool deleteToken];
                        [APPLICATION setHomePageVC];
                    }else{
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                    }

                } failed:^(NSError *err) {
                    NSLog(@"err = %@",err);
                }];
                
            }else{
                [self.view makeToast:@"请输入正确的手机号" duration:ToastDuration position:CSToastPositionCenter];
            }
        }else{
            [self.view makeToast:@"请输入完整信息" duration:ToastDuration position:CSToastPositionCenter];
        }
    }else if (self.type ==3) {//通过地图新增社区
        NSLog(@"新增社区");
        if (self.nameTF.text.length > 0 && self.contactTF.text.length > 0 && self.phoneNumTF.text.length > 0 && self.addressTV.text.length > 0 ) {
            if ([RegTools regResultWithString:self.phoneNumTF.text]) {
                [AFNHttpTools requestWithUrl:@"permissions/community" successed:^(NSDictionary *dict) {
                    NSLog(@"dict = %@",dict);
                    NSString * state = [dict objectForKey:@"state"];
                    NSString * message = [dict objectForKey:@"message"];
                    if ([state isEqualToString:dStateSuccess]) {
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else if ([state isEqualToString:dStateTokenInvalid]) {
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                        [UserInfoTool deleteToken];
                        [APPLICATION setHomePageVC];
                    }else{
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                    }
                } failed:^(NSError *err) {
                    NSLog(@"err = %@",err);
                } andKeyVaulePairs:@"access_token",[UserInfoTool getToken],@"community_id",self.currentAddCommunity.id,@"contact_name",self.contactTF.text,@"phone",self.phoneNumTF.text,@"receive_address",self.addressTV.text,@"default_select",@"1", nil];
            }else{
                [self.view makeToast:@"请输入正确的手机号" duration:ToastDuration position:CSToastPositionCenter];
            }
        }else{
            [self.view makeToast:@"请输入完整信息" duration:ToastDuration position:CSToastPositionCenter];
        }
    }else{//编辑社区
        NSLog(@"编辑社区");
        if (self.nameTF.text.length > 0 && self.contactTF.text.length > 0 && self.phoneNumTF.text.length > 0 && self.addressTV.text.length > 0 ) {
            if ([RegTools regResultWithString:self.phoneNumTF.text]) {
                NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
                [param setValue:self.currentCommunity.id forKey:@"id"];
                [param setValue:self.addressTV.text forKey:@"receive_address"];
                [param setValue:self.contactTF.text forKey:@"contact_name"];
                [param setValue:self.phoneNumTF.text forKey:@"phone"];
                [param setValue:self.currentCommunity.default_select forKey:@"default_select"];
                [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
                [param setValue:self.nameTF.text forKey:@"lbs_address"];
                NSLog(@"param = %@",param);
                [param setValue:self.curLocation.latitude forKey:@"latitude"];
                [param setValue:self.curLocation.longitude forKey:@"longitude"];
                
                [AFNHttpTools putDataWithUrl:@"permissions/address" andParameters:param successed:^(NSDictionary *dict) {
                    NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
                    NSLog(@"jsonStr = %@",jsonStr);
                    NSString * state  = [dict objectForKey:@"state"];
                    NSString * message = [dict objectForKey:@"message"];
                    if ([state isEqualToString:dStateSuccess]) {
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else if ([state isEqualToString:dStateTokenInvalid]) {
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                        [UserInfoTool deleteToken];
                        [APPLICATION setHomePageVC];
                    }else{
                        [self.view makeToast:message duration:ToastDuration position:CSToastPositionCenter];
                    }
                } failed:^(NSError *err) {
                    NSLog(@"err = %@",err);
                     [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
                }];
                
            }else{
                [self.view makeToast:@"请输入正确的手机号" duration:ToastDuration position:CSToastPositionCenter];
            }
        }else{
            [self.view makeToast:@"请输入完整信息" duration:ToastDuration position:CSToastPositionCenter];
        }

    }
    
    
    
    
//    Model_Community * model = [[Model_Community alloc]init];
//    model.name = self.nameTF.text;
//    model.contactName = self.contactTF.text;
//    model.address = self.addressTV.text;
//    model.phoneNum = self.phoneNumTF.text;
//    [self.delegate sendEditCommunity:model withType:self.type];
//    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchAction
{
    NSLog(@"搜索");
//    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
//    [param setValue:self.nameTF.text forKey:@"name"];
    self.searchList.hidden = NO;
    [self.dataArr removeAllObjects];
    [self requestSearchResultWithText:self.nameTF.text];
//    [AFNHttpTools requestWithUrl:@"community/queryCommunity" successed:^(NSDictionary *dict) {
//        NSLog(@"dict = %@",dict);
//        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
//        Model_Search * model = [[Model_Search alloc]initWithString:json error:nil];
//        if ([model.state isEqualToString:dStateSuccess]) {
//            self.dataArr = [NSMutableArray arrayWithArray:model.responseText];
//            [self.searchList reloadData];
//        }else{
//            //[self.view makeToast:model.message duration:1.0 position:CSToastPositionCenter];
//            self.searchList.hidden = YES;
//        }
//        
//
//        
//    } failed:^(NSError *err) {
//        NSLog(@"err = %@",[err localizedDescription]);
//        [self.view makeToast:dTips_connectionError duration:1.0 position:CSToastPositionCenter];
//        self.searchList.hidden = YES;
//    } andKeyVaulePairs:@"name",self.nameTF.text, nil];
}


- (void)requestSearchResultWithText:(NSString *)text
{
    [AFNHttpTools requestWithUrl:@"community/queryCommunity" successed:^(NSDictionary *dict) {
        NSLog(@"dict = %@",dict);
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        Model_Search * model = [[Model_Search alloc]initWithString:json error:nil];
        if ([model.state isEqualToString:dStateSuccess]) {
            self.dataArr = [NSMutableArray arrayWithArray:model.responseText];
            [self.searchList reloadData];
        }else if ([model.state isEqualToString:dStateTokenInvalid]) {
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            //[self.view makeToast:model.message duration:1.0 position:CSToastPositionCenter];
            self.searchList.hidden = YES;
        }
        
        
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        self.searchList.hidden = YES;
    } andKeyVaulePairs:@"name",text, nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    
//    
//    return
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag- TFTAG == 1) {
        MapViewController * mapVC = [[MapViewController alloc]init];
        self.curLocation = [[CurrentLocation alloc]init];
        [mapVC returnAddress:^(CurrentLocation *currentAddress) {
            self.curLocation = currentAddress;
            self.nameTF.text = currentAddress.address;
            
//            NSLog(@"～～～～～～～currentAddress.latitude = %@",currentAddress.latitude);
//            NSLog(@"～～～～～～～currentAddress.longitude = %@",currentAddress.longitude);
        }];
        [textField resignFirstResponder];
        [self.navigationController pushViewController:mapVC animated:YES];
        
    }
    
}




#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    Model_SearchCommunity * model = self.dataArr[indexPath.row];
    NSLog(@"%@",model.name);
    cell.textLabel.text = model.name;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Model_SearchCommunity * model = self.dataArr[indexPath.row];
    self.nameTF.text = model.name;
    self.currentCommunity_id = model.id;
    self.searchList.hidden = YES;
}



@end
