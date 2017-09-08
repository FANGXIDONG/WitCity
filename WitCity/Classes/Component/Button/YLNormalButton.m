//
//  XHNormalButton.m
//  style_ios
//
//  Created by duyulong on 9/23/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLNormalButton.h"

@implementation YLNormalButton

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame title:title];
    if (self) {
        self.normalColor = 0xfd6001;
        self.pressColor = 0xfd6001;
        self.disabledColor = 0xef0f0f0;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHex:0x999a9b] forState:UIControlStateDisabled];
        [self initialization];
    }
    return self;
}

@end
