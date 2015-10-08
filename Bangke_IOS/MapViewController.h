//
//  MapViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/6.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentLocation.h"
typedef void (^Callback) (CurrentLocation *currentAddress);

@interface MapViewController : UIViewController

@property (nonatomic, copy) Callback currentAddress;

-(void)returnAddress:(Callback)address;

@end
