//
//  UIButton+RoundBtn.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/17.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (RoundBtn)
/**
 
 快速创建一个圆形btn
 @para frame 坐标
 @para image 普通的image
 @para selectedImage 选中状态下的image
 */
+(instancetype)btnWithFrame:(CGRect)frame image:(UIImage *)image
              selectedImage:(UIImage *)selectedImage;
@end
