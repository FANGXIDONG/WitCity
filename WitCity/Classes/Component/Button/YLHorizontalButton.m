//
//  YLHorizontalButton.m
//  WitCity
//
//  Created by simpletour on 16/5/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLHorizontalButton.h"
#import "YLMacro.h"

@interface YLHorizontalButton ()

@end

@implementation YLHorizontalButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self horizontalStyle];
    }
    return self;
}

- (void)horizontalStyle
{
    self.contentMode = UIViewContentModeCenter;
    [self setTitleColor:kYLColorFontGray forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(3, 15, 0, 0);
}

@end
