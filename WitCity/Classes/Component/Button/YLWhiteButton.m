//
//  YLWhiteButton.m
//  HYB
//
//  Created by simpletour on 16/3/28.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLWhiteButton.h"

@implementation YLWhiteButton

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame title:title];
    if (self) {
        self.normalColor = 0xffffff;
        self.pressColor = 0xffffff;
        self.disabledColor = 0xef0f0f0;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor colorWithHex:0xfd6001].CGColor;
        self.layer.borderWidth = 1.0f;
        [self setTitleColor:[UIColor colorWithHex:0xfd6001]forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHex:0xfd6001]forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor colorWithHex:0x999a9b] forState:UIControlStateDisabled];
        [self initialization];
    }
    return self;
}

@end
