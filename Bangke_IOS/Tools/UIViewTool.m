//
//  UIViewTool.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/9.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "UIViewTool.h"
//#import <>
@implementation UIViewTool
/**
 
 */
+(void)cancelKeyBoard:(UIView *)view
{
    for (UIView * v in view.subviews) {
        
        if ([v isKindOfClass:[UISearchBar class]] || [v isKindOfClass:[UITextField class]]) {
            [v resignFirstResponder];
        }else{
            [self cancelKeyBoard:v];
        }
    }
}

@end
