//
//  Cell_Order.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_Order.h"
#import "UIImageView+WebCache.h"
#import "OrderDetailViewController.h"
#import "InviteOrCompeteListVC.h"
#import "ReviewViewController.h"

@interface Cell_Order()

@property (nonatomic, strong) UILabel * typeLabel;
@property (nonatomic, strong) UIView * orderView;
@property (nonatomic, strong) UIImageView * iv1;
@property (nonatomic, strong) UIImageView * iv2;
@property (nonatomic, strong) UIImageView * iv3;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIButton * talkBtn;
@property (nonatomic, strong) UIView * btnView;

@end

@implementation Cell_Order

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self updateUI];
    }
    return self;
}

- (void)updateUI
{
    WEAK_SELF(weakSelf);
    
    self.typeLabel = [UILabel new];
    [self.contentView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(20);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(60, 30));
        
    }];
//    self.typeLabel.backgroundColor = [UIColor yellowColor];
    //倒计时view
    UIView * timeView = [UIView new];
    [self.contentView addSubview:timeView];
//    [timeView showPlaceHolderWithLineColor:[UIColor blackColor]];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-20);
        make.left.mas_equalTo(weakSelf.typeLabel.mas_right).with.offset(10);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(0);
        make.height.equalTo(@30);
    }];
//    timeView.backgroundColor = [UIColor blueColor];
    UILabel * timeLabel = [UILabel new];
    [timeView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(timeView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    timeLabel.text = @"剩余时间 07:14:04";
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textAlignment = NSTextAlignmentRight;
    
    
    self.orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, kMainScreenWidth, 40)];
    [self.contentView addSubview:self.orderView];
    //文字label
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kMainScreenWidth-40, self.orderView.frame.size.height)];
    self.contentLabel.text = @"请帮忙";
    self.contentLabel.textColor = [UIColor lightGrayColor];
    [self.orderView addSubview:self.contentLabel];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
//    self.contentLabel.hidden = YES;第一版本没有语音，更新版本需要修改
    
    //语音btn
    
    
    self.iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.orderView.frame), (kMainScreenWidth-60)/3, 0.88 *((kMainScreenWidth-60)/3))];
    [self.contentView addSubview:self.iv1];
    self.iv1.hidden = YES;
    self.iv1.image = [UIImage imageNamed:@"接的订单_07"];
//    self.iv1.backgroundColor = [UIColor lightGrayColor];
    
    self.iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iv1.frame)+10, CGRectGetMaxY(self.orderView.frame), (kMainScreenWidth-60)/3, 0.88 *((kMainScreenWidth-60)/3))];
    [self.contentView addSubview:self.iv2];
    self.iv2.hidden = YES;
    self.iv2.image = [UIImage imageNamed:@"接的订单2_07"];
//    self.iv2.backgroundColor = [UIColor lightGrayColor];
    
    self.iv3 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iv2.frame)+10, CGRectGetMaxY(self.orderView.frame), (kMainScreenWidth-60)/3, 0.88 *((kMainScreenWidth-60)/3))];
    [self.contentView addSubview:self.iv3];
    self.iv3.hidden = YES;
    self.iv3.image = [UIImage imageNamed:@"接的订单3_07"];
//    self.iv3.backgroundColor = [UIColor lightGrayColor];
    
    self.btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
//    btnView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.btnView];
    self.btnView.userInteractionEnabled = YES;
    
    
    self.btn3 = [UIButton new];
    [self.btnView addSubview:self.btn3];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.btnView.mas_right).with.offset(-20);
        make.top.mas_equalTo(self.btnView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(72, 28));
        
    }];
//    [self.btn3 setTitle:@"确认发货" forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    self.btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    self.btn3.layer.borderWidth = 1;
    self.btn3.layer.borderColor = [[UIColor colorWithHexString:@"333333"]CGColor];
    self.btn3.layer.masksToBounds = YES;
    self.btn3.layer.cornerRadius = 2;
//    self.btn3.backgroundColor = [UIColor lightGrayColor];
//    [self.btn3 addTarget:self action:@selector(btn3Action:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = [UIButton new];
    [self.btnView addSubview:self.btn2];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.btn3.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.btnView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(72, 28));
        
    }];
    [self.btn2 setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    self.btn2.layer.borderWidth = 1;
    self.btn2.layer.borderColor = [[UIColor colorWithHexString:@"333333"]CGColor];
    self.btn2.layer.masksToBounds = YES;
    self.btn2.layer.cornerRadius = 2;
    
    self.btn1 = [UIButton new];
    [self.btnView addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.btn2.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.btnView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(72, 28));
        
    }];
    [self.btn1 setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    self.btn1.layer.borderWidth = 1;
    self.btn1.layer.borderColor = [[UIColor colorWithHexString:@"333333"]CGColor];
    self.btn1.layer.masksToBounds = YES;
    self.btn1.layer.cornerRadius = 2;
    

//    self.btn2.backgroundColor = [UIColor lightGrayColor];
    
//    [self.btn1 setTitle:@"联系买家" forState:UIControlStateNormal];
    
    
    if (self.model.ptype.integerValue == 3)
    {
        //抢单
        if (self.model.current_state.integerValue == 2) {
            

        }else{
            

            
        }
    }
    //[self.btn1 addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    self.btn1.backgroundColor = [UIColor lightGrayColor];

//
//    
//    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.iv1.frame), 72, 28)];
//    self.btn1.backgroundColor = [UIColor redColor];
//    [self.btn1 setTitle:@"查看详情" forState:UIControlStateNormal];
//    self.btn1.tag = 11;
//    [self.contentView addSubview:self.btn1];
    
}

-(void)layoutSubviews
{
//    if (self.model.isTalk == YES) {
////        self.orderView.backgroundColor = [UIColor redColor];
//        self.contentLabel.hidden = NO;
//    }else{
////        self.orderView.backgroundColor = [UIColor greenColor];
//        self.contentLabel.hidden = YES;
//    }
}

-(void)setModel:(Model_OrderDesc *)model
{
    _model = model;
    NSString * ptypeStr = nil;
    if ([model.ptype isEqualToString:@"1"]) {
        ptypeStr = @"竞单";
    }else if ([model.ptype isEqualToString:@"2"]){
        ptypeStr = @"邀单";
    }else{
        ptypeStr = @"抢单";
    }
    if (model.images && model.images > 0) {
        
//        CGRect btnViewFrame = self.btnView.frame;
//        btnViewFrame.origin.y = CGRectGetMaxY(self.iv1.frame);
//        self.btnView.frame = btnViewFrame;
//        [self layoutSubviews];
        
        if (model.images.count == 1) {
            self.iv1.hidden = NO;
            self.iv2.hidden = YES;
            self.iv3.hidden = YES;
            [self.iv1 sd_setImageWithURL:[NSURL URLWithString:model.images[0]]];
        }else if (model.images.count == 2) {
            self.iv1.hidden = NO;
            self.iv2.hidden = NO;
            self.iv3.hidden = YES;
            [self.iv1 sd_setImageWithURL:[NSURL URLWithString:model.images[0]]];
            NSLog(@"imageStr = %@",model.images[0]);
            [self.iv2 sd_setImageWithURL:[NSURL URLWithString:model.images[1]]];
            
        }else if (model.images.count == 3) {
            self.iv1.hidden = NO;
            self.iv2.hidden = NO;
            self.iv3.hidden = NO;
            [self.iv1 sd_setImageWithURL:[NSURL URLWithString:model.images[0]]];
            [self.iv2 sd_setImageWithURL:[NSURL URLWithString:model.images[1]]];
            [self.iv3 sd_setImageWithURL:[NSURL URLWithString:model.images[2]]];
        }
        
    }else{
       
        self.iv1.hidden = YES;
        self.iv2.hidden = YES;
        self.iv3.hidden = YES;
        
//        CGRect btnViewFrame = self.btnView.frame;
//        btnViewFrame.origin.y = CGRectGetMaxY(self.orderView.frame);
//        self.btnView.frame = btnViewFrame;
//        [self layoutSubviews];
        
    }
    self.typeLabel.text = ptypeStr;
    self.contentLabel.text = model.descrip;
    

    
    
    
    
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.model.images && self.model.images.count > 0) {
        
        CGRect btnViewFrame = self.btnView.frame;
        btnViewFrame.origin.y = CGRectGetMaxY(self.iv1.frame);
        self.btnView.frame = btnViewFrame;
        
        
    }else{

        CGRect btnViewFrame = self.btnView.frame;
        btnViewFrame.origin.y = CGRectGetMaxY(self.orderView.frame);
        self.btnView.frame = btnViewFrame;
        
    }

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - ButtonAction
//- (void)btn1Action:(UIButton *)btn
//{
//    NSLog(@"测试");
//    if (self.model.current_state.integerValue == 2) {//订单未完成
//        InviteOrCompeteListVC * listVC = [[InviteOrCompeteListVC alloc]init];
//        if (self.model.ptype.integerValue == 2) {//获取邀单者列表
//            listVC.type = 1;
//            listVC.currentOrderID = self.model.id;
//            [self.delegate.navigationController pushViewController:listVC animated:YES];
//        }else if(self.model.ptype.integerValue == 1){//获取竞单者列表
//            listVC.type = 2;
//            listVC.currentOrderID = self.model.id;
//            [self.delegate.navigationController pushViewController:listVC animated:YES];
//        }
//    }
//
//}




@end
