//
//  Cell_Review.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/11.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_Review.h"

@interface Cell_Review()
@property (nonatomic, strong) UIImageView * headIV;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIImageView * stateIV;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * timeLabel;

@end

@implementation Cell_Review

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
    //头像
    self.headIV = [UIImageView new];
    [self.contentView addSubview:self.headIV];
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(15);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.headIV showPlaceHolderWithLineColor:[UIColor blackColor]];
    self.headIV.backgroundColor = [UIColor redColor];
    //好评状态
    self.stateIV = [UIImageView new];
    [self.contentView addSubview:self.stateIV];
    [self.stateIV showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.stateIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-20);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(14, 14));
        
    }];
    self.stateIV.backgroundColor = [UIColor blueColor];
    
    //昵称
    self.nameLabel = [UILabel new];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headIV.mas_right).with.offset(10);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(15);
        make.right.mas_equalTo(weakSelf.stateIV.mas_left).with.offset(-10);
        make.height.equalTo(@20);
        
        
    }];
    self.nameLabel.backgroundColor = [UIColor lightGrayColor];
    //contentLabel
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, kMainScreenWidth-30, 20)];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.backgroundColor = [UIColor purpleColor];
    //时间
    self.timeLabel = [UILabel new];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(15);
        make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom).with.offset(15);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@20);
    }];
    self.timeLabel.backgroundColor = [UIColor greenColor];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
