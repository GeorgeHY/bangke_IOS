//
//  Cell_ScreenTag.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/14.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "Cell_ScreenTag.h"

@interface Cell_ScreenTag()

@property (weak, nonatomic) IBOutlet UILabel *tagName;


@end

@implementation Cell_ScreenTag


-(void)setModel:(Model_ParentLabel *)model
{
    _model = model;
    self.tagName.text = model.name;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
