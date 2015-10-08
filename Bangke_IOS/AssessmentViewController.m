//
//  AssessmentViewController.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "AssessmentViewController.h"
#import "Model_Request.h"
@interface AssessmentViewController () <UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton * goodBtn;
@property (nonatomic, strong) UIButton * mediumBtn;
@property (nonatomic, strong) UIButton * badBtn;
@property (nonatomic, strong) NSString * currentEvaState;//当前评价状态1-推荐2-好评3-一般
@property (nonatomic, strong) UITextField * priceTF;//打赏金额
@property (nonatomic, strong) UITextView * contentTV;//评论内容
@property (nonatomic, assign) BOOL isGood;
@property (nonatomic, assign) BOOL isMedium;
@property (nonatomic, assign) BOOL isBad;

@end

@implementation AssessmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(submitAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.title = @"评价";
    [rightItem setTintColor:[UIColor orangeColor]];
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor  = [UIColor whiteColor];
//订单view
    UIImageView * orderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight * 0.2)];
//    orderView.backgroundColor = [UIColor redColor];
    [self.view addSubview:orderView];
    
    //订单图片
//    UIImageView * orderIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 110, orderView.frame.size.height- 40)];
////    orderIV.backgroundColor = [UIColor yellowColor];
//    
//    if (self.model.images.count > 0) {
//        [orderIV sd_setImageWithURL:[NSURL URLWithString:self.model.images[0]]];
//    }else{
//        orderIV.image = [UIImage imageNamed:@"img_03"];
//    }
    
    //设置ordermodel图片(暂时取消)
//    [orderView addSubview:orderIV];
    
    //order title
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = self.model.descrip;
    [titleLabel setNumberOfLines:0];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont * titleLabelFnt = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    titleLabel.font = titleLabelFnt;
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    CGRect titleLabelRect = [titleLabel.text boundingRectWithSize:CGSizeMake(orderView.frame.size.width  - RECTFIX_WIDTH(60), 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:titleLabelFnt,NSFontAttributeName,nil] context:nil];
    titleLabel.frame = CGRectMake(RECTFIX_WIDTH(15), RECTFIX_HEIGHT(20), titleLabelRect.size.width , titleLabelRect.size.height);
    [orderView addSubview:titleLabel];
    
    
    //抢单图标
    UIImageView * iv1 = [UIImageView new];
    [orderView addSubview:iv1];
    [iv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderView.mas_left).with.offset(RECTFIX_WIDTH(15));
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(RECTFIX_HEIGHT(10));
        make.size.mas_equalTo(CGSizeMake(RECTFIX_WIDTH(20), RECTFIX_HEIGHT(20)));
    }];
    iv1.backgroundColor = [UIColor whiteColor];
    if (self.model.ptype.integerValue == 1) {
        iv1.image =[UIImage imageNamed:@"icon_J"];
    }else if (self.model.ptype.integerValue == 2){
        iv1.image =[UIImage imageNamed:@"邀"];
    }else{
        iv1.image =[UIImage imageNamed:@"抢"];
    }

    
    
    //order price
    UILabel * priceLabel = [UILabel new];
    [orderView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iv1.mas_right).with.offset(RECTFIX_WIDTH(10));
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(RECTFIX_HEIGHT(10));
        make.right.mas_equalTo(orderView.mas_right).with.offset(RECTFIX_WIDTH(15));
        make.height.equalTo(@(RECTFIX_HEIGHT(20)));
        
    }];
    NSLog(@"model = %@",self.model);
    if (self.model.price && ![self.model.price isEqualToString:@""]) {
        priceLabel.text = [NSString stringWithFormat:@"%@元",self.model.price];
    }else{
        priceLabel.text = [NSString stringWithFormat:@"%@元",self.model.cost_amount];
    }
    
    priceLabel.textColor = [UIColor colorWithHexString:@"FA9924"];
    

    
    
    //order Content
//    UILabel * contentLabel = [UILabel new];
//    [orderView addSubview:contentLabel];
//    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(orderIV.mas_right).with.offset(10);
//        make.top.mas_equalTo(priceLabel.mas_bottom).with.offset(10);
//        make.right.mas_equalTo(iv2.mas_left).with.offset(10);
//        make.height.equalTo(@20);
//    }];
//    contentLabel.text = self.model.descrip;
//    contentLabel.textColor = [UIColor lightGrayColor];
    
    
    
    
    
    
    
    
    
 
    
    //评价内容
    UIButton * photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-85, CGRectGetMaxY(self.goodBtn.frame)+10, 75, 75)];
    //[self.view addSubview:photoBtn];
    //photoBtn.backgroundColor = [UIColor yellowColor];
    [photoBtn setImage:[UIImage imageNamed:@"评价1-相机_03"] forState:UIControlStateNormal];
    //self.contentTV = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.goodBtn.frame)+10, kMainScreenWidth- 30 - photoBtn.frame.size.width, 75)];
    self.contentTV = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(orderView.frame), kMainScreenWidth- 20, 75)];
    self.contentTV.delegate = self;
    self.contentTV.backgroundColor = [UIColor whiteColor];
    self.contentTV.layer.borderWidth = 1;
    self.contentTV.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.contentTV.delegate = self;
    [self.view addSubview:self.contentTV];
    //打赏金额
    self.priceTF = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.contentTV.frame)+10, kMainScreenWidth-20, 40)];
//    priceTF.backgroundColor = [UIColor greenColor];
    //暂时没有打赏金额
//    [self.view addSubview:self.priceTF];
    self.priceTF.placeholder = @"请输入打赏金额";
    self.priceTF.layer.borderWidth = 1;
    self.priceTF.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.priceTF.delegate = self;
    //leftView
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, self.priceTF.frame.size.height)];
//    leftView.backgroundColor = [UIColor redColor];
    UILabel * label1 = [[UILabel alloc]initWithFrame:leftView.bounds];
//    label1.backgroundColor = [UIColor blueColor];
    label1.text = @"打赏";
    label1.textAlignment = NSTextAlignmentRight;
    [leftView addSubview:label1];
    self.priceTF.leftView = leftView;
    self.priceTF.leftViewMode = UITextFieldViewModeAlways;
    
    //rightView
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.priceTF.frame.size.height)];
//    leftView.backgroundColor = [UIColor redColor];
    UILabel * label2 = [[UILabel alloc]initWithFrame:rightView.bounds];
//    label2.backgroundColor = [UIColor blueColor];
    label2.text = @"元";
    label2.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:label2];
    self.priceTF.rightView = rightView;
    self.priceTF.rightViewMode = UITextFieldViewModeAlways;
    
    //好评btn
    self.goodBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentTV.frame), kMainScreenWidth/3, 80)];
    [self.view addSubview:self.goodBtn];
    self.isGood = YES;
    self.currentEvaState = @"1";
    //    goodBtn.backgroundColor = [UIColor lightGrayColor];
    [self.goodBtn setImage:[UIImage imageNamed:@"评价1-好_03"] forState:UIControlStateNormal];
    
    [self.goodBtn addTarget:self action:@selector(goodBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mediumBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.goodBtn.frame), CGRectGetMaxY(self.contentTV.frame), kMainScreenWidth/3, 80)];
    [self.view addSubview:self.mediumBtn];
    self.isMedium = NO;
    //    mediumBtn.backgroundColor = [UIColor lightGrayColor];
    [self.mediumBtn setImage:[UIImage imageNamed:@"评价1-中-_03"] forState:UIControlStateNormal];
    [self.mediumBtn addTarget:self action:@selector(mediumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.badBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.mediumBtn.frame), CGRectGetMaxY(self.contentTV.frame), kMainScreenWidth/3, 80)];
    [self.view addSubview:self.badBtn];
    self.isBad = NO;
    //    badBtn.backgroundColor = [UIColor lightGrayColor];
    [self.badBtn setImage:[UIImage imageNamed:@"评价1-差_03"] forState:UIControlStateNormal];
    [self.badBtn addTarget:self action:@selector(badBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma mark - Action
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)submitAction
{
    if ([UserInfoTool getToken] && ![[UserInfoTool getToken] isEqualToString:@""]) {
        [self requestAssessWithToken:[UserInfoTool getToken]];
    }
//    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goodBtnAction:(UIButton *)btn
{
    self.isGood = !self.isGood;
    if (self.isGood == YES) {
        [btn setImage:[UIImage imageNamed:@"评价1-好_03"] forState:UIControlStateNormal];
        [self.mediumBtn setImage:[UIImage imageNamed:@"评价1-中-_03"] forState:UIControlStateNormal];
        [self.badBtn setImage:[UIImage imageNamed:@"评价1-差_03"] forState:UIControlStateNormal];
        self.isMedium = NO;
        self.isBad = NO;
        self.currentEvaState = @"1";
    }else{
        [btn setImage:[UIImage imageNamed:@"评价1-好-_03"] forState:UIControlStateNormal];
    }
    
}
-(void)mediumBtnAction:(UIButton *)btn
{
    self.isMedium = !self.isMedium;
    if (self.isMedium == YES) {
        [btn setImage:[UIImage imageNamed:@"评价1-中_03"] forState:UIControlStateNormal];
        [self.goodBtn setImage:[UIImage imageNamed:@"评价1-好-_03"] forState:UIControlStateNormal];
        [self.badBtn setImage:[UIImage imageNamed:@"评价1-差_03"] forState:UIControlStateNormal];
        self.isGood = NO;
        self.isBad = NO;
        self.currentEvaState = @"2";
    }else{
        [btn setImage:[UIImage imageNamed:@"评价1-中-_03"] forState:UIControlStateNormal];
    }
}

-(void)badBtnAction:(UIButton *)btn
{
    self.isBad = !self.isBad;
    if (self.isBad == YES) {
        [btn setImage:[UIImage imageNamed:@"评价1-差-_03"] forState:UIControlStateNormal];
        [self.goodBtn setImage:[UIImage imageNamed:@"评价1-好-_03"] forState:UIControlStateNormal];
        [self.mediumBtn setImage:[UIImage imageNamed:@"评价1-中-_03"] forState:UIControlStateNormal];
        self.isGood = NO;
        self.isMedium = NO;
        self.currentEvaState = @"3";
    }else{
        [btn setImage:[UIImage imageNamed:@"评价1-差_03"] forState:UIControlStateNormal];
    }
}



#pragma mark - Request
- (void)requestAssessWithToken:(NSString *)token
{
    WEAK_SELF(weakSelf);
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    [param setValue:token forKey:@"access_token"];
    [param setValue:@"1" forKey:@"complaint"];
    if (self.contentTV.text && ![self.contentTV.text isEqualToString:@""]) {
        [param setValue:self.currentEvaState forKey:@"evaluate_state"];
        [param setValue:@"0" forKey:@"additional_cost"];
        [param setValue:self.model.id forKey:@"process_recode_id"];
        [param setValue:self.contentTV.text forKey:@"evaluate"];
        //发送图片功能暂不实现
        //[param setValue:@"1" forKey:@"image"];
        NSLog(@"param = %@",param);
        
        NSString * url = @"";
        if (self.reviewType == ReviewTypeSendHelp) {
            url = @"permissions/order/pleaseHelpEvaluation";
        }else{
            url = @"permissions/order/helpEvaluation";
        }
        
        NSLog(@"url = %@",url);
        [AFNHttpTools requestWithUrl:url andPostDict:param successed:^(NSDictionary *dict) {
            NSString * jsonStr = [AFNHttpTools jsonStringWithDict:dict];
            NSLog(@"jsonStr = %@",jsonStr);
            Model_Request * model = [[Model_Request alloc]initWithString:jsonStr error:nil];
            if ([model.state isEqualToString:dStateSuccess]) {
                [weakSelf.view makeToast:model.message duration:ToastDuration position:CSToastPositionCenter];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf.view makeToast:model.message duration:ToastDuration position:CSToastPositionCenter];
            }
            
        } failed:^(NSError *err) {
            NSLog(@"err = %@",[err localizedDescription]);
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];

    }else{
        [self.view makeToast:@"请输入全部信息" duration:ToastDuration position:CSToastPositionCenter];
    }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.contentTV resignFirstResponder];
    [self.priceTF resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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


@end
