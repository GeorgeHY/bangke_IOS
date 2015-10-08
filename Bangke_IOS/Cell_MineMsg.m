//
//  Cell_MineMsg.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/5/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_MineMsg.h"
#import "UIImageView+WebCache.h"
@interface Cell_MineMsg()

@property (nonatomic, strong) UIImageView * msgIV;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITextView * stateTV;
@property (nonatomic, strong) UILabel * timeLabel;

@end

@implementation Cell_MineMsg

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
    WEAK_SELF(weakSelf);
    //图片
    self.msgIV = [UIImageView new];
    [self.contentView addSubview:self.msgIV];
//    [self.msgIV showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.msgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(20);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(5);
        make.width.equalTo(@100);
    }];
    self.msgIV.backgroundColor = [UIColor redColor];
    self.msgIV.image = [UIImage imageNamed:@"img-200-146"];
    //题目
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];
//        [self.titleLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.msgIV.mas_right).with.offset(20);
            make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(20);
            make.height.equalTo(@30);
            make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-60);
        }];
    //说明
        self.stateTV = [UITextView new];
        [self.contentView addSubview:self.stateTV];
//        [self.stateTV showPlaceHolderWithLineColor:[UIColor blackColor]];
        [self.stateTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.msgIV.mas_right).with.offset(20);
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(10);
            make.height.equalTo(@35);
            make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-60);
        }];
    self.stateTV.editable = NO;
    self.stateTV.userInteractionEnabled = NO;
    //时间

    self.timeLabel = [UILabel new];
    [self.contentView addSubview:self.timeLabel];
//    [self.timeLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).with.offset(20);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(20);
        make.height.equalTo(@15);
        make.width.equalTo(@40);
    }];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    

//    
}
-(void)setModel:(Model_Msg *)model {
    _model = model;
    if (model.imgUrl != nil) {
        [self.msgIV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    }
    
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.stateTV.text = model.stateMsg;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
