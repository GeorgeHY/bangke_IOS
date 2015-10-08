//
//  Cell_Helplist.m
//  Bangke_IOS
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import "Cell_Helplist.h"


typedef NS_ENUM(NSInteger, OrderPtype) {
    OrderPtypeCompete = 1,//竞单
    OrderPtypeInvite,//邀单
    OrderPtypeGrab//抢单
};


@interface Cell_Helplist()

@property (nonatomic, strong) UIImageView * headIV;
@property (nonatomic, strong) UIImageView * typeIV;
@property (nonatomic, strong) UILabel * typeLabel;
@property (nonatomic, strong) UILabel * childLabel;
@property (nonatomic, strong) UIImageView * arrowIV;
@property (nonatomic, strong) UILabel * parentLabel;
@property (nonatomic, strong) UILabel * nicknameLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * disLabel;

@end

@implementation Cell_Helplist

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
    self.headIV = [[UIImageView alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(15), RECTFIX_HEIGHT(15), RECTFIX_WIDTH(60), RECTFIX_WIDTH(60))];
    //[self.headIV showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.headIV.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.headIV];
    self.headIV.layer.masksToBounds = YES;
    self.headIV.layer.cornerRadius = RECTFIX_WIDTH(30);
    
    self.typeIV = [UIImageView new];
    [self.contentView addSubview:self.typeIV];
    [self.typeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.headIV.mas_centerX);
        make.top.mas_equalTo(weakSelf.headIV.mas_bottom).with.offset(-RECTFIX_HEIGHT(10));
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
    
    //子标签label
    self.childLabel = [[UILabel alloc]init];
    self.childLabel.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    //[self.childLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.contentView addSubview:self.childLabel];
    
    self.arrowIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.childLabel.frame)-RECTFIX_WIDTH(7), RECTFIX_HEIGHT(20), RECTFIX_WIDTH(7), RECTFIX_HEIGHT(15))];
    [self.contentView addSubview:self.arrowIV];
    self.arrowIV.image = [UIImage imageNamed:@"im-gray-biaoqian2x-"];
    
    //父标签label
    self.parentLabel = [[UILabel alloc]init];
    self.parentLabel.backgroundColor = [UIColor colorWithHexString:@"FA9924"];
    //[self.parentLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.contentView addSubview:self.parentLabel];
    
    //昵称Label
    self.nicknameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.nicknameLabel];
    //[self.nicknameLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.typeIV.mas_right).with.offset(RECTFIX_WIDTH(15));
        make.right.mas_equalTo(weakSelf.parentLabel.mas_left).with.offset(-RECTFIX_WIDTH(15));
        make.centerY.mas_equalTo(weakSelf.childLabel.mas_centerY);
        make.height.equalTo(@(RECTFIX_HEIGHT(20)));
    }];
    self.nicknameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0f];
    self.nicknameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    //订单内容
    self.contentLabel = [UILabel new];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.typeIV.mas_right).with.offset(RECTFIX_WIDTH(15));
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-RECTFIX_WIDTH(15));
        make.top.mas_equalTo(weakSelf.nicknameLabel.mas_bottom).with.offset(RECTFIX_HEIGHT(20));
        make.height.equalTo(@(RECTFIX_HEIGHT(40)));
    }];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0f];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    //sepline
    UILabel * sepLine = [UILabel new];
    [self.contentView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(weakSelf.typeIV.mas_right).with.offset(RECTFIX_WIDTH(15));
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-RECTFIX_WIDTH(15));
        make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom).with.offset(RECTFIX_HEIGHT(5));
        make.height.equalTo(@(0.5));
    }];
    sepLine.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    //价格
    self.priceLabel = [[UILabel alloc]init];
    //[priceLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.priceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
    self.priceLabel.textColor = [UIColor colorWithHexString:@"FA9924"];
    [self.contentView addSubview:self.priceLabel];
    
    //距离
    self.disLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.disLabel];
    [self.disLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-RECTFIX_WIDTH(20));
        make.centerY.mas_equalTo(weakSelf.priceLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.priceLabel.mas_right).with.offset(RECTFIX_WIDTH(20));
        make.height.equalTo(@(RECTFIX_HEIGHT(15)));
    }];
    //[priceLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.disLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
    self.disLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    
    
    
    
    
    
    
}

- (void)setModel:(Model_OrderHelpList *)model
{
    WEAK_SELF(weakSelf);
    
    _model = model;
    if (model.process_type.integerValue == OrderPtypeCompete) {
        self.typeIV.image = [UIImage imageNamed:@"to_help_home_complete"];
        self.typeLabel.text = @"竞单模式";
    }else if (model.process_type.integerValue == OrderPtypeInvite){
        self.typeIV.image = [UIImage imageNamed:@"to_help_home_invite"];
        self.typeLabel.text = @"邀单模式";
    }else{
        self.typeIV.image = [UIImage imageNamed:@"to_help_home_qiang2"];
        self.typeLabel.text = @"抢单模式";
    }
    
    self.childLabel.text = model.subsequent_label_name;
    CGSize childsize = [self.childLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:12.0f],NSFontAttributeName, nil]];
    self.childLabel.frame = CGRectMake(SCREEN_WIDTH -RECTFIX_WIDTH(30)- childsize.width,RECTFIX_HEIGHT(20), childsize.width+RECTFIX_WIDTH(10),RECTFIX_HEIGHT(15));
    self.childLabel.textAlignment = NSTextAlignmentCenter;
    self.childLabel.font =[UIFont systemFontOfSize:12];
    self.childLabel.textColor = [UIColor whiteColor];
    //箭头图标
    self.arrowIV.frame = CGRectMake(CGRectGetMinX(self.childLabel.frame)-RECTFIX_WIDTH(7), RECTFIX_HEIGHT(20), RECTFIX_WIDTH(7), RECTFIX_HEIGHT(15));
    //父标签
    self.parentLabel.text = model.prime_label_name;
    CGSize parentsize = [self.parentLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:12.0f],NSFontAttributeName, nil]];
    self.parentLabel.frame = CGRectMake(CGRectGetMinX(self.arrowIV.frame)-parentsize.width-RECTFIX_WIDTH(10),RECTFIX_HEIGHT(20), parentsize.width+RECTFIX_WIDTH(10),RECTFIX_HEIGHT(15));
    self.parentLabel.textAlignment = NSTextAlignmentCenter;
    self.parentLabel.font =[UIFont systemFontOfSize:12];
    self.parentLabel.textColor = [UIColor whiteColor];
    
    //昵称
    self.nicknameLabel.text = model.nickname;
    
    //内容
    self.contentLabel.text = model.descrip;
    
    //价格
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.cost_amount];
    CGSize priceSize = [self.priceLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:18.0f],NSFontAttributeName, nil]];
//    self.priceLabel.frame = CGRectMake(CGRectGetMaxX(self.typeIV.frame)+RECTFIX_WIDTH(15), CGRectGetMaxY(self.contentLabel.frame) + RECTFIX_HEIGHT(16), priceSize.width+RECTFIX_WIDTH(10), RECTFIX_HEIGHT(20));
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.typeIV.mas_right).with.offset(RECTFIX_WIDTH(15));
        make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom).with.offset(RECTFIX_HEIGHT(16));
        make.size.mas_equalTo(CGSizeMake(priceSize.width+RECTFIX_WIDTH(10), RECTFIX_HEIGHT(20)));
    }];
    
    //距离
    float dis = model.dis.floatValue;
    NSLog(@"~~~~~dis = %.2f",dis);
    self.disLabel.text = [NSString stringWithFormat:@"%.2fm",model.dis.floatValue];
    self.disLabel.textAlignment = NSTextAlignmentRight;

    if (model.headImgUrl && ![model.headImgUrl isEqualToString:@""]) {
        [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.headImgUrl]];
    }
    
    
    
}



@end
