//
//  ReviewViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/11.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ReviewType){
    ReviewTypeSendHelp = 1,//求帮
    ReviewTypeHelpTo//去帮
} ;


@interface ReviewViewController : UIViewController

@property (nonatomic) ReviewType reviewType;

@end
