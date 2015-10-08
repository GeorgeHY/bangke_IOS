//
//  Cell_SelectTag.m
//  Bangke_IOS
//
//  Created by admin on 15/8/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_SelectTag.h"

@interface Cell_SelectTag()

//@property (nonatomic, strong) UIImageView

@end

@implementation Cell_SelectTag

-(void)setModel:(Model_ParentLabel *)model
{
    _model = model;
    if (_model.imag_url && ![_model.imag_url isEqualToString:@""]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_model.imag_url]];
    }
    
    self.textLabel.text = _model.name;
    self.textLabel.textAlignment = NSTextAlignmentCenter;

    
}

@end
