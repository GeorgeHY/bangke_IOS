//
//  QNUploadManagerTool.m
//  Bangke_IOS
//
//  Created by iwind on 15/7/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "QNUploadManagerTool.h"

@implementation QNUploadManagerTool

+(QNUploadManager *)sharedQNUploadManager
{
    static dispatch_once_t onceToken;
    static QNUploadManager * manager;
    dispatch_once(&onceToken, ^{
        manager = [[QNUploadManager alloc]init];
    });
    return manager;
}

@end
