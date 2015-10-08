//
//  Model_TypeCallBack.h
//  Bangke_IOS
//
//  Created by iwind on 15/6/22.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_TypeCallBack : NSObject

@property (nonatomic, assign) NSInteger type;//1-竞单2-邀单3-抢单
@property (nonatomic, strong) NSMutableArray * peopleArr;
@end
