//
//  SelectHelpPeopleViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_UserAbbr.h"
#import "Model_TypeCallBack.h"

typedef void(^CallBackTypeModel) (Model_TypeCallBack * model) ;

@interface SelectHelpPeopleViewController : UIViewController
@property (nonatomic, copy) CallBackTypeModel decideType;

- (void)returnTypeModel:(CallBackTypeModel)model;


@end
