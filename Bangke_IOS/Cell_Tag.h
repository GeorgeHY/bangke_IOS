//
//  Cell_Tag.h
//  Bangke_IOS
//
//  Created by 韩扬 on 15/4/27.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_SelectTag.h"
@interface Cell_Tag : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *SelectImage;
@property (strong,nonatomic) Model_SelectTag * model;



@end
