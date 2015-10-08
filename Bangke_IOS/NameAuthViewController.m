//
//  NameAuthViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/4/29.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "NameAuthViewController.h"
#import "UIView+BlocksKit.h"
#import "Model_SearchNameAuth.h"
#import "Model_Request.h"
#import "Cell_IDCard.h"
#import "UIImageView+WebCache.h"


@interface NameAuthViewController () <UIScrollViewDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITextField * nameTF;//姓名输入框
@property (nonatomic, strong) UITextField * IDTF;//身份证输入框
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIImagePickerController * imagePicker;
@property (nonatomic, strong) UIButton * IDCardBtn1;
@property (nonatomic, strong) UIButton * IDCardBtn2;
@property (nonatomic, strong) UIImage * currentFrontImage;
@property (nonatomic, strong) UIImage * currentBackImage;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * cardIvArr;
@property (nonatomic, strong) NSMutableArray * cardImgArr;
@property (nonatomic, strong) NSIndexPath * currentIndexPath;
@property (nonatomic, strong) NSString * QNUToken;
@property (nonatomic, strong) NSString * forwardKey;
@property (nonatomic, strong) NSString * backKey;
@property (nonatomic, strong) Cell_IDCard * currentCell;

@end

@implementation NameAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.title = @"实名认证";
    NSString * defaultImage1Url = @"default";
    NSString * defaultImage2Url = @"default";
    UIImage * defaultImage1 = [UIImage imageNamed:@"添加证件照.jpg"];
    UIImage * defaultImage2 = [UIImage imageNamed:@"添加证件照.jpg"];
    self.cardIvArr = [NSMutableArray arrayWithCapacity:2];
    self.cardImgArr = [NSMutableArray arrayWithCapacity:2];
    [self.cardIvArr addObject:defaultImage1Url];
    [self.cardIvArr addObject:defaultImage2Url];
    [self.cardImgArr addObject:defaultImage1];
    [self.cardImgArr addObject:defaultImage2];
    
    [self createUI];
     NSString * token = [UserInfoTool getToken];
    if (token.length > 0) {
        [self requestNameAuthInfoWith:token];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    WEAK_SELF(weakSelf);
    //添加身份证照片
//    self.scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 224, kMainScreenWidth, kMainScreenHeight - CGRectGetMaxY(self.IDTF.frame))];
//    self.scrollView.contentSize= CGSizeMake(kMainScreenWidth, 495);
//    self.scrollView.delegate = self;
//    self.scrollView.backgroundColor = [UIColor greenColor];
//    [self.scrollView showPlaceHolderWithLineColor:[UIColor blackColor]];
//    self.scrollView.scrollEnabled = YES;
//    self.scrollView.showsVerticalScrollIndicator = YES;
//    self.scrollView.userInteractionEnabled = YES;
//    [self.view addSubview:self.scrollView];
//    self.IDCardBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, kMainScreenWidth-30, 225)];
//    if (![self.currentFrontImage isKindOfClass:[NSNull class]]) {
//        [self.IDCardBtn1 setImage:self.currentFrontImage forState:UIControlStateNormal];
//    }
//    [self.IDCardBtn1 setTitle:@"11111" forState:UIControlStateNormal];
////    self.IDCardBtn.backgroundColor = [UIColor redColor];
//    [self.IDCardBtn1 addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:self.IDCardBtn1];
    
//    UILabel * lbl3= [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kMainScreenWidth-30, 225)];
//    lbl3.text = @"11111111111";
//    lbl3.backgroundColor = [UIColor redColor];
//    [lbl3 bk_whenTapped:^{
//        NSLog(@"111111------ 添加照片");
//    }];
//    [self.scrollView addSubview:lbl3];
    
//    UILabel * lbl4 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.IDCardBtn1.frame)+15, kMainScreenWidth-30, 225)];
//    lbl4.text = @"22222222222";
//    lbl4.backgroundColor = [UIColor blueColor];
//    [lbl4 bk_whenTapped:^{
//        NSLog(@"222222------ 添加照片");
//    }];
//    [self.scrollView addSubview:lbl4];
    
    
    
}

- (void)createUI
{
    WEAK_SELF(weakSelf);
    //tipLabel
    UILabel * tipLabel = [UILabel new];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top).with.offset(kNaviMaxY);
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.equalTo(@40);
    }];
    tipLabel.backgroundColor = [UIColor yellowColor];
    tipLabel.text = @"请输入身份证号并上传手持证件照，完成认证";
    tipLabel.textColor =[UIColor redColor];
    tipLabel.font = [UIFont systemFontOfSize:14];
    
    //真实姓名
    self.nameTF = [UITextField new];
    [self.view addSubview:self.nameTF];
    //    [self.phoneNumTF showPlaceHolder];
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.mas_equalTo(tipLabel.mas_bottom).with.offset(0);
        make.height.equalTo(@60);
        
    }];
    self.nameTF.delegate = self;
    self.nameTF.backgroundColor = [UIColor whiteColor];
    self.nameTF.placeholder = @"请输入真实姓名";
    UIView * nameLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    UILabel * lbl1 = [[UILabel alloc]initWithFrame:nameLV.bounds];
    lbl1.text = @"真实姓名";
    lbl1.textAlignment = NSTextAlignmentCenter;
    [nameLV addSubview:lbl1];
    self.nameTF.leftView = nameLV;
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    
    //身份证号
    self.IDTF = [UITextField new];
    [self.view addSubview:self.IDTF];
    //    [self.phoneNumTF showPlaceHolder];
    [self.IDTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.mas_equalTo(weakSelf.nameTF.mas_bottom).with.offset(0);
        make.height.equalTo(@60);
        
    }];
    self.IDTF.delegate = self;
    self.IDTF.backgroundColor = [UIColor whiteColor];
    self.IDTF.placeholder = @"请输入身份证号码";
    UIView * IDLV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    UILabel * lbl2 = [[UILabel alloc]initWithFrame:IDLV.bounds];
    lbl2.text = @"身份证号";
    lbl2.textAlignment = NSTextAlignmentCenter;
    [IDLV addSubview:lbl2];
    self.IDTF.leftView = IDLV;
    self.IDTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 224, kMainScreenWidth, kMainScreenHeight - 224- 90)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor blueColor];
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
 
    //提交按钮
    UIButton * submitBtn = [UIButton new];
    [self.view addSubview:submitBtn];
    [self.view bringSubviewToFront:submitBtn];
//    [submitBtn showPlaceHolderWithLineColor:[UIColor blackColor]];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(15);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(-15);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(-20);
        make.height.equalTo(@50);
    }];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor colorWithHexString:@"FA9924"];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - Action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)testAction{
    NSLog(@"测试 ");
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate= self;
    self.imagePicker.allowsEditing = YES;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.sourceType = sourceType;
    [self performSelector:@selector(presentCameraView) withObject:nil afterDelay:1.0f];
    
    
    
}
- (void)submitAction{
    //获取七牛token
    [self getQNUToken];
//    if (self.forwardKey.length > 0 && self.backKey.length > 0) {
    
//    }
    
//    QNUploadManager * upManager = [QNUploadManagerTool sharedQNUploadManager];
//    UIImage * forwardImg = self.cardIvArr.firstObject;
////    NSData * forwardData = UIImageJPEGRepresentation(forwardImg, 0.5);
////    NSString * fileName = [@"IMG"stringByAppendingString:[TimeTool since1970Time]];
////    NSLog(@"fileName = %@",fileName);
//    if (self.QNUToken.length > 0 ) {
//        [upManager putData:UIImageJPEGRepresentation(forwardImg, 0.5) key:[@"IMG"stringByAppendingString:[TimeTool since1970Time]] token:self.QNUToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//            NSLog(@"info = %@",info);
//            NSLog(@"key = %@",key);
//            NSLog(@"resp = %@",resp);
//        } option:nil];
//    }
    
    
    
    
    
    
    
//    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
//    [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
//    [param setValue:self.nameTF.text forKey:@"real_name"];
//    [param setValue:self.IDTF.text forKey:@"card"];
//    [param setValue:@"/bk-portal/images/u16_normal.png" forKey:@"card_forwad"];
//    [param setValue:@"/bk-portal/images/u16_normal.png" forKey:@"card_back"];
//    
//    
//    [AFNHttpTools requestWithUrl:@"permissions/baseuser/certification" successed:^(NSDictionary *dict) {
//        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
//        Model_Request * requestModel = [[Model_Request alloc]initWithString:json error:nil];
//        if ([requestModel.state isEqualToString:dStateSuccess]) {
//            [self.view makeToast:requestModel.message duration:1.0 position:CSToastPositionCenter];
//        }else{
//            [self.view makeToast:requestModel.message duration:1.0 position:CSToastPositionCenter];
//        }
//    } failed:^(NSError *err) {
//        NSLog(@"err = %@",[err localizedDescription]);
//        [self.view makeToast:dTips_connectionError duration:1.0 position:CSToastPositionCenter];
//    } andKeyVaulePairs:@"access_token",[UserInfoTool getToken],@"real_name",self.nameTF.text,@"card",self.IDTF.text,@"card_forwad",@"/bk-portal/images/u16_normal.png",@"card_back",@"/bk-portal/images/u16_normal.png",nil];
    //图片没做暂时那么传
}

- (void)presentCameraView{
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}
#pragma mark - Request
- (void)requestNameAuthInfoWith:(NSString *)token
{
    WEAK_SELF(weakSelf);
    NSDictionary * param = [NSDictionary dictionaryWithObject:token forKey:@"access_token"];
    [AFNHttpTools getDataWithUrl:@"permissions/baseuser/certification" andParameters:param successed:^(NSDictionary *dict) {
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"json = %@",json);
        Model_SearchNameAuth * searchModel = [[Model_SearchNameAuth alloc]initWithString:json error:nil];
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            
            if (searchModel.responseText.real_name && ![searchModel.responseText.real_name isEqualToString:@""]) {
                weakSelf.nameTF.text = searchModel.responseText.real_name;
            }
            
            if (searchModel.responseText.card && ![searchModel.responseText.card isEqualToString:@""]) {
                weakSelf.IDTF.text = searchModel.responseText.card;
            }
            
            if (searchModel.responseText.card_forwad && ![searchModel.responseText.card_forwad isEqualToString:@""]) {
                NSString * forwardUrl = searchModel.responseText.card_forwad;
                [weakSelf.cardIvArr replaceObjectAtIndex:0 withObject:forwardUrl];
            }
            
            if (searchModel.responseText.card_back && ![searchModel.responseText.card_back isEqualToString:@""]) {
                NSString * backUrl = searchModel.responseText.card_back;
                [weakSelf.cardIvArr replaceObjectAtIndex:1 withObject:backUrl];
            }
            
            
            
            
            
            
            
            
            [weakSelf.tableView reloadData];

            //UIImage * forwardImg = [UIImage sd]
            
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

///获取七牛token
- (void)getQNUToken
{
    WEAK_SELF(weakSelf);
    [AFNHttpTools requestWithUrl:@"partner/getQiniuToken" andPostDict:nil successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_Request * requestModel = [[Model_Request alloc]initWithString:jsonStr error:nil];
        if ([requestModel.state isEqualToString:dStateSuccess]) {
            weakSelf.QNUToken = requestModel.responseText;
            QNUploadManager * upManager = [QNUploadManagerTool sharedQNUploadManager];
            for (NSInteger i = 0; i < weakSelf.cardImgArr.count; i++) {
                UIImage * cardImg = weakSelf.cardImgArr[i];
                [upManager putData:UIImageJPEGRepresentation(cardImg, 0.5) key:[@"IMG"stringByAppendingString:[TimeTool since1970Time]] token:self.QNUToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    NSLog(@"key = %@",key);
                    if (i == 0) {
                        weakSelf.forwardKey = key;
                        NSLog(@"weakSelf.forwardKey = %@",weakSelf.forwardKey);
                    }else{
                        weakSelf.backKey = key;
                        NSLog(@"weakSelf.backKey = %@",weakSelf.backKey);
                        [weakSelf requestModifyNameAuth];
                    }
                } option:nil];
            }

            
            
            
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
    }];
}

///修改实名认证消息
- (void)requestModifyNameAuth
{
    NSString * token = [UserInfoTool getToken];
    if (token.length > 0) {
        NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
        [param setValue:[UserInfoTool getToken] forKey:@"access_token"];
        [param setValue:self.nameTF.text forKey:@"real_name"];
        [param setValue:self.IDTF.text forKey:@"card"];
        [param setValue:self.forwardKey forKey:@"card_forwad"];
        [param setValue:self.backKey forKey:@"card_back"];
        
        [AFNHttpTools requestWithUrl:@"permissions/baseuser/certification" andPostDict:param successed:^(NSDictionary *dict) {
            NSString * json = [AFNHttpTools jsonStringWithDict:dict];
            NSLog(@"json = %@",json);
            Model_Request * requestModel = [[Model_Request alloc]initWithString:json error:nil];
            if ([requestModel.state isEqualToString:dStateSuccess]) {
                [self.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
            }else if ([requestModel.state isEqualToString:dStateTokenInvalid]) {
                [UserInfoTool deleteToken];
                [APPLICATION setHomePageVC];
            }else{
                [self.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
            }

        } failed:^(NSError *err) {
            NSLog(@"err = %@",[err localizedDescription]);
            [self.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];

    }


}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"********使用照片");
    UIImage * currentImage =  [info objectForKey:UIImagePickerControllerOriginalImage];
    self.currentCell.cardIV.image = currentImage;
    [self.cardImgArr replaceObjectAtIndex:self.currentIndexPath.row withObject:currentImage];
    NSLog(@"%@",self.cardImgArr);
//    [self.cardIvArr replaceObjectAtIndex:self.currentIndexPath.row withObject:currentImage];
//    [self.tableView reloadData];
//    self.currentFrontImage = currentImage;
//    [self.IDCardBtn1 setImage:currentImage forState:UIControlStateNormal];
//    self.modifyImage = currentImage;
//    self.headIV.image = currentImage;
//    NSMutableDictionary * param = [NSMutableDictionary dictionary];
//    //    [param setValue:self.nickName forKey:@"nickName"];
//    [param setValue:[UserInfoTool getD_id] forKey:@"D_id"];
//    [AFNHttpTools imageRequestWithUrl:@"account/uploadUserImg" postDict:param image:currentImage successed:^(NSDictionary *dict) {
//        NSLog(@"**** dict = %@",dict);
//        
//    } failed:^(NSError *err) {
//        NSLog(@"%@",err);
//    }];
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        //         [self.tableView reloadData];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_IDCard * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[Cell_IDCard alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString * imageUrl = self.cardIvArr[indexPath.row];
    UIImage * image = nil;
    if ([imageUrl isEqualToString:@"default"]) {
        cell.cardIV.image = [UIImage imageNamed:@"添加证件照.jpg"];
        image = [UIImage imageNamed:@"添加证件照.jpg"];
    }else
    {
        [cell.cardIV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        image = [UIImage imageWithData:data];
        
    }
    [self.cardImgArr replaceObjectAtIndex:indexPath.row withObject:image];
    NSLog(@"%@",self.cardImgArr);
//    UIImageView * cardIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, kMainScreenWidth - 40, 0.65*(kMainScreenWidth-40))];
//    cardIV.backgroundColor = [UIColor yellowColor];
//    cardIV.image = self.cardIvArr[indexPath.row];
    //[cell.contentView addSubview:cardIV];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (0.65*(kMainScreenWidth-40)+20);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_IDCard * cell = (Cell_IDCard *)[tableView cellForRowAtIndexPath:indexPath];
    self.currentCell = cell;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentIndexPath = indexPath;
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.sourceType = sourceType;
    [self performSelector:@selector(presentCameraView) withObject:nil afterDelay:1.0f];
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}






@end
