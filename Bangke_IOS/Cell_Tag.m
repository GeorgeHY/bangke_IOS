//
//  Cell_Tag.m
//  Bangke_IOS
//
//  Created by 韩扬 on 15/4/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_Tag.h"
#import "UIImageView+WebCache.h"
@interface Cell_Tag()
@property (weak, nonatomic) IBOutlet UIImageView *tagImage;
@property (weak, nonatomic) IBOutlet UILabel *tagName;
@property (nonatomic, strong) UIImageView * tagIV;
@property (nonatomic, strong) UILabel * tagLabel;

@end

@implementation Cell_Tag

-(UIImageView *)tagIV
{
    if (!_tagIV) {
        _tagIV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, self.contentView.frame.size.width-10, self.contentView.frame.size.width-10)];
        _tagIV.layer.masksToBounds = YES;
        _tagIV.layer.cornerRadius = (self.contentView.frame.size.width-10)/2;
        _tagIV.backgroundColor = [UIColor greenColor];
    }
    return _tagIV;
}

-(UILabel *)tagLabel
{
    if (!_tagLabel) {
        CGSize size = self.contentView.frame.size;
        _tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tagIV.frame) + 10 , size.width, 30)];
        _tagLabel.backgroundColor = [UIColor whiteColor];
        _tagLabel.text = @"呵呵";
        _tagLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tagLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.tagIV];
        [self.contentView addSubview:self.tagLabel];
    }
    return self;
}





-(void)setModel:(Model_SelectTag *)model {
    _model = model;
    if (_model.imgUrl != nil) {
        [self.tagImage sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    }
    
    self.tagName.text = _model.name;
}

@end
