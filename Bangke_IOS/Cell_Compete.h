//
//  Cell_Compete.h
//  Bangke_IOS
//
//  Created by iwind on 15/5/7.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_InviteUser.h"
@interface Cell_Compete : UITableViewCell

@property (nonatomic, strong) Model_InviteUser * model;
//@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@end
