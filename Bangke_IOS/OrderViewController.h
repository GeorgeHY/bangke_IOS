//
//  OrderViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/8.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PushSource) {
    PushSourceSendOrder = 1,//发单
    PushSourceReceiveOrder//接单
};

@interface OrderViewController : UIViewController

@property (nonatomic) PushSource source;
@property (nonatomic, strong) NSString * currentLabelID;
@property (nonatomic, strong) NSString * currentPtype;


+ (OrderViewController *)sharedInstance;

- (void)refreshTVData;

@end
