//
//  HomeBtn.m
//  Bangke_IOS
//
//  Created by admin on 15/9/22.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import "HomeBtn.h"

@interface HomeBtn()




@end

@implementation HomeBtn


-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateUIwithTitle:title];
        
    }
    return self;
}

- (void)updateUIwithTitle:(NSString *)title
{
    WEAK_SELF(weakSelf);
    self.bottomLine = [UILabel new];
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).with.offset (0);
        make.right.mas_equalTo(weakSelf.mas_right).with.offset (0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).with.offset (0);
        make.height.equalTo(@(RECTFIX_HEIGHT(3)));
    }];
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:@"FA9924"];
    self.isTaped = NO;
    self.bottomLine.hidden = YES;
    
    self.titleLbl = [UILabel new];
    [self addSubview:self.titleLbl];
    self.titleLbl.text = title;
    self.titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLbl.textAlignment = NSTextAlignmentCenter;
    self.titleLbl.textColor = [UIColor colorWithHexString:@"333333"];
    UIFont *titleFnt = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    self.titleLbl.font = titleFnt;
    CGRect titleRect = [self.titleLbl.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/3, RECTFIX_HEIGHT(20)) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:titleFnt,NSFontAttributeName,nil] context:nil];
    //[self.titleLbl showPlaceHolderWithLineColor:[UIColor redColor]];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).with.offset(-RECTFIX_HEIGHT(3));
        make.centerX.mas_equalTo(weakSelf.mas_centerX).with.offset(-RECTFIX_WIDTH(10));
        make.width.equalTo(@(SCREEN_WIDTH/3 - RECTFIX_WIDTH(20)));
    }];
    
    
    
    
    
    self.arrowIV = [UIImageView new];
    [self addSubview:self.arrowIV];
    [self.arrowIV  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLbl.mas_right).with.offset(RECTFIX_WIDTH(2));
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(RECTFIX_WIDTH(7), RECTFIX_HEIGHT(3)));
    }];
    self.arrowIV.image = [UIImage imageNamed:@"bt-xialaxuankuanxuanzhong2x"];
    
    

    
}






@end
