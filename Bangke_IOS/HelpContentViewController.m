//
//  HelpContentViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "HelpContentViewController.h"
#import "UIColor+AddColor.h"
#import "Cell_HeadPhoto.h"
#import "UIImageView+WebCache.h"
#import "Model_Request.h"


@interface HelpContentViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, strong) UITextView * contentTV;
@property (nonatomic, assign) BOOL isTalk;
@property (nonatomic, strong) NSString * currentTime;
@property (nonatomic, strong) UILabel * startTimeLbl;
@property (nonatomic, strong) UILabel * overTimeLbl;
@property (nonatomic, strong) UIView * dateSelectView;
@property (nonatomic, strong) UIDatePicker * datePicker;
@property (nonatomic, strong) UIView * voiceView;
@property (nonatomic, strong) UISwitch * switchBtn;
@property (nonatomic, strong) UICollectionView * photoCV;//3张头像

@property (nonatomic, strong) NSMutableArray * headImgArr;//头像数组
@property (nonatomic, strong) UIImagePickerController * imagePicker;
@property (nonatomic, strong) Cell_HeadPhoto * currentCell;
@property (nonatomic, strong) NSMutableArray * headUrlArr;//头像url数组
@property (nonatomic, strong) NSIndexPath * currentIndexPath;
@property (nonatomic, strong) NSMutableArray * headImgKey;
@property (nonatomic, strong) NSMutableArray * selectImgArr;
@property (nonatomic, strong) NSDate * currentStartTime;
@property (nonatomic, strong) NSDate * currentOverTime;
@end

@implementation HelpContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headImgArr = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < 3; i++) {
        UIImage * defaultImage = [UIImage imageNamed:@"个人信息-添加_03"];
        [self.headImgArr addObject:defaultImage];
    }
    
    self.headUrlArr = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < 3; i++) {
        NSString * defaultImageUrl = @"default";
        [self.headUrlArr addObject:defaultImageUrl];
    }
    
    self.headImgKey = [NSMutableArray array];
    self.selectImgArr = [NSMutableArray array];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.title = @"输入内容";
    [self createUI];
//    self.titleArr = [NSArray arrayWithObjects:@"是否预约",@"预约时间",@"截止时间", nil];
    self.titleArr = [NSArray arrayWithObjects:@"截止时间", nil];
}

- (void)createUI
{
    WEAK_SELF(weakSelf);
    //输入内容
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, 30)];
    label.text = @" 输入内容";
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    //inputView
    UIView * inputView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), kMainScreenWidth, kMainScreenHeight * 0.2)];
//    inputView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:inputView];
    //talkBtn第一版无语音功能
//    UIButton * talkBtn = [[UIButton alloc]initWithFrame:CGRectMake(kMainScreenWidth-10 - inputView.frame.size.height+20, 10, inputView.frame.size.height-20, inputView.frame.size.height-20)];
//    talkBtn.layer.borderWidth = 1;
//    talkBtn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
////    talkBtn.backgroundColor = [UIColor blueColor];
//    [talkBtn setImage:[UIImage imageNamed:@"深色_mic_03"] forState:UIControlStateNormal];
//    [talkBtn addTarget:self action:@selector(isTalkAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.isTalk = NO;
//    [inputView addSubview:talkBtn];
    
    //textView
    
    
//    self.contentTV = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kMainScreenWidth-20 - talkBtn.frame.size.width, inputView.frame.size.height-20)];
    self.contentTV = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kMainScreenWidth-20, inputView.frame.size.height-20)];
    self.contentTV.backgroundColor = [UIColor whiteColor];
    self.contentTV.layer.borderWidth = 1;
    self.contentTV.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    self.contentTV.delegate = self;
    if (self.currentModel.helpContent.length >0) {
        self.contentTV.text = self.currentModel.helpContent;
    }
    [inputView addSubview:self.contentTV];
    
    
    
    //tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(inputView.frame), kMainScreenWidth, RECTFIX_HEIGHT(40))];
    //[self.tableView showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //照片view
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.photoCV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame)+ 10, SCREEN_WIDTH, RECTFIX_HEIGHT(120)) collectionViewLayout:flowLayout];
    self.photoCV.delegate = self;
    self.photoCV.dataSource = self;
    [self.photoCV registerClass:[Cell_HeadPhoto class] forCellWithReuseIdentifier:@"Cell_Video"];
    [self.view addSubview:self.photoCV];
    self.photoCV.backgroundColor = [UIColor blackColor];
    
    //提交按钮View
    UIView * submitView = [UIView new];
    [self.view addSubview:submitView];
//    [submitView showPlaceHolderWithLineColor:[UIColor blackColor]];
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(0);
        make.height.equalTo(@50);
    }];
    //提交按钮
    UIButton * submitBtn = [UIButton new];
    [submitView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(submitView.center);
        make.size.mas_equalTo(CGSizeMake(kMainScreenWidth * 0.4, 40));
    }];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.backgroundColor =[UIColor orangeColor];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 20;
    

    
}
#pragma mark - Action

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)submitAction
{
    if (self.selectImgArr.count == 0) {
        [self callBackAction];
    }else{
        [self getQNUToken];
    }
    
    
}
- (void)isTalkAction:(UIButton *)btn
{
    WEAK_SELF(weakSelf);
    self.isTalk = !self.isTalk;
    if (self.isTalk == YES) {
        [btn setImage:[UIImage imageNamed:@"求帮~拉-43-输入_03"] forState:UIControlStateNormal];
        self.voiceView = [UIView new];
        [self.view addSubview:self.voiceView];
        [self.voiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
            make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
            make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(0);
            make.height.equalTo(@(kMainScreenHeight * 0.4));
        }];
        self.voiceView.backgroundColor = [UIColor colorWithHexString:@"ebecee"];
//        [self.voiceView showPlaceHolderWithLineColor:[UIColor blackColor]];
        UIButton * closeBtn = [UIButton new];
        [self.voiceView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.voiceView.mas_left).with.offset(0);
            make.right.mas_equalTo(weakSelf.voiceView.mas_right).with.offset(0);
            make.top.mas_equalTo(weakSelf.voiceView.mas_top).with.offset(0);
            make.height.equalTo(@30);
        }];
        closeBtn.backgroundColor = [UIColor grayColor];
        [closeBtn addTarget:self action:@selector(closeVoiceViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * inputBtn = [UIButton new];
        [self.voiceView addSubview:inputBtn];
        [inputBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.voiceView.mas_centerX);
            make.centerY.mas_equalTo(weakSelf.voiceView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake((kMainScreenHeight * 0.4)*0.3, (kMainScreenHeight * 0.4)*0.3));
        }];
        [inputBtn setImage:[UIImage imageNamed:@"语音按钮_03"] forState:UIControlStateNormal];
        
        UILabel * timeLabel = [UILabel new];
        [self.voiceView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.voiceView.mas_centerX);
            make.bottom.mas_equalTo(inputBtn.mas_top).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(60, 10));
        }];
        timeLabel.text = @"0：00";
        timeLabel.textAlignment = NSTextAlignmentCenter;
//        timeLabel.backgroundColor =[UIColor yellowColor];
        
        UIImageView * iv1 = [UIImageView new];
        [self.voiceView addSubview:iv1];
        [iv1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(timeLabel.mas_left).with.offset(-10);
            make.bottom.mas_equalTo(inputBtn.mas_top).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(40, 10));
        }];
        iv1.image =[UIImage imageNamed:@"求帮~拉-语音-左点_15"];
        
        UIImageView * iv2 = [UIImageView new];
        [self.voiceView addSubview:iv2];
        [iv2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(timeLabel.mas_right).with.offset(10);
            make.bottom.mas_equalTo(inputBtn.mas_top).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(40, 10));
        }];
        iv2.image =[UIImage imageNamed:@"求帮~拉-语音-右点_15"];
        
        UIView * btnView = [UIView new];
        [self.voiceView addSubview:btnView];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.voiceView.mas_left).with.offset(0);
            make.right.mas_equalTo(weakSelf.voiceView.mas_right).with.offset(0);
            make.bottom.mas_equalTo(weakSelf.voiceView.mas_bottom).with.offset(0);
            make.height.equalTo(@(kMainScreenHeight * 0.075));
        }];
        btnView.backgroundColor = [UIColor whiteColor];
        //重录btn
        UIButton * resetBtn = [UIButton new];
        [btnView addSubview:resetBtn];
        [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btnView.mas_left).with.offset(0);
            make.bottom.mas_equalTo(btnView.mas_bottom).with.offset(0);
            make.top.mas_equalTo(btnView.mas_top).with.offset(0);
            make.width.equalTo(@(kMainScreenWidth/2));
        }];
        [resetBtn setTitle:@"重录" forState:UIControlStateNormal];
        [resetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //完成btn
        UIButton * okBtn = [UIButton new];
        [btnView addSubview:okBtn];
        [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(btnView.mas_right).with.offset(0);
            make.bottom.mas_equalTo(btnView.mas_bottom).with.offset(0);
            make.top.mas_equalTo(btnView.mas_top).with.offset(0);
            make.width.equalTo(@(kMainScreenWidth/2));
        }];
        [okBtn setTitle:@"完成" forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(voiceOkAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }else{
        [btn setImage:[UIImage imageNamed:@"深色_mic_03"] forState:UIControlStateNormal];
        [self.voiceView removeFromSuperview];
    }
}
///删除已选择图片
- (void)delImage:(UIButton *)btn
{
    NSLog(@"删除图片");
    [self.selectImgArr removeObjectAtIndex:btn.tag];
    [self.photoCV reloadData];
    
}

///是否预约
- (void)switchChange:(UISwitch *)switchBtn
{
    if (switchBtn.on == YES) {
        
    }else{
        self.startTimeLbl.text = nil;
        self.overTimeLbl.text = nil;
    }
    NSLog(@"开关切换");
}

- (void)dateChanged:(UIDatePicker *)picker
{
//    NSLog(@"测试");
//    NSDate * date = picker.date;
//    NSLog(@"date = %@",date);
//    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
//    self.currentTime = [formatter stringFromDate:date];
//    NSLog(@"self.currentTime = %@",self.currentTime);
    
}

- (void)submitTimeAction:(UIButton *)btn
{
    NSLog(@"测试");
    NSDate * date = [self.datePicker date];
    NSLog(@"date = %@",date);
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.currentTime = [formatter stringFromDate:date];
    NSLog(@"self.currentTime = %@",self.currentTime);
    
    NSLog(@"确定时间");
    switch (btn.tag) {
        case 50:
            self.startTimeLbl.text = self.currentTime;
            self.currentStartTime = self.datePicker.date;
            NSLog(@"self.currentStartTime = %@",self.currentStartTime);
            break;
        case 51:
            self.overTimeLbl.text = self.currentTime;
            self.currentOverTime = self.datePicker.date;
            NSLog(@"self.currentOverTime = %@",self.currentOverTime);
            break;
            
        default:
            break;
    }

    [self.dateSelectView removeFromSuperview];
}

- (void)closeVoiceViewAction:(UIButton *)btn
{
    [btn.superview removeFromSuperview];
}

- (void)voiceOkAction:(UIButton *)btn
{
    [self.voiceView removeFromSuperview];
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
                        [weakSelf callBackAction];
                    }
                    
                    
                } option:nil];
                
                
            }
            
            
            
            
        }
    } failed:^(NSError *err) {
        NSLog(@"err = %@",[err localizedDescription]);
    }];
}

- (void)callBackAction
{
    NSLog(@"提交");
    if (self.contentTV.text.length > 0) {
        Model_ContentCallBack * model = [[Model_ContentCallBack alloc]init];
        model.helpContent = self.contentTV.text;
        if (self.headImgKey.count == 1) {
            model.images = [NSString stringWithFormat:@"%@",self.headImgKey[0]];
        }else if (self.headImgKey.count == 2) {
            model.images = [NSString stringWithFormat:@"%@,%@",self.headImgKey[0],self.headImgKey[1]];
        }else if(self.headImgKey.count == 3){
            model.images = [NSString stringWithFormat:@"%@,%@,%@",self.headImgKey[0],self.headImgKey[1],self.headImgKey[2]];
        }else{
            model.images = @"";
        }
        
//        if (self.switchBtn.on == YES) {
//            model.isOrder = YES;
//            if(self.startTimeLbl.text.length > 0 && self.overTimeLbl.text.length > 0){
//                if ([self.currentStartTime isEqualToDate:[self.currentStartTime earlierDate:self.currentOverTime]]) {
//                    model.startTime = self.startTimeLbl.text;
//                    model.overTime = self.overTimeLbl.text;
//                    NSLog(@"model = %@",model);
//                    self.decideContent(model);
//                    [self.navigationController popViewControllerAnimated:YES];
//                }else{
//                    [self.view makeToast:@"请输入正确的预约时间和截止时间" duration:ToastDuration position:CSToastPositionCenter];
//                }
//                
//            }else{
//                [self.view makeToast:@"请选择时间" duration:ToastDuration position:CSToastPositionCenter];
//            }
//            
//        }else{
            model.isOrder = NO;
        if ([self.overTimeLbl.text  isEqualToString:@"截至时间默认7个小时"]) {
            //不做处理
        }else{
            model.overTime = self.overTimeLbl.text;
        }
        
            self.decideContent(model);
            [self.navigationController popViewControllerAnimated:YES];
//        }
        
    }else{
        [self.view makeToast:@"请输入内容" duration:ToastDuration position:CSToastPositionCenter];
    }

}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //消息通知开关
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.overTimeLbl = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth *0.4, 0, kMainScreenWidth * 0.6, cell.contentView.frame.size.height)];
        //        [self.overTimeLbl showPlaceHolderWithLineColor:[UIColor whiteColor]];
        //        self.overTimeLbl.backgroundColor = [UIColor lightGrayColor];
        self.overTimeLbl.text = @"截至时间默认7个小时";
        [cell.contentView addSubview:self.overTimeLbl];
//        self.switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width - 60, 10, 50, 50)];
//        [cell.contentView addSubview:self.switchBtn];
//        //        [switchBtn showPlaceHolderWithLineColor:[UIColor blackColor]];
//        self.switchBtn.on = YES;
//        self.switchBtn.onTintColor = [UIColor orangeColor];
//        [self.switchBtn addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
//    if (indexPath.row == 1) {
//        self.startTimeLbl = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth *0.4, 0, kMainScreenWidth * 0.6, cell.contentView.frame.size.height)];
////        [self.startTimeLbl showPlaceHolderWithLineColor:[UIColor whiteColor]];
////        self.startTimeLbl.backgroundColor = [UIColor lightGrayColor];
//        [cell.contentView addSubview:self.startTimeLbl];
//    }
    if (indexPath.row == 2) {
        self.overTimeLbl = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth *0.4, 0, kMainScreenWidth * 0.6, cell.contentView.frame.size.height)];
//        [self.overTimeLbl showPlaceHolderWithLineColor:[UIColor whiteColor]];
//        self.overTimeLbl.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:self.overTimeLbl];
    }

    
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF(weakSelf);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (self.switchBtn.on == YES && ![self.contentTV isFirstResponder]) {
//        if (indexPath.row == 1) {
    
//            self.dateSelectView = [UIView new];
//            [self.view addSubview:self.dateSelectView];
//            [self.dateSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
//                make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
//                make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(0);
//                make.height.equalTo(@(260));
//                
//            }];
//            self.dateSelectView.backgroundColor = [UIColor whiteColor];
//            
//            self.datePicker = [[UIDatePicker alloc]init];
//            [self.dateSelectView addSubview:self.datePicker];
//            //        [datePicker showPlaceHolderWithLineColor:[UIColor blackColor]];
//            [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
//            UIButton * submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.datePicker.frame), kMainScreenWidth, 44)];
//            submitBtn.tag = 50;
//            [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
//            submitBtn.backgroundColor =[UIColor blueColor];
//            [self.dateSelectView addSubview:submitBtn];
//            [submitBtn addTarget:self action:@selector(submitTimeAction:) forControlEvents:UIControlEventTouchUpInside];
//        }
        
        
        if (indexPath.row == 0) {
            
            self.dateSelectView = [UIView new];
            [self.view addSubview:self.dateSelectView];
            [self.dateSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
                make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
                make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(0);
                make.height.equalTo(@(260));
                
            }];
            self.dateSelectView.backgroundColor = [UIColor whiteColor];
            
            self.datePicker = [[UIDatePicker alloc]init];
            [self.dateSelectView addSubview:self.datePicker];
            //        [datePicker showPlaceHolderWithLineColor:[UIColor blackColor]];
            [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            UIButton * submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.datePicker.frame), kMainScreenWidth, 44)];
            submitBtn.tag = 51;
            [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
            submitBtn.backgroundColor =[UIColor colorWithHexString:@"FA9924"];
            [self.dateSelectView addSubview:submitBtn];
            [submitBtn addTarget:self action:@selector(submitTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        }
//    }


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

#pragma mark - block
-(void)returnContentModel:(CallBackContentModel)model
{
    self.decideContent = model;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ((self.selectImgArr.count + 1) >3 ) {
        return 3;
    }else{
        return (self.selectImgArr.count + 1);
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_HeadPhoto * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell_Video" forIndexPath:indexPath];
    cell.headIV.image = self.headImgArr[indexPath.row];
    if (indexPath.row != self.selectImgArr.count) {
        UIButton * deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, RECTFIX_WIDTH(20), RECTFIX_HEIGHT(20))];
        [deleteBtn addTarget:self action:@selector(delImage:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tag = indexPath.row;
        deleteBtn.backgroundColor = [UIColor redColor];
        [cell.headIV addSubview:deleteBtn];
    }
    
//    NSString * imageUrl = self.headUrlArr[indexPath.row];
//    NSLog(@"imageUrl = %@",imageUrl);
//    UIImage * image = nil;
//    if ([imageUrl isEqualToString:@"default"]) {
//        cell.headIV.image = [UIImage imageNamed:@"个人信息-添加_03"];
//        image = [UIImage imageNamed:@"个人信息-添加_03"];
//    }else{
//        [cell.headIV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//        image = [UIImage imageWithData:data];
//        
//    }
//    NSLog(@"image = %@",image);
//    if (image == nil) {
//        image = [UIImage imageNamed:@"个人信息-添加_03"];
//        [self.headImgArr replaceObjectAtIndex:indexPath.row withObject:image];
//    }else{
//        [self.headImgArr replaceObjectAtIndex:indexPath.row withObject:image];
//    }
    
    
    NSLog(@"%@",self.headImgArr);
    
    
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_HeadPhoto * cell = (Cell_HeadPhoto *)[collectionView cellForItemAtIndexPath:indexPath];
    self.currentCell = cell;
    self.currentIndexPath = indexPath;
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
    
    
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

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH- 40)/3, RECTFIX_HEIGHT(100));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}



@end
