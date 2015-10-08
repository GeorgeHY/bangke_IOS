
//
//  MineInfoViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/4/28.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#define BtnTag 1000

#import "MineInfoViewController.h"
#import "Cell_PersonInfo.h"
#import "Cell_TradeInfo.h"
#import "Model_TradeInfo.h"
#import "NameAuthViewController.h"
#import "Model_SearchUser.h"
#import "InfoModifyViewController.h"
#import "Cell_HeadPhoto.h"
#import "Model_Request.h"
#import "UIImageView+WebCache.h"
#import "Model_Request.h"


@interface MineInfoViewController () <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIView * photoView;
@property (nonatomic, strong) UITableView * InfoTV;
@property (nonatomic, strong) NSArray * headArr;//标题数组
@property (nonatomic, strong) NSArray * contentArr;
@property (nonatomic, strong) Model_TradeInfo * tradeInfo;
@property (nonatomic, strong) Model_User * currentInfo;
@property (nonatomic, strong) UIButton * currentBtn;
@property (nonatomic, strong) NSMutableArray * headImgArr;//头像数组
@property (nonatomic, strong) UICollectionView * photoCV;//3张头像
@property (nonatomic, strong) UIImagePickerController * imagePicker;
@property (nonatomic, strong) Cell_HeadPhoto * currentCell;
@property (nonatomic, strong) NSMutableArray * headUrlArr;//头像url数组
@property (nonatomic, strong) NSIndexPath * currentIndexPath;
@property (nonatomic, strong) NSMutableArray * headImgKey;
@property (nonatomic, strong) NSMutableArray * selectImgArr;
@property (nonatomic, assign) NSInteger flag;



@end

@implementation MineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = 1;
    self.headImgArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIImage * defaultImage = [UIImage imageNamed:@"个人信息-添加_03"];
        [self.headImgArr addObject:defaultImage];
    }
    
    self.headUrlArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        NSString * defaultImageUrl = @"default";
        [self.headUrlArr addObject:defaultImageUrl];
    }
    
    self.headImgKey = [NSMutableArray array];
    self.selectImgArr = [NSMutableArray array];
    
   
    
    self.view.backgroundColor = [UIColor greenColor];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    [rightItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self createUI];
    NSArray * arr1 = [NSArray arrayWithObjects:@"昵称",@"年龄",@"性别",@"个人简介", nil];
    NSArray * arr2  = [NSArray  arrayWithObjects:@"实名认证",@"标签设置", nil];
    NSArray * dataArr1 = [NSArray arrayWithObjects:@"苹果派",@"24",@"男",@"苹果派",nil];
    self.headArr = [NSArray arrayWithObjects:arr1,arr2, nil];
   
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString * token = [UserInfoTool getToken];
    NSLog(@"token = %@",token);
    [self requestMineInfoWithToken:token];
    
}

-(void)createUI
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//照片view
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.photoCV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, RECTFIX_HEIGHT(120)) collectionViewLayout:flowLayout];
    self.photoCV.delegate = self;
    self.photoCV.dataSource = self;
    [self.photoCV registerClass:[Cell_HeadPhoto class] forCellWithReuseIdentifier:@"Cell_Video"];
    [self.view addSubview:self.photoCV];
    self.photoCV.backgroundColor = [UIColor blackColor];

    
//个人信息tableView
    self.InfoTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+RECTFIX_HEIGHT(120), SCREEN_WIDTH, SCREEN_HEIGHT - 64-RECTFIX_HEIGHT(120))];
    [self.view addSubview:self.InfoTV];


//    self.InfoTV.backgroundColor = [UIColor blueColor];
    self.InfoTV.delegate = self;
    self.InfoTV.dataSource = self;
//    [self.InfoTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark - Action
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveAction
{
    if (self.selectImgArr.count != 0) {
        [self getQNUToken];
    }
    
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectImage:(UIButton *)btn
{
    NSInteger btnTag = btn.tag - BtnTag;
    NSLog(@"btnTag = %ld",(long)btnTag);
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
    switch (btnTag) {
        case 0:
        {
            self.currentBtn = btn;
        }
            break;
        case 1:
        {
            NSLog(@"btnTag = %ld",(long)btnTag);
            self.currentBtn = btn;
        }
            break;
        case 2:
        {
            NSLog(@"btnTag = %ld",(long)btnTag);
            self.currentBtn = btn;
        }
            break;
        default:
            break;
    }
}
- (void)deleteAction:(UIButton *)btn
{
//    [btn setImage:[UIImage imageNamed:@"个人信息-添加_03"] forState:UIControlStateNormal];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section != 2) {
        Cell_PersonInfo * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[Cell_PersonInfo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.headLalel.text = [[self.headArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.contentLabel.text = [[self.contentArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 3)) {
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.section == 1){
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
       
        return cell;
    }else{
        Cell_TradeInfo * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
            cell = [[Cell_TradeInfo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        if ([self.tradeInfo isKindOfClass:[NSNull class]]) {
            self.tradeInfo = [[Model_TradeInfo alloc]init];
            
        }
//        Model_TradeInfo * model = [[Model_TradeInfo alloc]init];
//        model.helpInCount = @"10单";
//        model.helpInStar = @"9个";
//        model.helpOutCount = @"99单";
//        model.helpOutStar = @"80个";
        cell.model = self.tradeInfo;
        return cell;
    }

}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_PersonInfo * cell = (Cell_PersonInfo *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 1 && indexPath.row == 0) {
        NameAuthViewController * authVC = [[NameAuthViewController alloc]init];
        [self.navigationController pushViewController:authVC animated:YES];
    }else{
        InfoModifyViewController * modifyVC = [[InfoModifyViewController alloc]init];
        modifyVC.currentModifyInfo = cell.contentLabel.text;
        modifyVC.currentKey = cell.headLalel.text;
        
        //modifyVC.currentInfo = self.currentInfo;
        [self.navigationController pushViewController:modifyVC animated:YES];
    }
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 100;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
//    view.backgroundColor = [UIColor lightGrayColor];
    view.backgroundColor = [UIColor whiteColor];
    return view;
 
}
#pragma mark - Request

- (void)requestMineInfoWithToken:(NSString *)token
{
    WEAK_SELF(weakSelf);
    NSDictionary * param = [NSDictionary dictionaryWithObject:token forKey:@"access_token"];
    [AFNHttpTools getDataWithUrl:@"permissions/user/userInfo" andParameters:param successed:^(NSDictionary *dict) {
        NSString * json = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"json = %@",json);
        Model_SearchUser * searchModel = [[Model_SearchUser alloc]initWithString:json error:nil];
        NSLog(@"%@",searchModel.state);
        if ([searchModel.state  isEqualToString:dStateSuccess]) {
            weakSelf.currentInfo = searchModel.responseText;
            NSString * userSex = nil;
            (searchModel.responseText.sex.integerValue == 1) ? (userSex = @"男"):(userSex = @"女");
            //增加参数判空
            if (!searchModel.responseText.introduction||searchModel.responseText.introduction.length == 0 || [searchModel.responseText.introduction isEqualToString:@""]) {
                searchModel.responseText.introduction = @"无";
            }
            NSArray * arr1 = [NSArray arrayWithObjects:searchModel.responseText.nickname,searchModel.responseText.age,userSex,searchModel.responseText.introduction, nil];
            NSLog(@"arr1 = %@,arr1.count = %d",arr1,arr1.count);
            NSString * isCertification = nil;
            if (searchModel.responseText.certification.integerValue == 1) {
                isCertification = @"未认证";
            }else{
                isCertification = @"已认证";
            }
            
            NSArray * arr2 = [NSArray arrayWithObjects:isCertification ,searchModel.responseText.lable_names,nil];
            NSLog(@"arr2 = %@",arr2);
            weakSelf.contentArr = [NSArray arrayWithObjects:arr1,arr2,nil];
            NSArray * images = searchModel.responseText.images;
            [weakSelf.headUrlArr removeAllObjects];
            NSLog(@"images.count = %d",images.count);
            NSLog(@"weakSelf.headUrlArr.count = %d",weakSelf.headUrlArr.count);
            for (NSInteger i = 0; i<images.count; i++) {
                NSString * imgurl = images[i];
                [weakSelf.headUrlArr addObject:imgurl];
            }
//            [weakSelf.headUrlArr addObjectsFromArray:images];
            [weakSelf.photoCV reloadData];
            
            weakSelf.tradeInfo = [[Model_TradeInfo alloc]init];
            weakSelf.tradeInfo.helpOutCount = searchModel.responseText.help_num_count;
            weakSelf.tradeInfo.helpOutStar = searchModel.responseText.help_evaluate_count;
            weakSelf.tradeInfo.helpInCount = searchModel.responseText.qb_num_count;
            weakSelf.tradeInfo.helpInStar = searchModel.responseText.qb_evaluate_count;
            weakSelf.flag++;
            [weakSelf.InfoTV reloadData];
        }else if ([searchModel.state isEqualToString:dStateTokenInvalid]) {
            [UserInfoTool deleteToken];
            [APPLICATION setHomePageVC];
        }else{
            [weakSelf.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
        }
        
        
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}
- (void)getQNUToken{
    WEAK_SELF(weakSelf);
    [self.headImgKey removeAllObjects];
    [AFNHttpTools requestWithUrl:@"partner/getQiniuToken" andPostDict:nil successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        Model_Request * requestModel = [[Model_Request alloc]initWithString:jsonStr error:nil];
        if ([requestModel.state isEqualToString:dStateSuccess]) {
            NSString *  QNToken = requestModel.responseText;
            QNUploadManager * upManager = [QNUploadManagerTool sharedQNUploadManager];
            for (NSInteger i = 0; i < weakSelf.selectImgArr.count; i++) {
                UIImage * headImg = weakSelf.selectImgArr[i];
                    [upManager putData:UIImageJPEGRepresentation(headImg, 0.5) key:[@"IMG"stringByAppendingString:[TimeTool since1970Time]] token:QNToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                        NSLog(@"key = %@",key);
                        [weakSelf.headImgKey addObject:key];
                        if (weakSelf.headImgKey.count == weakSelf.selectImgArr.count) {
                            [weakSelf requestModifyHeadImg];
                        }
                        

                    } option:nil];
                
                
            }
            
            
            
            
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
    }];
}
///上传三张头像
- (void)requestModifyHeadImg
{
    WEAK_SELF(weakSelf);
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    NSString * value = nil;
    if (self.headImgKey.count == 1) {
        value = [NSString stringWithFormat:@"%@",self.headImgKey[0]];
    }else if(self.headImgKey.count == 2) {
        value = [NSString stringWithFormat:@"%@,%@",self.headImgKey[0],self.headImgKey[1]];
    }else if(self.headImgKey.count == 3){
        value = [NSString stringWithFormat:@"%@,%@,%@",self.headImgKey[0],self.headImgKey[1],self.headImgKey[2]];
    }
    
    
    [param setValue:value forKey:@"image"];
    NSLog(@"param = %@",param);

    [AFNHttpTools putDataWithUrl:@"permissions/user/userInfo" andParameters:param successed:^(NSDictionary *dict) {
        NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
        NSLog(@"jsonStr = %@",jsonStr);
        Model_Request * requestModel = [[Model_Request alloc]initWithString:jsonStr error:nil];
        if ([requestModel.state isEqualToString:dStateSuccess]) {
            [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
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
    self.currentCell.headIV.image  = currentImage;
    [self.headImgArr replaceObjectAtIndex:self.currentIndexPath.row withObject:currentImage];
    if ((self.currentIndexPath.row+1) > self.selectImgArr.count) {
        [self.selectImgArr addObject:currentImage];
    }else{
        [self.selectImgArr replaceObjectAtIndex:self.currentIndexPath.row withObject:currentImage];
    }
    [self.photoCV reloadData];
//    if (self.headImgArr.count > 0) {
//        UIImage * image1 = self.headImgArr[(self.currentBtn.tag - BtnTag)];
//        if ([image1 isKindOfClass:[NSNull class]]){
//            [self.headImgArr addObject:currentImage];
//        }else{
//            [self.headImgArr replaceObjectAtIndex:(self.currentBtn.tag - BtnTag) withObject:currentImage];
//        }
//    }else{
//        [self.headImgArr addObject:currentImage];
//    }
    
//    UIButton * deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.currentBtn.frame.size.width - 20), 0, 20, 20)];
//    [self.currentBtn addSubview:deleteBtn];
//    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
//    deleteBtn.backgroundColor = [UIColor redColor];
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
    NSLog(@"取消");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.flag == 2) {
        if ((self.headUrlArr.count + 1) >3 ) {
            return 3;
        }else{
            return (self.headUrlArr.count + 1);
        }
    }else{
        if ((self.selectImgArr.count + 1) >3 ) {
            return 3;
        }else{
            return (self.selectImgArr.count + 1);
        }
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_HeadPhoto * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell_Video" forIndexPath:indexPath];
    if (self.flag == 2) {
        if ((indexPath.row+1) <= self.headUrlArr.count) {
            NSString * imageUrl = self.headUrlArr[indexPath.row];
            NSLog(@"imageUrl = %@",imageUrl);
            UIImage * image = nil;
            if ([imageUrl isEqualToString:@"default"]) {
                cell.headIV.image = [UIImage imageNamed:@"个人信息-添加_03"];
                image = [UIImage imageNamed:@"个人信息-添加_03"];
            }else{
                [cell.headIV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                image = [UIImage imageWithData:data];
                [self.selectImgArr addObject:image];
                
            }
            NSLog(@"image = %@",image);
            if (image == nil) {
                image = [UIImage imageNamed:@"个人信息-添加_03"];
                [self.headImgArr replaceObjectAtIndex:indexPath.row withObject:image];
            }else{
                [self.headImgArr replaceObjectAtIndex:indexPath.row withObject:image];
            }
            
        }
    }else{
        cell.headIV.image = self.headImgArr[indexPath.row];
    }
   

    
   
    
    NSLog(@"%@",self.headImgArr);

    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.flag ++;
    Cell_HeadPhoto * cell = (Cell_HeadPhoto *)[collectionView cellForItemAtIndexPath:indexPath];
    self.currentCell = cell;
    self.currentIndexPath = indexPath;
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
    

}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH- 40)/3, RECTFIX_HEIGHT(100));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 1;
//    
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 1;
//}




@end
