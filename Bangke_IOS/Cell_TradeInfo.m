//
//  Cell_TradeInfo.m
//  Bangke_IOS
//
//  Created by iwind on 15/4/28.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_TradeInfo.h"

@interface Cell_TradeInfo()

@property (nonatomic, strong) UILabel * hoCount;//帮助交易量
@property (nonatomic, strong) UILabel * hoGood;//帮助好评数
@property (nonatomic, strong) UILabel * hiCount;//求帮交易量
@property (nonatomic, strong) UILabel * hiGood;//求帮好评数

@end


@implementation Cell_TradeInfo

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
//    self.contentView.backgroundColor = [UIColor redColor];
    WEAK_SELF(weakSelf);
    //帮助等级
    UILabel * lbl1 = [UILabel new];
//    [lbl1 showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:lbl1];
    [lbl1 showPlaceHolder];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(10);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    lbl1.text = @"帮助等级";
    lbl1.textColor = [UIColor blackColor];
    lbl1.textAlignment = NSTextAlignmentLeft;
    //求帮等级
    UILabel * lbl2 = [UILabel new];
//    [lbl2 showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:lbl2];
    [lbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(kMainScreenWidth/2 +10);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    lbl2.text = @"求帮等级";
    lbl2.textColor = [UIColor blackColor];
    lbl2.textAlignment = NSTextAlignmentLeft;
    //帮助交易量
    UILabel * lbl3 = [UILabel new];
//    [lbl3 showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:lbl3];
    [lbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(35);
        make.top.mas_equalTo(lbl1.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.width.equalTo(@45);
    }];
    lbl3.text = @"交易量";
    lbl3.font = [UIFont systemFontOfSize:14];
    lbl3.textColor = [UIColor blackColor];
    lbl3.textAlignment = NSTextAlignmentLeft;
    //帮助交易量数据
    self.hoCount = [UILabel new];
//    [self.hoCount showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:self.hoCount];
    [self.hoCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(35);
        make.top.mas_equalTo(lbl3.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.width.equalTo(@45);
    }];
    self.hoCount.text = @"30单";
    self.hoCount.font = [UIFont systemFontOfSize:14];
    self.hoCount.textColor = [UIColor orangeColor];
    self.hoCount.textAlignment = NSTextAlignmentCenter;
    
    //帮助好评数
    UILabel * lbl4 = [UILabel new];
//    [lbl4 showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:lbl4];
    [lbl4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbl3.mas_right).with.offset(20);
        make.top.mas_equalTo(lbl1.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.width.equalTo(@45);
    }];
    lbl4.text = @"好评数";
    lbl4.font = [UIFont systemFontOfSize:14];
    lbl4.textColor = [UIColor blackColor];
    lbl4.textAlignment = NSTextAlignmentLeft;
    //帮助好评数数据
    self.hoGood = [UILabel new];
//    [self.hoGood showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:self.hoGood];
    [self.hoGood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.hoCount.mas_right).with.offset(20);
        make.top.mas_equalTo(lbl4.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.width.equalTo(@45);
    }];
    self.hoGood.text = @"25个";
    self.hoGood.font = [UIFont systemFontOfSize:14];
    self.hoGood.textColor = [UIColor orangeColor];
    self.hoGood.textAlignment = NSTextAlignmentCenter;
    
    
    
    //求帮
    
    //帮助交易量
    UILabel * lbl5 = [UILabel new];
//    [lbl5 showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:lbl5];
    [lbl5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(kMainScreenWidth/2 + 35);
        make.top.mas_equalTo(lbl2.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.width.equalTo(@45);
    }];
    lbl5.text = @"交易量";
    lbl5.font = [UIFont systemFontOfSize:14];
    lbl5.textColor = [UIColor blackColor];
    lbl5.textAlignment = NSTextAlignmentLeft;
    //帮助交易量数据
    self.hiCount = [UILabel new];
//    [self.hiCount showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:self.hiCount];
    [self.hiCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(kMainScreenWidth/2 + 35);
        make.top.mas_equalTo(lbl5.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.width.equalTo(@45);
    }];
//    self.hiCount.text = @"30单";
    self.hiCount.font = [UIFont systemFontOfSize:14];
    self.hiCount.textColor = [UIColor orangeColor];
    self.hiCount.textAlignment = NSTextAlignmentCenter;
    
    //帮助好评数
    UILabel * lbl6 = [UILabel new];
//    [lbl6 showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:lbl6];
    [lbl6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbl5.mas_right).with.offset(20);
        make.top.mas_equalTo(lbl2.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.width.equalTo(@45);
    }];
    lbl6.text = @"好评数";
    lbl6.font = [UIFont systemFontOfSize:14];
    lbl6.textColor = [UIColor blackColor];
    lbl6.textAlignment = NSTextAlignmentLeft;
    //帮助好评数数据
    self.hiGood = [UILabel new];
//    [self.hiGood showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.contentView addSubview:self.hiGood];
    [self.hiGood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.hiCount.mas_right).with.offset(20);
        make.top.mas_equalTo(lbl6.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
        make.width.equalTo(@45);
    }];
//    self.hiGood.text = @"25个";
    self.hiGood.font = [UIFont systemFontOfSize:14];
    self.hiGood.textColor = [UIColor orangeColor];
    self.hiGood.textAlignment = NSTextAlignmentCenter;
    
    
}

-(void)setModel:(Model_TradeInfo *)model {
    _model = model;
    self.hoCount.text = model.helpOutCount;
    self.hoGood.text = model.helpOutStar;
    self.hiCount.text = model.helpInCount;
    self.hiGood.text = model.helpInStar;
}

@end
