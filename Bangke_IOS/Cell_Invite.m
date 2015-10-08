//
//  Cell_Invite.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_Invite.h"

@interface Cell_Invite()
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userType;



@end

@implementation Cell_Invite

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(Model_InviteUser *)model
{
    _model = model;
    self.nickNameLabel.text = model.nickname;
    self.serviceNameLabel.text = model.service_name;
    if (model.head_portrait) {
        [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.head_portrait]];
    }
    if (model.type.integerValue != 3) {
        self.userType.hidden = YES;
    }else{
        self.userType.hidden = NO;
    }
    //距离暂时不显示
    self.distanceLabel.hidden = YES;
}

@end
