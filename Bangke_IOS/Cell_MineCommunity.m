//
//  Cell_MineCommunity.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/5.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_MineCommunity.h"

@interface Cell_MineCommunity()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isDefaultIV;


@end


@implementation Cell_MineCommunity

- (void)awakeFromNib {
    // Initialization code
}




-(void)setModel:(Model_Community *)model {
    _model = model;
    self.nameLabel.text = model.lbs_address;
    self.contactLabel.text = model.contact_name;
    self.phoneLabel.text= model.phone;
    self.addressLabel.text = model.receive_address;
    if (model.default_select.integerValue == 1) {
        self.isDefaultIV.hidden = YES;
    }else{
        self.isDefaultIV.hidden = NO;
    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
