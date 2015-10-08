//
//  Cell_CreateList.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/11.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_CreateList.h"

@interface Cell_CreateList()

@property (nonatomic, strong) UIImageView * iconIV;

@property (nonatomic, strong) UILabel * contentLbl;



@end

@implementation Cell_CreateList
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
    self.iconIV = [UIImageView new];
    [self.contentView addSubview:self.iconIV];
//    [self.iconIV showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(20);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
//    self.iconIV.backgroundColor = [UIColor redColor];
    //rightArrow
    self.arrowIV = [UIImageView new];
    [self.contentView addSubview:self.arrowIV];
    [self.arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-20);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(7, 15));
        
    }];
    self.arrowIV.image = [UIImage imageNamed:@"图层 4 副本 2"];
//    self.arrowIV.backgroundColor = [UIColor blueColor];
    
    
    //contentview
    self.contentArea = [UIView new];
    [self.contentView addSubview:self.contentArea];
//    [self.contentArea showPlaceHolderWithLineColor:[UIColor blackColor]];
    [self.contentArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconIV.mas_right).with.offset(20);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.right.mas_equalTo(weakSelf.arrowIV.mas_left).with.offset(8);
        make.height.equalTo(@20);
    }];
//    self.contentArea.backgroundColor =[UIColor yellowColor];
    
    self.contentLbl = [UILabel new];
    [self.contentArea addSubview:self.contentLbl];
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentArea).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    self.contentLbl.textColor = [UIColor lightGrayColor];
    
//    self.contentLbl.backgroundColor = [UIColor lightGrayColor];
//    [self.contentLbl showPlaceHolderWithLineColor:[UIColor blackColor]];
    
}

-(void)setModel:(Model_CreateList *)model
{
    _model = model;
    
    self.iconIV.image = [UIImage imageNamed:model.iconName];
    
    
    if ([model.flag isEqualToString:@"0"]) {
        self.contentLbl.text = model.content;
    }else{
        self.contentLbl.hidden = YES;
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
