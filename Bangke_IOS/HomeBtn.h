//
//  HomeBtn.h
//  Bangke_IOS
//
//  Created by admin on 15/9/22.
//  Copyright © 2015年 iwind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBtn : UIButton

@property (nonatomic, assign) BOOL isTaped;
@property (nonatomic, strong) UILabel * bottomLine;
@property (nonatomic, strong) UILabel * titleLbl;
@property (nonatomic, strong) UIImageView * arrowIV;

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;

@end
