//
//  Model_PayCallBack.h
//  Bangke_IOS
//
//  Created by iwind on 15/6/22.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_PayCallBack : NSObject

@property (nonatomic, strong) NSString * price;
@property (nonatomic, assign) NSInteger payType;//1-货到付款,2-保证金支付

@end
