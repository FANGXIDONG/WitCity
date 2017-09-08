//
//  UILabel+YLPadding.m
//  WitCity
//
//  Created by simpletour on 16/5/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "UILabel+YLPadding.h"
#import "YLHook.h"
#import <objc/runtime.h>

static const void *insetsKey = &insetsKey;

@implementation UILabel (YLPadding)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(intrinsicContentSize);
        SEL swizzledSelector = @selector(yl_intrinsicContentSize);
        [YLHook hookWithClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

-(void)setEdgeInsets:(UIEdgeInsets)insets
{
    self.insets = insets;
    [self setNeedsLayout];
}

- (UIEdgeInsets)insets {
    return [objc_getAssociatedObject(self, insetsKey) UIEdgeInsetsValue];
}

- (void)setInsets:(UIEdgeInsets)insets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:insets];
    objc_setAssociatedObject(self, insetsKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)drawRect:(CGRect)rect
{
    [self drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

-(CGSize)yl_intrinsicContentSize
{
    CGSize size = [self yl_intrinsicContentSize];
    size.width += self.insets.left + self.insets.right;
    size.height += self.insets.top + self.insets.bottom;
    return size;
}

@end
