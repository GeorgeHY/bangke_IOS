//
//  Cell_CreateList.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/11.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_CreateList.h"
@interface Cell_CreateList : UITableViewCell

@property (nonatomic, strong) Model_CreateList * model;
@property (nonatomic, strong) UIView * contentArea;
@property (nonatomic, strong) UIImageView * arrowIV;
@end
