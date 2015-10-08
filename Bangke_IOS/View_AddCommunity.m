//
//  View_AddCommunity.m
//  Bangke_IOS
//
//  Created by iwind on 15/5/5.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "View_AddCommunity.h"

@interface View_AddCommunity()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;


@end

@implementation View_AddCommunity



+ (View_AddCommunity *)initCustomView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"View_AddCommunity" owner:nil options:nil];     return [nibView objectAtIndex:0];
}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder:(CGRect)frame
//{
//    if(self = [super initWithCoder:aDecoder]) {
//        
//
////        [self updateUI];
//    }
//    
//    return self;
//}

//- (void) updateUI
//{
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame), self.frame.size.width/2, 50)];
//    btn.backgroundColor = [UIColor redColor];
//    [self addSubview:btn];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cancelAction:(UIButton *)sender {
    [self.superview removeFromSuperview];
}

@end
