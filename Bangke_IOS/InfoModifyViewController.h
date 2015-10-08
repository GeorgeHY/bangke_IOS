//
//  InfoModifyViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/25.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_User.h"

@interface InfoModifyViewController : UIViewController
@property (nonatomic, strong) NSString * currentKey;
@property (nonatomic, strong) NSString * currentModifyInfo;
@property (nonatomic, strong) Model_User * currentInfo;
@end
