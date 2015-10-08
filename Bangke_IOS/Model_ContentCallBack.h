//
//  Model_ContentCallBack.h
//  Bangke_IOS
//
//  Created by iwind on 15/6/22.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_ContentCallBack : NSObject

@property (nonatomic, strong) NSString * helpContent;//内容
@property (nonatomic, assign) BOOL isOrder;//是否预约 1-未预约2-预约
@property (nonatomic, strong) NSString * startTime;//起始时间
@property (nonatomic, strong) NSString * overTime;//结束时间
@property (nonatomic, strong) NSString * images;//图片key


@end
