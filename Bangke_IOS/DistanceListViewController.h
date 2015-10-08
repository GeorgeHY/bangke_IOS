//
//  DistanceListViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/7/20.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBackDis) (NSString * distance);

@interface DistanceListViewController : UIViewController

@property (nonatomic, copy) CallBackDis currentDis;

- (void)returnDistance:(CallBackDis)distance;

@end
