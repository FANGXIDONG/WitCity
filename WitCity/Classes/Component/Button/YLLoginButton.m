//
//  YLLoginButton.m
//  WitCity
//
//  Created by simpletour on 16/5/30.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLLoginButton.h"

@implementation YLLoginButton

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame title:title];
    if (self) {
        self.normalColor = 0xffffff;
        self.pressColor = 0xffffff;
        self.disabledColor = 0xef0f0f0;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithHex:0x0a0a0a].CGColor;
        [self setTitleColor:[UIColor colorWithHex:0x0a0a0a] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHex:0x999a9b] forState:UIControlStateDisabled];
        [self initialization];
    }
    return self;
}

@end
