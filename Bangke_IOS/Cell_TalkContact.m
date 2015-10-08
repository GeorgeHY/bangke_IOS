//
//  Cell_TalkContact.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_TalkContact.h"

@interface Cell_TalkContact()
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation Cell_TalkContact

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self updateUI];
    }
    return self;
}
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self updateUI];
//    }
//    return self;
//}

-(void)updateUI
{
//    self.headIV.layer.masksToBounds = YES;
//    self.headIV.layer.cornerRadius =  60;
}

-(void)layoutSubviews
{
    self.headIV.layer.masksToBounds = YES;
    self.headIV.layer.cornerRadius = 31;
}

- (void)setModel:(Model_TalkContact *)model
{
    _model = model;
    //头像
    
    self.nameLabel.text = model.name;
    self.timeLabel.text = model.time;
    self.contentLabel.text = model.content;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
