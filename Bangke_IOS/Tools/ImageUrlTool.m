//
//  ImageUrlTool.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/3/19.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import "ImageUrlTool.h"

@implementation ImageUrlTool
+(NSString *)absPathwithRelPath:(NSString *)relPath
{
    return [NSString stringWithFormat:@"%@%@", URL_BASE_IMAGE, relPath];
}
@end
