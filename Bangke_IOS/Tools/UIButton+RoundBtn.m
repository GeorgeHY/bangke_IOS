//
//  UIButton+RoundBtn.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/17.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "UIButton+RoundBtn.h"

@implementation UIButton (RoundBtn)


+(instancetype)btnWithFrame:(CGRect)frame image:(UIImage *)image
              selectedImage:(UIImage *)selectedImage
{
    UIButton * btn = [[UIButton alloc]initWithFrame:frame];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = frame.size.height / 2.0;
    btn.layer.borderWidth = 1;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    return btn;
}

@end
