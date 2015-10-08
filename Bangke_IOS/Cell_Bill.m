//
//  Cell_Bill.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_Bill.h"

@interface Cell_Bill()
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeLabel;



@end

@implementation Cell_Bill

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self updateUI];
    }
    return self;
}

- (void)updateUI
{
    WEAK_SELF(weakSelf);
    UILabel * line = [[UILabel alloc]init];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(80);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).with.offset(0);
        make.height.equalTo(@(1));
        
    }];
    line.backgroundColor = [UIColor colorWithHexString:@"CBCBCB"];
}

-(void)layoutSubviews
{
    self.headIV.layer.masksToBounds = YES;
    self.headIV.layer.cornerRadius =  30;
    
}

-(void)setModel:(Model_Bill *)model
{
    _model = model;
    NSArray * desSub = [model.descrip componentsSeparatedByString:@"："];
    
    self.titleLabel.text = [desSub firstObject];
    
    self.timeLabel.text = model.create_time;
    self.balanceLabel.text = [NSString stringWithFormat:@"%@ 余额:%@",[desSub lastObject],model.service_money];
    if (model.inOrOut.integerValue == 1) {
        self.tradeLabel.text = [NSString stringWithFormat:@"+%@",model.money];
    }else{
        self.tradeLabel.text = [NSString stringWithFormat:@"-%@",model.money];
    }
//    [self.tradeLabel showPlaceHolderWithLineColor:[UIColor blackColor]];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
