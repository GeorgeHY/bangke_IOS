//
//  OrderDetail_AViewController.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/9/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "OrderDetail_AViewController.h"
#import "AssessmentViewController.h"
#import "InviteOrCompeteListVC.h"
#import "Model_SearchReviewOrder.h"
#import "RegTools.h"

#define BTNTAG 305
#define ALERTTAG 405

typedef NS_ENUM(NSInteger, OrderPtype) {
    OrderPtypeCompete = 1,//竞单
    OrderPtypeInvite,//邀单
    OrderPtypeGrab//抢单
};

@interface OrderDetail_AViewController() <UIAlertViewDelegate>

@property (nonatomic, strong) UIImageView * headIV;//头像IV
@property (nonatomic, strong) UILabel * typeLabel;//订单模式Label
@property (nonatomic, strong) UIImageView * typeIV;//订单模式IV
@property (nonatomic, strong) UILabel * childLabel;//子标签label
@property (nonatomic, strong) UILabel * parentLabel;//父标签label
@property (nonatomic, strong) UIImageView * arrowIV;//父标签与子标签之间的箭头
@property (nonatomic, strong) UIView * headView;
@property (nonatomic, strong) Model_OrderDesc * orderModel;

@end

@implementation OrderDetail_AViewController


-(void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订单详情";
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头17px_03"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [leftItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.hidesBackButton = YES;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self requestOrderDetailWithOrderID:self.curID];
    
    
    
    
    
}

-(void) createHeadView
{
    WEAK_SELF(weakSelf);
    
    UILabel * headline = [[UILabel alloc]initWithFrame:CGRectMake(0, kNaviMaxY, SCREEN_WIDTH, RECTFIX_HEIGHT(1))];
    headline.backgroundColor = [UIColor colorWithHexString:@"68602"];
    [self.view addSubview:headline];
    //头view
    self.headView = [[UIView alloc]init];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    //头像
    self.headIV = [[UIImageView alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(15), RECTFIX_HEIGHT(15), RECTFIX_WIDTH(60), RECTFIX_WIDTH(60))];
    //[self.headIV showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.headIV.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:self.headIV];
    self.headIV.layer.masksToBounds = YES;
    self.headIV.layer.cornerRadius = RECTFIX_WIDTH(30);
    if (self.curModel.plaseHelpUser.head_portrait && ![self.curModel.plaseHelpUser.head_portrait isEqualToString:@""]) {
        [self.headIV sd_setImageWithURL:[NSURL URLWithString:self.curModel.plaseHelpUser.head_portrait]];
    }
    
    //订单模式IV
    self.typeIV = [UIImageView new];
    [self.view addSubview:self.typeIV];
    [self.typeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.headIV.mas_centerX);
        make.top.mas_equalTo(weakSelf.view.mas_top).with.offset(RECTFIX_HEIGHT(63+64));
        make.size.mas_equalTo(CGSizeMake(RECTFIX_WIDTH(70), RECTFIX_HEIGHT(20)));
    }];
    
    
    
    //订单模式label
    self.typeLabel = [UILabel new];
    [self.typeIV addSubview:self.typeLabel];
    //[self.typeLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.typeIV.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.typeIV.mas_centerY).with.offset(RECTFIX_HEIGHT(1));
        make.size.mas_equalTo(CGSizeMake(RECTFIX_WIDTH(60), RECTFIX_HEIGHT(19)));
    }];
    
    self.typeLabel.font = [UIFont systemFontOfSize:12];
    self.typeLabel.textColor = [UIColor whiteColor];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.orderModel.ptype.integerValue == OrderPtypeCompete) {
        self.typeIV.image = [UIImage imageNamed:@"to_help_home_complete"];
        self.typeLabel.text = @"竞单模式";
    }else if (self.orderModel.ptype.integerValue == OrderPtypeInvite){
        self.typeIV.image = [UIImage imageNamed:@"to_help_home_invite"];
        self.typeLabel.text = @"邀单模式";
    }else{
        self.typeIV.image = [UIImage imageNamed:@"to_help_home_qiang2"];
        self.typeLabel.text = @"抢单模式";
    }
    
    //子标签label
    self.childLabel = [[UILabel alloc]init];
    self.childLabel.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    //[self.childLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    Model_LabelInfo * labelModel = [self.curModel.labelInfos firstObject];
    self.childLabel.text = labelModel.subsequent_label_name;
    CGSize childsize = [self.childLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:12.0f],NSFontAttributeName, nil]];
    self.childLabel.frame = CGRectMake(SCREEN_WIDTH -RECTFIX_WIDTH(30)- childsize.width,RECTFIX_HEIGHT(20), childsize.width+RECTFIX_WIDTH(10),RECTFIX_HEIGHT(15));
    self.childLabel.textAlignment = NSTextAlignmentCenter;
    self.childLabel.font =[UIFont systemFontOfSize:12];
    self.childLabel.textColor = [UIColor whiteColor];
    [self.headView addSubview:self.childLabel];
    
    //中间箭头图片
    self.arrowIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.childLabel.frame)-RECTFIX_WIDTH(7), RECTFIX_HEIGHT(20), RECTFIX_WIDTH(7), RECTFIX_HEIGHT(15))];
    [self.headView addSubview:self.arrowIV];
    self.arrowIV.image = [UIImage imageNamed:@"im-gray-biaoqian2x-"];
    
    //父标签label
    self.parentLabel = [[UILabel alloc]init];
    self.parentLabel.backgroundColor = [UIColor colorWithHexString:@"FA9924"];
    //[self.parentLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.parentLabel.text = labelModel.prime_label_name;
    CGSize parentsize = [self.parentLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:12.0f],NSFontAttributeName, nil]];
    self.parentLabel.frame = CGRectMake(CGRectGetMinX(self.arrowIV.frame)-parentsize.width-RECTFIX_WIDTH(10),RECTFIX_HEIGHT(20), parentsize.width+RECTFIX_WIDTH(10),RECTFIX_HEIGHT(15));
    self.parentLabel.textAlignment = NSTextAlignmentCenter;
    self.parentLabel.font =[UIFont systemFontOfSize:12];
    self.parentLabel.textColor = [UIColor whiteColor];
    [self.headView addSubview:self.parentLabel];
    
    //求帮者昵称
    UILabel * pleaseHelpName = [[UILabel alloc]init];
    UIFont * pleaseHelpNameFnt = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
    [pleaseHelpName setNumberOfLines:0];
    pleaseHelpName.lineBreakMode = NSLineBreakByWordWrapping;
    pleaseHelpName.font = pleaseHelpNameFnt;
    pleaseHelpName.text = self.curModel.plaseHelpUser.nickname;
    
    CGRect pleaseUserRect = [pleaseHelpName.text boundingRectWithSize:CGSizeMake(CGRectGetMinX(self.parentLabel.frame)- CGRectGetMaxX(self.headIV.frame) - RECTFIX_WIDTH(26), 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:pleaseHelpNameFnt,NSFontAttributeName,nil] context:nil];
    pleaseHelpName.frame = CGRectMake(CGRectGetMaxX(self.headIV.frame)+RECTFIX_WIDTH(21), RECTFIX_HEIGHT(26), pleaseUserRect.size.width, pleaseUserRect.size.height);
    //[pleaseHelpName showPlaceHolderWithLineColor:[UIColor blackColor]];
    
    [self.headView addSubview:pleaseHelpName];
    
    //求帮内容
    
    UITextView * contentTV = [[UITextView alloc]init];
    contentTV.font =[UIFont systemFontOfSize:16];
    contentTV.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    contentTV.editable = NO;
    contentTV.textColor = [UIColor colorWithHexString:@"646464"];
    
    contentTV.text = self.orderModel.descrip;


    contentTV.textAlignment = NSTextAlignmentLeft;
    [self.headView addSubview:contentTV];
    [contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headIV.mas_right).with.offset(RECTFIX_WIDTH(21));
        make.right.mas_equalTo(weakSelf.headView.mas_right).with.offset(-RECTFIX_WIDTH(15));
        make.top.mas_equalTo(pleaseHelpName.mas_bottom).with.offset(RECTFIX_HEIGHT(29));
        make.height.equalTo(@(RECTFIX_HEIGHT(40)));
        
    }];
    
    //灰色分割线
    UILabel * sepLine = [[UILabel alloc]init];
    [self.headView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headIV.mas_right).with.offset(RECTFIX_WIDTH(18));
        make.right.mas_equalTo(weakSelf.headView.mas_right).with.offset(0);
        make.top.mas_equalTo(contentTV.mas_bottom).with.offset(RECTFIX_HEIGHT(10));
        make.height.equalTo(@(0.5));
    }];
    sepLine.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    
    //价格
    UILabel * priceLabel = [[UILabel alloc]init];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",self.orderModel.cost_amount];
    CGSize priceSize = [priceLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:18.0f],NSFontAttributeName, nil]];
    priceLabel.frame = CGRectMake(CGRectGetMaxX(self.headIV.frame)+RECTFIX_WIDTH(21), CGRectGetMaxY(pleaseHelpName.frame) + RECTFIX_HEIGHT(13 + 29 + 15) + RECTFIX_HEIGHT(32) + 1, priceSize.width+RECTFIX_WIDTH(10), priceSize.height);
    //[priceLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    priceLabel.font = [UIFont systemFontOfSize:18];
    priceLabel.textColor = [UIColor colorWithHexString:@"FA9924"];
    [self.headView addSubview:priceLabel];
    
    //支付方式
    UILabel * payTypeLabel = [[UILabel alloc]init];
    //有了其他方式之后根据bond字段判断
    payTypeLabel.text = @"在线支付";
    CGSize payTypeSize = [payTypeLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:12.0f],NSFontAttributeName, nil]];
    payTypeLabel.frame = CGRectMake(CGRectGetMaxX(priceLabel.frame)+RECTFIX_WIDTH(5), CGRectGetMaxY(pleaseHelpName.frame) + RECTFIX_HEIGHT(17 + 29 + 15) + RECTFIX_HEIGHT(32) + 1, payTypeSize.width, payTypeSize.height);
    //[payTypeLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    payTypeLabel.font = [UIFont systemFontOfSize:12];
    payTypeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.headView addSubview:payTypeLabel];
    
    self.headView.frame = CGRectMake(0, CGRectGetMaxY(headline.frame), SCREEN_WIDTH, CGRectGetMaxY(payTypeLabel.frame) + RECTFIX_HEIGHT(15));
    
    //最后分割线
    UILabel * bottomLine = [UILabel new];
    [self.headView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headView.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.headView.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.headView.mas_bottom).with.offset(0);
        make.height.equalTo(@(0.5));
    }];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    

}

- (void)createContentView
{
    
    WEAK_SELF(weakSelf);
    Model_OrderDesc * orderModel = [self.curModel.orderInfo firstObject];
    
    UIScrollView * contentSV = [[UIScrollView alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(20), CGRectGetMaxY(self.headView.frame) + RECTFIX_HEIGHT(15), SCREEN_WIDTH - RECTFIX_WIDTH(40), SCREEN_HEIGHT - CGRectGetMaxY(self.headView.frame)- RECTFIX_HEIGHT(15) - RECTFIX_HEIGHT(25) )];
    contentSV.backgroundColor = [UIColor whiteColor];
    //[contentSV showPlaceHolderWithLineColor: [UIColor blackColor]];
    contentSV.contentSize = CGSizeMake(contentSV.frame.size.width, 400);
    [self.view addSubview:contentSV];
    
    UILabel * headLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, contentSV.frame.size.width, 2)];
    headLine.backgroundColor = [UIColor colorWithHexString:@"F68602"];
    [contentSV addSubview:headLine];
    
    //订单交易状态view
    UIView * contentHead = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headLine.frame), contentSV.frame.size.width, RECTFIX_HEIGHT(50))];
    [contentSV addSubview:contentHead];
    
    UILabel * bottomLine1 = [UILabel new];
    [contentHead addSubview:bottomLine1];
    [bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentHead.mas_left).with.offset(RECTFIX_WIDTH(6));
        make.right.mas_equalTo(contentHead.mas_right).with.offset(RECTFIX_WIDTH(7));
        make.bottom.mas_equalTo(contentHead.mas_bottom).with.offset(0);
        make.height.equalTo(@(0.5));
    }];
    bottomLine1.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    
    //订单信息
    UILabel * titleLabel1 = [UILabel new];
    [contentHead addSubview:titleLabel1];
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentHead.mas_left).with.offset(RECTFIX_WIDTH(14));
        make.top.mas_equalTo(contentHead.mas_top).with.offset(RECTFIX_HEIGHT(16));
        make.bottom.mas_equalTo(contentHead.mas_bottom).with.offset(-RECTFIX_HEIGHT(17));
        make.width.equalTo(@(100));
    }];
    titleLabel1.text = @"订单信息";
    titleLabel1.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel1.font = [UIFont systemFontOfSize:16];
    
    //订单交易状态
    UILabel * orderState = [UILabel new];
    [contentHead addSubview:orderState];
    [orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel1.mas_right).with.offset(RECTFIX_WIDTH(8));
        make.top.mas_equalTo(contentHead.mas_top).with.offset(RECTFIX_HEIGHT(16));
        make.bottom.mas_equalTo(contentHead.mas_bottom).with.offset(-RECTFIX_HEIGHT(17));
        make.right.mas_equalTo(contentHead.mas_right).with.offset(-RECTFIX_WIDTH(15));
        
    }];
    orderState.textColor = [UIColor colorWithHexString:@"333333"];
    if (orderModel.current_state.integerValue == 6) {
        orderState.text = @"已完成";
    }else if (orderModel.current_state.integerValue == 5 || orderModel.current_state.integerValue == 8 || orderModel.current_state.integerValue == 10){
        orderState.text = @"已取消";
    }else{
        orderState.text = @"进行中";
    }
    
    orderState.textAlignment = NSTextAlignmentRight;
    orderState.font = [UIFont systemFontOfSize:16];
    
    //发单人或接单人联系方式
    UIView * userInfo = [[UIView alloc]init];
    
    
    //订单编号
    UILabel * titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(14), RECTFIX_HEIGHT(15), 80, RECTFIX_HEIGHT(15))];
    titleLabel2.text = @"订单编号:";
    titleLabel2.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel2.font = [UIFont systemFontOfSize:16];
    
    [userInfo addSubview:titleLabel2];
    
    UILabel * orderID = [[UILabel alloc]init];
    [orderID setNumberOfLines:0];
    orderID.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont * orderIDFnt = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    orderID.font = orderIDFnt;
    orderID.textColor = [UIColor colorWithHexString:@"333333"];
    orderID.text = self.curID;
    //[orderID showPlaceHolderWithLineColor:[UIColor redColor]];
    CGRect orderidRect = [orderID.text boundingRectWithSize:CGSizeMake(contentSV.frame.size.width - CGRectGetMaxX(titleLabel2.frame) - RECTFIX_WIDTH(15), 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:orderIDFnt,NSFontAttributeName,nil] context:nil];
    orderID.frame = CGRectMake(CGRectGetMaxX(titleLabel2.frame), RECTFIX_HEIGHT(12), contentSV.frame.size.width - CGRectGetMaxX(titleLabel2.frame) - RECTFIX_WIDTH(15) , orderidRect.size.height);
    
    
    [userInfo addSubview:orderID];
    
    //收货人
    UILabel * titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(14), CGRectGetMaxY(orderID.frame) + RECTFIX_HEIGHT(10), 80, RECTFIX_HEIGHT(15))];
    titleLabel3.text = @"收  货  人:";
    titleLabel3.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel3.font = [UIFont systemFontOfSize:16];
    [userInfo addSubview:titleLabel3];
    
    UILabel * contactName = [[UILabel alloc]init];
    [contactName setNumberOfLines:0];
    contactName.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont * contactFnt = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    contactName.font = contactFnt;
    contactName.textColor = [UIColor colorWithHexString:@"333333"];
    //判断是发单人还是接单人
    contactName.text = self.curModel.plaseHelpUser.nickname;
    //[orderID showPlaceHolderWithLineColor:[UIColor redColor]];
    CGRect contactRect = [contactName.text boundingRectWithSize:CGSizeMake(contentSV.frame.size.width - CGRectGetMaxX(titleLabel3.frame) - RECTFIX_WIDTH(15), 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:contactFnt,NSFontAttributeName,nil] context:nil];
    contactName.frame = CGRectMake(CGRectGetMaxX(titleLabel3.frame), CGRectGetMaxY(orderID.frame)+ RECTFIX_HEIGHT(8), contentSV.frame.size.width - CGRectGetMaxX(titleLabel3.frame) - RECTFIX_WIDTH(15) , contactRect.size.height);
    [userInfo addSubview:contactName];
    
    //收获地址
    UILabel * titleLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(14), CGRectGetMaxY(contactName.frame) + RECTFIX_HEIGHT(10), 80, RECTFIX_HEIGHT(15))];
    titleLabel4.text = @"收货地址:";
    titleLabel4.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel4.font = [UIFont systemFontOfSize:16];
    [userInfo addSubview:titleLabel4];
    
    UILabel * address = [[UILabel alloc]init];
    [address setNumberOfLines:0];
    address.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont * addressFnt = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    address.font = addressFnt;
    address.textColor = [UIColor colorWithHexString:@"333333"];
    Model_OrderDesc * curOrder = [self.curModel.orderInfo firstObject];
    address.text = curOrder.receive_address;
    //[orderID showPlaceHolderWithLineColor:[UIColor redColor]];
    CGRect addressRect = [address.text boundingRectWithSize:CGSizeMake(contentSV.frame.size.width - CGRectGetMaxX(titleLabel4.frame) - RECTFIX_WIDTH(15), 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:addressFnt,NSFontAttributeName,nil] context:nil];
    address.frame = CGRectMake(CGRectGetMaxX(titleLabel4.frame), CGRectGetMaxY(contactName.frame)+ RECTFIX_HEIGHT(8), contentSV.frame.size.width - CGRectGetMaxX(titleLabel4.frame) - RECTFIX_WIDTH(15) , addressRect.size.height);
    [userInfo addSubview:address];
    
    userInfo.frame = CGRectMake(0, CGRectGetMaxY(contentHead.frame), contentSV.frame.size.width, CGRectGetMaxY(address.frame) + RECTFIX_HEIGHT(15));
    [contentSV addSubview:userInfo];
    
    UILabel * bottomLine2 = [UILabel new];
    [userInfo addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(userInfo.mas_left).with.offset(RECTFIX_WIDTH(6));
        make.right.mas_equalTo(userInfo.mas_right).with.offset(RECTFIX_WIDTH(7));
        make.bottom.mas_equalTo(userInfo.mas_bottom).with.offset(0);
        make.height.equalTo(@(0.5));
    }];
    bottomLine2.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    
    //备注及图片
    UIView * remarkView = [[UIView alloc]init];
    
    UILabel * titleLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(14), RECTFIX_HEIGHT(15), 80, RECTFIX_HEIGHT(15))];
    if (self.curModel.orderImags && self.curModel.orderImags.count > 0) {
        titleLabel5.text = @"备注:";
    }else{
        titleLabel5.text = @"备注: 无";
    }
    
    titleLabel5.textColor = [UIColor colorWithHexString:@"646464"];
    titleLabel5.font = [UIFont systemFontOfSize:16.0f];
    [remarkView addSubview:titleLabel5];
    
    
    if (self.curModel.orderImags && self.curModel.orderImags.count > 0) {
        UIView * imagesView = [[UIView alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(14), CGRectGetMaxY(titleLabel5.frame) + RECTFIX_HEIGHT(10), contentSV.frame.size.width - RECTFIX_WIDTH(29), RECTFIX_HEIGHT(40))];
        for (int i = 0; i< self.curModel.orderImags.count; i++) {
            UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(i* RECTFIX_WIDTH(70), 0, RECTFIX_WIDTH(60), imagesView.frame.size.height)];
            Model_Image * curImage = self.curModel.orderImags[i];
            NSLog(@"%@",curImage.resource);
            [iv sd_setImageWithURL:[NSURL URLWithString:curImage.resource]];
            [imagesView addSubview:iv];
        }
        [remarkView addSubview:imagesView];
        
        
        remarkView.frame = CGRectMake(0, CGRectGetMaxY(userInfo.frame), contentSV.frame.size.width, CGRectGetMaxY(imagesView.frame) + RECTFIX_HEIGHT(15));
    }else{
        remarkView.frame = CGRectMake(0, CGRectGetMaxY(userInfo.frame), contentSV.frame.size.width, CGRectGetMaxY(titleLabel5.frame) + RECTFIX_HEIGHT(15));
    }
    
    
    
    
    [contentSV addSubview:remarkView];
    
    UILabel * bottomLine3 = [UILabel new];
    [remarkView addSubview:bottomLine3];
    [bottomLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(remarkView.mas_left).with.offset(RECTFIX_WIDTH(6));
        make.right.mas_equalTo(remarkView.mas_right).with.offset(RECTFIX_WIDTH(7));
        make.bottom.mas_equalTo(remarkView.mas_bottom).with.offset(0);
        make.height.equalTo(@(0.5));
    }];
    bottomLine3.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    
    //订单详细状态及双方评价
    UIView * stateView = [[UIView alloc]init];
//    UILabel * titleLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(14), RECTFIX_HEIGHT(15), 120, RECTFIX_HEIGHT(15))];
//    titleLabel6.text = @"当前订单状态:";
//    titleLabel6.textColor = [UIColor colorWithHexString:@"646464"];
//    titleLabel6.font = [UIFont systemFontOfSize:16];
//    [stateView addSubview:titleLabel6];
    
    UILabel * detailState = [[UILabel alloc]init];
    [detailState setNumberOfLines:0];
    detailState.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont * detailStateFnt = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    detailState.font = detailStateFnt;
    detailState.textColor = [UIColor colorWithHexString:@"646464"];
    NSInteger state = orderModel.current_state.integerValue;
    NSString * stateType;
    switch (state) {
        case 2:
            stateType = @"等待接单";
            break;
        case 3:
            stateType = @"已接单";
            break;
        case 6:
            stateType = @"已完成";
            break;
        case 7:
            stateType = @"甲方提出悔单";
            break;
        case 8:
            stateType = @"乙方答应悔单";
            break;
        case 9:
            stateType = @"乙方提出悔单";
            break;
        case 10:
            stateType = @"甲方答应悔单";
            break;
        case 11:
            stateType = @"已发货";
            break;
        case 12:
            stateType = @"乙不同意悔单";
            break;
        case 13:
            stateType = @"甲不同意悔单";
            break;
        default:
        {
            NSLog(@"%d",state);
            stateType = @"未判断";
        }
            break;
    }
    detailState.text =[NSString stringWithFormat:@"当前订单状态：%@ %@",stateType,orderModel.create_time];
    
    //[orderID showPlaceHolderWithLineColor:[UIColor redColor]];
    CGRect detailRect = [detailState.text boundingRectWithSize:CGSizeMake(contentSV.frame.size.width - RECTFIX_WIDTH(29), 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:detailStateFnt,NSFontAttributeName,nil] context:nil];
    detailState.frame = CGRectMake(RECTFIX_WIDTH(14), RECTFIX_HEIGHT(13), contentSV.frame.size.width - RECTFIX_WIDTH(29) , detailRect.size.height);
    [stateView addSubview:detailState];
    
    //当前用户账号
    NSString * curAccountID = [UserInfoTool getCurrentAccountID];
    
    
    UILabel * evaluate1 = [[UILabel alloc]init];
    [evaluate1 setNumberOfLines:0];
    evaluate1.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont * evaluateFnt1 = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    evaluate1.font = evaluateFnt1;
    evaluate1.textColor = [UIColor colorWithHexString:@"646464"];
    
    
    //根据accountID判断
    Model_User * helpUser = self.curModel.helpUser;
    Model_User * pleaseHelpUser = self.curModel.plaseHelpUser;
    NSLog(@"%@",curAccountID);
    NSLog(@"%@",helpUser.appUserAccount);
    if (helpUser.evaluate || pleaseHelpUser.evaluate) {
        if ([curAccountID isEqualToString:helpUser.appUserAccount])
        {
            //当前用户是去帮者
            if (helpUser.evaluate && ![helpUser.evaluate isEqualToString:@""]) {
                evaluate1.text = [NSString stringWithFormat:@"你对%@的评价:%@",pleaseHelpUser.nickname,helpUser.evaluate];
            }else{
                evaluate1.text = [NSString stringWithFormat:@"你对%@的评价:未评价",pleaseHelpUser.nickname];
            }
        }else{
            //当前用户是求帮者
            if (pleaseHelpUser.evaluate && ![pleaseHelpUser.evaluate isEqualToString:@""]) {
                evaluate1.text = [NSString stringWithFormat:@"你对%@的评价:%@",helpUser.nickname,pleaseHelpUser.evaluate];
            }else{
                evaluate1.text = [NSString stringWithFormat:@"你对%@的评价:未评价",helpUser.nickname];
            }
        }

    }
    
    //[orderID showPlaceHolderWithLineColor:[UIColor redColor]];
    CGRect evaluate1Rect = [evaluate1.text boundingRectWithSize:CGSizeMake(contentSV.frame.size.width  - RECTFIX_WIDTH(29), 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:evaluateFnt1,NSFontAttributeName,nil] context:nil];
    evaluate1.frame = CGRectMake(RECTFIX_WIDTH(14), CGRectGetMaxY(detailState.frame)+ RECTFIX_HEIGHT(10), contentSV.frame.size.width - RECTFIX_WIDTH(29) , evaluate1Rect.size.height);
    [stateView addSubview:evaluate1];
    
    
    UILabel * evaluate2 = [[UILabel alloc]init];
    [evaluate2 setNumberOfLines:0];
    evaluate2.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont * evaluateFnt2 = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    evaluate2.font = evaluateFnt2;
    evaluate2.textColor = [UIColor colorWithHexString:@"646464"];
    //根据accountID判断
    NSLog(@"%@",curAccountID);
    NSLog(@"%@",helpUser.appUserAccount);
    if (helpUser.evaluate || pleaseHelpUser.evaluate) {
        if ([curAccountID isEqualToString:helpUser.appUserAccount])
        {
            //当前用户是去帮者
            if (pleaseHelpUser.evaluate && ![pleaseHelpUser.evaluate isEqualToString:@""]) {
                evaluate2.text = [NSString stringWithFormat:@"%@对你的评价:%@",pleaseHelpUser.nickname,pleaseHelpUser.evaluate];
            }else{
                evaluate2.text = [NSString stringWithFormat:@"%@对你的评价:未评价",pleaseHelpUser.nickname];
            }
            
        }else{
            //当前用户是求帮者
            if (helpUser.evaluate && ![helpUser.evaluate isEqualToString:@""]) {
                evaluate2.text = [NSString stringWithFormat:@"%@对你的评价:%@",helpUser.nickname,helpUser.evaluate];
            }else{
                evaluate2.text = [NSString stringWithFormat:@"%@对你的评价:未评价",helpUser.nickname];
            }
        }
    }
    

    //evaluate2.text = self.curModel.helpUser.evaluate;
    //[orderID showPlaceHolderWithLineColor:[UIColor redColor]];
    CGRect evaluate2Rect = [evaluate2.text boundingRectWithSize:CGSizeMake(contentSV.frame.size.width  - RECTFIX_WIDTH(29), 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:evaluateFnt2,NSFontAttributeName,nil] context:nil];
    evaluate2.frame = CGRectMake(RECTFIX_WIDTH(14), CGRectGetMaxY(evaluate1.frame)+ RECTFIX_HEIGHT(10), contentSV.frame.size.width - RECTFIX_WIDTH(29) , evaluate2Rect.size.height);
    [stateView addSubview:evaluate2];
    
    
    
    stateView.frame = CGRectMake(0, CGRectGetMaxY(remarkView.frame), contentSV.frame.size.width, CGRectGetMaxY(evaluate2.frame) + RECTFIX_HEIGHT(15));
    [contentSV addSubview:stateView];
    
    UILabel * bottomLine4 = [UILabel new];
    [stateView addSubview:bottomLine4];
    [bottomLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(stateView.mas_left).with.offset(RECTFIX_WIDTH(6));
        make.right.mas_equalTo(stateView.mas_right).with.offset(RECTFIX_WIDTH(7));
        make.bottom.mas_equalTo(stateView.mas_bottom).with.offset(0);
        make.height.equalTo(@(0.5));
    }];
    bottomLine4.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    
    UIButton * btn1 = [UIButton new];
    [self.view addSubview:btn1];
    [self.view bringSubviewToFront:btn1];
    //    [btn showPlaceHolderWithLineColor:[UIColor blackColor]];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(-RECTFIX_WIDTH(30));
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(-RECTFIX_HEIGHT(49+20 + 68 + 5));
        make.size.mas_equalTo(CGSizeMake(RECTFIX_WIDTH(68), RECTFIX_WIDTH(68)));
    }];
    btn1.hidden = YES;
    
    UIButton * btn2 = [UIButton new];
    [self.view addSubview:btn2];
    [self.view bringSubviewToFront:btn2];
    //    [btn showPlaceHolderWithLineColor:[UIColor blackColor]];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(-RECTFIX_WIDTH(30));
        make.top.mas_equalTo(btn1.mas_bottom).with.offset(RECTFIX_HEIGHT(5));
        make.size.mas_equalTo(CGSizeMake(RECTFIX_WIDTH(68), RECTFIX_WIDTH(68)));
    }];
    btn2.hidden = YES;
    
    //抢单条件下根据订单状态显示撤单按钮
    if (orderModel.ptype.integerValue == OrderPtypeGrab) {
        NSLog(@"curAccountID = %@",curAccountID);
        NSLog(@"pleaseHelpAccount = %@",orderModel.pleaseHelpAccount);
        if ([curAccountID isEqualToString:orderModel.pleaseHelpAccount]) {
            //当前用户是发单者
            if (state == 2 || state == 3 || state == 4) {
                btn1.hidden = NO;
                [btn1 setImage:[UIImage imageNamed:@"bt-orange-chedan2x-"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(cancelOrderAction) forControlEvents:UIControlEventTouchUpInside];
                btn2.hidden = YES;
            }else if (state == 11){
                //接单者确认发货
                btn1.hidden = NO;
                [btn1 setImage:[UIImage imageNamed:@"bt-bluequerenshouhuo2x-"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(confirmReceiveAction) forControlEvents:UIControlEventTouchUpInside];
            }else if (state == 6){
                //在评价的方法里判断的用户角色
                if (orderModel.evaluate_state.integerValue == 0) {
                    //订单完成但已评价过
                    btn1.hidden = NO;
                    [btn1 setImage:[UIImage imageNamed:@"bt-blue-pinglun2x-"] forState:UIControlStateNormal];
                    [btn1 addTarget:self action:@selector(evaluateAction) forControlEvents:UIControlEventTouchUpInside];
                }else{
                    //订单完成未评价过
                    btn1.hidden = YES;
                    
                }
            }
        }else{
            //当前用户不是发单者
            if (state == 7) {
                //当前用户是接单者且甲方提出悔单
                //按钮1
                btn1.hidden = NO;
                [btn1 setImage:[UIImage imageNamed:@"order_detail_over"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
                //按钮2
                btn2.hidden = NO;
                [btn2 setImage:[UIImage imageNamed:@"order_detail_del"] forState:UIControlStateNormal];
                [btn2 addTarget:self action:@selector(refuseAction) forControlEvents:UIControlEventTouchUpInside];
            }else if (state == 2){
                //显示接单按钮
                btn1.hidden = NO;
                [btn1 setImage:[UIImage imageNamed:@"bt-green-jiedan2x-"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(receiveOrderAction) forControlEvents:UIControlEventTouchUpInside];
            }
        }

    }else if (orderModel.ptype.integerValue ==  OrderPtypeCompete){
        if ([curAccountID isEqualToString:orderModel.pleaseHelpAccount]) {
            //求帮者
            if (self.orderModel.current_state.integerValue == 2) {
                //发单者身份且为竞单状态
                btn1.hidden = NO;
                [btn1 setImage:[UIImage imageNamed:@"bt-orange-chedan2x-"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(cancelOrderAction) forControlEvents:UIControlEventTouchUpInside];
                
                btn2.hidden = NO;
                [btn2 setImage:[UIImage imageNamed:@"bt_jingdanzhe_2x"] forState:UIControlStateNormal];
                [btn2 addTarget:self action:@selector(competeUser) forControlEvents:UIControlEventTouchUpInside];
            }else if (self.orderModel.current_state.integerValue == 3){
                //竞单成功状态
                btn1.hidden = NO;
                [btn1 setImage:[UIImage imageNamed:@"bt-orange-chedan2x-"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(cancelOrderAction) forControlEvents:UIControlEventTouchUpInside];
                btn2.hidden = YES;
            }else if (self.orderModel.current_state.integerValue == 11){
                btn1.hidden = NO;
                [btn1 setImage:[UIImage imageNamed:@"bt-bluequerenshouhuo2x-"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(confirmReceiveAction) forControlEvents:UIControlEventTouchUpInside];
                btn2.hidden = YES;
            }else if (self.orderModel.current_state.integerValue == 6 && self.orderModel.evaluate_state.integerValue == 0)
            {
                //订单完成但是没有评价
                btn1.hidden = NO;
                [btn1 setImage:[UIImage imageNamed:@"bt-blue-pinglun2x-"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(evaluateAction) forControlEvents:UIControlEventTouchUpInside];
                btn2.hidden = YES;
            }
            
        }else{
            //帮助者
            if (self.orderModel.current_state.integerValue ==3) {
                //接单成功
                btn1.hidden = NO;
                [btn1 setImage:[UIImage imageNamed:@"bt-blue-querenfahuo2x-"] forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(confirmSendAction) forControlEvents:UIControlEventTouchUpInside];
                btn2.hidden = YES;
            }else if (self.orderModel.current_state.integerValue == 2){
                if (self.curModel.is_take_part.integerValue == 0) {
                    //还没竞过单
                    btn1.hidden = NO;
                    [btn1 setImage:[UIImage imageNamed:@"bt-green-jiedan2x-"] forState:UIControlStateNormal];
                    [btn1 addTarget:self action:@selector(receiveOrderAction) forControlEvents:UIControlEventTouchUpInside];
                    btn2.hidden = YES;
                }
                
            }
        }
    }
    
    

}

- (void)createOperateView
{
    WEAK_SELF(weakSelf);
    UIView * OperateView = [UIView new];
    [self.view addSubview:OperateView];
    [OperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(0);
        make.height.equalTo(@(RECTFIX_HEIGHT(49)));
    }];
    OperateView.backgroundColor = [UIColor colorWithHexString:@"232226"];
    OperateView.alpha = 0.9;
    
    NSArray * iconNameArr = [NSArray arrayWithObjects:@"bt_liaotian_2x",@"bt-lianxi2x",@"bt-dizhi2x", nil];
    NSArray * iconPerArr = [NSArray arrayWithObjects:@"bt-liaotian-per2x",@"bt-lianxi-per2x",@"bt-dizhi-per2x", nil];
    
    for (int i = 0; i < iconNameArr.count; i ++) {
        UIButton * opBtn = [[UIButton alloc]initWithFrame:CGRectMake(i *(SCREEN_WIDTH/3), 0, SCREEN_WIDTH/3, RECTFIX_HEIGHT(49))];
        opBtn.tag = BTNTAG + i;
        //opBtn.backgroundColor = [UIColor redColor];
        [opBtn addTarget:self action:@selector(operateAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * iconIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, opBtn.frame.size.height, opBtn.frame.size.height)];
        iconIV.center = CGPointMake(opBtn.center.x, opBtn.center.y);
//        iconIV.image = [UIImage imageNamed:iconNameArr[i]];
        NSString * iconName = iconNameArr[i];
        NSString * perName = iconPerArr[i];
        [opBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
        [opBtn setImage:[UIImage imageNamed:perName] forState:UIControlStateSelected];
        UIEdgeInsets  edge = UIEdgeInsetsMake(RECTFIX_HEIGHT(10), (SCREEN_WIDTH/3 - RECTFIX_HEIGHT(49 -20))/2, RECTFIX_HEIGHT(10), (SCREEN_WIDTH/3 - RECTFIX_HEIGHT(49 -20))/2);
        opBtn.contentEdgeInsets = edge;
        [opBtn addSubview:iconIV];
        [OperateView addSubview:opBtn];
    }
    
}

- (void)createUI
{
    self.orderModel = [self.curModel.orderInfo firstObject];
    [self createHeadView];
    [self createContentView];
    
    if (self.orderModel.ptype.integerValue == OrderPtypeGrab) {
        //抢单模式下
        if (self.orderModel.current_state.integerValue >= 3 && self.orderModel.current_state.integerValue != 4) {
            [self createOperateView];
        }
    }else if (self.orderModel.ptype.integerValue == OrderPtypeCompete){
        if (self.orderModel.current_state.integerValue >= 3) {
            [self createOperateView];
        }
    }
}
#pragma mark - Action
///接单
- (void)receiveOrderAction
{
    self.orderModel = [self.curModel.orderInfo firstObject];
    //竞单
    if (self.orderModel.ptype.integerValue == OrderPtypeCompete) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请输入竞单价格" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        alertView.tag = ALERTTAG + 5;
        [alertView show];
    }
    //邀单
    else if (self.orderModel.ptype.integerValue == OrderPtypeInvite){
    
    }
    //抢单
    else if (self.orderModel.ptype.integerValue == OrderPtypeGrab){
        [self joinGrabOrder];
    }
    
}

- (void)operateAction:(UIButton *)btn
{
    if (btn.tag -BTNTAG == 0) {
        //联系对方(环信)
        NSLog(@"环信");
    }else if (btn.tag -BTNTAG == 1){
        //拨打电话
        NSLog(@"拨打电话");
        NSString * accountID = [UserInfoTool getCurrentAccountID];
        if ([accountID isEqualToString:self.curModel.plaseHelpUser.appUserAccount]) {
            //当前用户是求帮者
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.curModel.helpUser.phone];
            //            NSLog(@"str======%@",str);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else{
            //当前用户是去帮者
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.curModel.plaseHelpUser.phone];
            //            NSLog(@"str======%@",str);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
        
    }else{
        //收货地址定位
        NSLog(@"地址定位");
    }
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

///撤消订单
- (void)cancelOrderAction
{
    NSLog(@"撤销按钮");
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"是否确认撤销订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = ALERTTAG;
    [alertView show];
    

    
}
///同意撤销订单
- (void)agreeAction
{
    NSLog(@"同意撤销按钮");
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"是否同意撤销订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = ALERTTAG + 1;
    [alertView show];
}

///不同意撤销订单
- (void)refuseAction
{
    NSLog(@"不同意撤销按钮");
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"是否拒绝撤销订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = ALERTTAG + 2;
    [alertView show];
}

///查看竞单者列表
- (void)competeUser
{
    InviteOrCompeteListVC * listVC = [[InviteOrCompeteListVC alloc]init];
    listVC.currentOrderID = self.curID;
    if (self.orderModel.ptype.integerValue == 2) {//获取邀单者列表
        listVC.type = 1;
        
    }else if (self.orderModel.ptype.integerValue == 1){//获取竞单者列表
        listVC.type = 2;
        
    }
    
    [self.navigationController pushViewController:listVC animated:YES];
    
    
}
///确认收货
- (void)confirmReceiveAction
{
    NSLog(@"确认收货按钮");
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"是否确认收货" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = ALERTTAG + 3;
    [alertView show];
}
///确认发货
- (void)confirmSendAction
{
    NSLog(@"确认发货按钮");
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"是否确认发货" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = ALERTTAG + 4;
    [alertView show];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"取消");
            break;
        case 1:
        {
            NSLog(@"确认");
            if (alertView.tag - ALERTTAG == 0) {
                //撤销订单按钮
                [self cancleOrderWithFlagApprove:@"1"];

            }else if (alertView.tag - ALERTTAG == 1){
                //同意撤销订单按钮
                [self cancleOrderWithFlagApprove:@"1"];
                
            }else if (alertView.tag - ALERTTAG == 2){
                //拒绝撤销订单按钮
                [self cancleOrderWithFlagApprove:@"2"];
            }else if (alertView.tag - ALERTTAG == 3){
                //确认收货按钮
                [self confirmReceiveGoods];
            }else if (alertView.tag - ALERTTAG == 4){
                //确认发货按钮
                [self confirmSendGoods];
            }else if (alertView.tag - ALERTTAG == 5){
                //确认竞单按钮
                UITextField * tf = [alertView textFieldAtIndex:0];
                if ([RegTools regResultWithRechargeMoney:tf.text]) {
                    [self joinCompeteOrderWithCost:tf.text];
                }else{
                    [self.view makeToast:@"请输入正确金额" duration:ToastDuration position:CSToastPositionCenter];
                    
                }
            }
            
            
        }
            break;
            
        default:
            break;
    }
}
///进入评价页面
- (void)evaluateAction
{
    AssessmentViewController * assessmentVC = [[AssessmentViewController alloc]init];
    Model_OrderDesc * curOrder = [self.curModel.orderInfo firstObject];
    curOrder.id = self.curID;
    NSString * curAcc = [UserInfoTool getCurrentAccountID];
    if (curOrder) {
        assessmentVC.model = curOrder;
        if ([curAcc isEqualToString:self.curModel.helpUser.account]) {
            assessmentVC.reviewType = ReviewTypeHelpTo;
        }else{
            assessmentVC.reviewType = ReviewTypeSendHelp;
        }
        [self.navigationController pushViewController:assessmentVC animated:YES];
    }
    
    
}
///确认收货方法
- (void)confirmReceiveGoods
{
    WEAK_SELF(weakSelf);
    [OrderRequestTool confirmFinishOrderWithProcessID:self.curID andSuccessed:^(id model) {
        Model_Request * requestModel = model;
        [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
        if ([requestModel.state isEqualToString:dStateSuccess]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } andFailed:^(NSError *err) {
        NSLog(@"err = %@",err);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}
///确认发货方法
- (void)confirmSendGoods
{
    WEAK_SELF(weakSelf);
    [OrderRequestTool confirmOrderWithProcessID:self.curID andSuccessed:^(id model) {
        Model_Request * requestModel = model;
        [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
        if ([requestModel.state isEqualToString:dStateSuccess]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } andFailed:^(NSError *err) {
        NSLog(@"err = %@",err);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
    }];
}

#pragma mark - Request
///取消订单
- (void)cancleOrderWithFlagApprove:(NSString *)flag
{
    WEAK_SELF(weakSelf);
    NSString * token = [UserInfoTool getToken];
    if (token && ![token isEqualToString:@""]) {
        [OrderRequestTool cancelOrderWithToken:token andProcessID:self.curID andFlagApprove:flag andSuccessed:^(id model) {
            Model_Request * requestModel = model;
            if ([requestModel.state isEqualToString:dStateSuccess]) {
                [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } andFailed:^(NSError *err) {
            NSLog(@"err = %@",err);
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];
    }
}

///根据订单编号获取订单详情
- (void)requestOrderDetailWithOrderID:(NSString *)orderID
{
    WEAK_SELF(weakSelf);
    [OrderRequestTool requestOrderInfoWithProcessId:orderID andSuccessed:^(id model) {
        Model_SearchReviewOrder * searchModel = model;
        if ([searchModel.state isEqualToString:dStateSuccess]) {
            weakSelf.curModel = searchModel.responseText;
            [self createUI];
            
        }else{
            [weakSelf.view makeToast:searchModel.message duration:ToastDuration position:CSToastPositionCenter];
        }
        
    } andFailed:^(NSError *err) {
        NSLog(@"err = %@",err);
        [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        
    }];
}

///参与竞单
- (void)joinCompeteOrderWithCost:(NSString *)cost
{
    WEAK_SELF(weakSelf);
    NSString * token = [UserInfoTool getToken];
    if (token && ![token isEqualToString:@""]) {
        [OrderRequestTool competeOrderWithToken:token andID:self.curID andCost:cost andSuccessed:^(id model) {
            Model_Request * requestModel = model;
            if ([requestModel.state isEqualToString:dStateSuccess]) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
            }
        } andFailed:^(NSError *err) {
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];
    }
    
    
}

///抢单
- (void)joinGrabOrder{
    WEAK_SELF(weakSelf);
    NSString * token = [UserInfoTool getToken];
    if (token && ![token isEqualToString:@""]) {
        [OrderRequestTool grabOrderWithToken:token andID:self.curID andSuccessed:^(id model) {
            Model_Request * requestModel = model;
            [weakSelf.view makeToast:requestModel.message duration:ToastDuration position:CSToastPositionCenter];
            if ([requestModel.state isEqualToString:dStateSuccess]) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        } andFailed:^(NSError *err) {
            [weakSelf.view makeToast:dTips_connectionError duration:ToastDuration position:CSToastPositionCenter];
        }];
    }
}

@end
