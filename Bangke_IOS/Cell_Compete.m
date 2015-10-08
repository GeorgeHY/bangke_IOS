//
//  Cell_Compete.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_Compete.h"
#import "CWStarRateView.h"

@interface Cell_Compete()

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UIView *StarView;
@property (strong, nonatomic) CWStarRateView *starRateView;
@property (weak, nonatomic) IBOutlet UIImageView *isShopIV;
@property (nonatomic, strong) UILabel * label1;//出价label
@property (nonatomic, strong) UILabel * priceLabel;


@end

@implementation Cell_Compete

- (void)awakeFromNib {
    
    self.headIV.userInteractionEnabled = YES;
    
    self.starRateView = [[CWStarRateView alloc]initWithFrame:CGRectMake(0, 0, RECTFIX_WIDTH(100), self.StarView.frame.size.height) numberOfStars:5];
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    self.starRateView.userInteractionEnabled = NO;
    [self.StarView addSubview:self.starRateView];
    self.isShopIV.hidden = YES;
    
    //出价
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.center.y - RECTFIX_HEIGHT(5), 40, 17)];
    [self.contentView addSubview:self.label1];
    self.label1.text = @"出价";
    self.label1.textAlignment = NSTextAlignmentCenter;
    self.label1.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    self.label1.textColor = [UIColor colorWithHexString:@"333333"];
    //竞价
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
    self.label1.textColor = [UIColor colorWithHexString:@"FA9924"];
    [self.contentView addSubview:self.priceLabel];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(Model_InviteUser *)model
{
    _model = model;
    self.nickNameLabel.text = model.nickname;
    if (model.service_name && ![model.service_name isEqualToString:@""]) {
        self.serviceNameLabel.text = model.service_name;
    }else{
        self.serviceNameLabel.text = @"该用户还没有介绍";
    }
    
    if (model.head_portrait) {
        [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.head_portrait]];
    }
    self.starRateView.scorePercent = model.star.integerValue *0.2;
    self.priceLabel.text = model.submit_cost;
    
    CGSize priceSize = [self.priceLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:18.0f],NSFontAttributeName, nil]];
    self.priceLabel.frame = CGRectMake(SCREEN_WIDTH - RECTFIX_WIDTH(15) - priceSize.width,self.center.y+RECTFIX_HEIGHT(5) , priceSize.width+10, 20);
    self.label1.center = CGPointMake(self.priceLabel.center.x, self.contentView.center.y - RECTFIX_HEIGHT(12));
    
}

@end
