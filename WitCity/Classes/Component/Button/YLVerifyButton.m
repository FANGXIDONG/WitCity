//
//  XHVerifyButton.m
//  style_ios
//
//  Created by duyulong on 9/23/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLVerifyButton.h"

@implementation YLVerifyButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

//        self.normalColor = 0xfd6001;
//        self.pressColor = 0xfd6001;
        self.normalColor = 0xffffff;
        self.pressColor = 0xffffff;
        self.disabledColor = 0xffffff;
        [self initialization];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor colorWithHex:0x0a0a0a].CGColor;
        self.layer.borderWidth = 1.0f;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHex:0x0a0a0a]forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHex:0x0a0a0a]forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor colorWithHex:0x999a9b] forState:UIControlStateDisabled];
//        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}



@end
