//
//  AssessmentViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_OrderDesc.h"
typedef NS_ENUM(NSInteger, ReviewType){
    ReviewTypeSendHelp = 1,//求帮
    ReviewTypeHelpTo//去帮
} ;
@interface AssessmentViewController : UIViewController

@property (nonatomic, strong)Model_OrderDesc * model;
@property (nonatomic) ReviewType reviewType;


@end
