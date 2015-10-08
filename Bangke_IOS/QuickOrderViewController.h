//
//  QuickOrderViewController.h
//  Bangke_IOS
//
//  Created by iwind on 15/6/23.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickOrderViewController : UIViewController

@property (nonatomic, strong) NSString * currentToken;
@property (nonatomic, strong) NSString * serviceID;
@property (nonatomic, assign) NSInteger source;//1-求帮2-去帮
@end
