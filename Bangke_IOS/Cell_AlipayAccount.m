//
//  Cell_AlipayAccount.m
//  Bangke_IOS
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_AlipayAccount.h"

@interface Cell_AlipayAccount()

@property (nonatomic, strong) UILabel * accountLabel;
@property (nonatomic, strong) UILabel * nickLabel;

@end

@implementation Cell_AlipayAccount

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self updateUI];
    }
    return self;
    
}

-(void)updateUI
{
    NSLog(@"%f",SCREEN_WIDTH);
    NSLog(@"%f",SCREEN_HEIGHT);
    WEAK_SELF(weakSelf);
    UIImageView * aliIV = [UIImageView new];
    [self.contentView addSubview:aliIV];
    [aliIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(RECTFIX_WIDTH(15));
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(RECTFIX_WIDTH(74), RECTFIX_HEIGHT(24)));
    }];
    aliIV.image = [UIImage imageNamed:@"im_zhifubaologo_2x"];
    
    self.nickLabel = [UILabel new];
    [self.contentView addSubview:self.nickLabel];
//    [self.nickLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(aliIV.mas_right).with.offset(RECTFIX_WIDTH(25));
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-RECTFIX_WIDTH(15));
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(RECTFIX_HEIGHT(15));
        make.height.equalTo(@(RECTFIX_HEIGHT(16)));
    }];
    self.nickLabel.text = @"支付宝";
    self.nickLabel.font = [UIFont systemFontOfSize:14];
    self.nickLabel.textAlignment = NSTextAlignmentLeft;
    
//    UILabel * titleLabel = [UILabel new];
//    [self.contentView addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(0);
//        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(0);
//        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(0);
//        make.height.equalTo(@(RECTFIX_HEIGHT(20)));
//        
//    }];
//    titleLabel.text = @"支付宝";
//    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.accountLabel = [UILabel new];
    [self.contentView addSubview:self.accountLabel];
//    [self.accountLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(aliIV.mas_right).with.offset(RECTFIX_WIDTH(25));
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-RECTFIX_WIDTH(15));
        make.top.mas_equalTo(weakSelf.nickLabel.mas_bottom).with.offset(RECTFIX_WIDTH(11));
        make.height.equalTo(@(RECTFIX_HEIGHT(12)));
    }];
    self.accountLabel.text = @"支付宝";
    self.accountLabel.font = [UIFont systemFontOfSize:10];
    self.accountLabel.textAlignment = NSTextAlignmentLeft;

    
    

    
    
    
}

-(void)setModel:(Model_UserAlipay *)model
{
    _model = model;
    self.accountLabel.text = model.alipay_account;
    self.nickLabel.text = model.alipay_username;
}

@end
