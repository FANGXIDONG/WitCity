//
//  UIColor+YL.m
//  STMSimpletourApp
//
//  Created by simpletour on 15/12/10.
//  Copyright © 2015年 simpletour. All rights reserved.
//

#import "UIColor+YL.h"

@implementation UIColor (YL)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*) colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

@end
