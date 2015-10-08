//
//  Cell_PersonInfo.m
//  Bangke_IOS
//
//  Created by iwind on 15/4/28.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_PersonInfo.h"

@implementation Cell_PersonInfo

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
    //标题
    self.headLalel = [UILabel new];
    [self.contentView addSubview:self.headLalel];
//    [self.headLalel showPlaceHolder];
    [self.headLalel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(20);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.height.equalTo(weakSelf.contentView.mas_height);
        make.width.equalTo(@100);
    }];
//    self.headLalel.backgroundColor = [UIColor redColor];
    
    //信息
    
    self.contentLabel = [UILabel new];
    [self.contentView addSubview:self.contentLabel];
//    [self.contentLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headLalel.mas_right).with.offset(20);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.height.equalTo(weakSelf.contentView.mas_height);
        make.width.equalTo(@(kMainScreenWidth * 0.4));
    }];
//    self.contentLabel.backgroundColor = [UIColor greenColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
