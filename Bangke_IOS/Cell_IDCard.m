//
//  Cell_IDCard.m
//  Bangke_IOS
//
//  Created by iwind on 15/7/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_IDCard.h"

@implementation Cell_IDCard

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
    //iconIV
    self.cardIV = [UIImageView new];
    [self.contentView addSubview:self.cardIV];
    //    [self.iconIV showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.cardIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.cardIV.backgroundColor = [UIColor redColor];
    self.cardIV.image = [UIImage imageNamed:@"添加证件照.jpg"];
    
    
}

//-(void)setModel:(Model_CreateList *)model
//{
//    _model = model;
//    
//    self.iconIV.image = [UIImage imageNamed:model.iconName];
//    
//    
//    if ([model.flag isEqualToString:@"0"]) {
//        self.contentLbl.text = model.content;
//    }else{
//        self.contentLbl.hidden = YES;
//    }
//    
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
