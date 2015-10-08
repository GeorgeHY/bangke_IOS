//
//  Model_TradeInfo.h
//  Bangke_IOS
//
//  Created by iwind on 15/4/28.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_TradeInfo : NSObject
///帮助交易数
@property (nonatomic, copy) NSString * helpOutCount;
///帮助好评数
@property (nonatomic, copy) NSString * helpOutStar;
///求帮交易数
@property (nonatomic, copy) NSString * helpInCount;
///求帮好评数
@property (nonatomic, copy) NSString * helpInStar;


@end
