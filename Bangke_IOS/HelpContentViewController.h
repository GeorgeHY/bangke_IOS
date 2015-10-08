//
//  HelpContentViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/15.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_ContentCallBack.h"
typedef void (^CallBackContentModel) (Model_ContentCallBack * model);
@interface HelpContentViewController : UIViewController


@property (nonatomic, strong) Model_ContentCallBack * currentModel;
@property (nonatomic, copy) CallBackContentModel decideContent;

- (void)returnContentModel:(CallBackContentModel)model;

@end
