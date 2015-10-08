//
//  Cell_HeadPhoto.m
//  Bangke_IOS
//
//  Created by iwind on 15/7/2.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_HeadPhoto.h"

@implementation Cell_HeadPhoto
@synthesize headIV = _headIV;
-(UIImageView *)headIV
{
    if (!_headIV) {
        _headIV = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _headIV.image = [UIImage imageNamed:@"个人信息-添加_03"];
    }
    
    
    return _headIV;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.headIV];
    }
    return self;
}

@end
