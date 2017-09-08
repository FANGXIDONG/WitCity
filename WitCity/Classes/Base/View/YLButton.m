//
//  XHButton.m
//  xiaoher
//
//  Created by duyulong on 9/3/15.
//  Copyright (c) 2015 wenjin. All rights reserved.
//

#import "YLButton.h"


@interface YLButton()

@property (nonatomic, strong) UIImage *normailImage;
@property (nonatomic, strong) UIImage *pressImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIImage *disabledImage;

@end

@implementation YLButton

-(instancetype)initWithTitle:(NSString *)title
{
    return [self initWithFrame:CGRectZero title:title];
}

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if(self) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)initialization
{
    [self initForImage];
    [self backgroundForImage];
}

- (void)initForImage
{
    self.normailImage = [self imageWithColor:self.normalColor];
    self.pressImage = [self imageWithColor:self.pressColor];
    self.selectedImage = [self imageWithColor:self.selectedColor];
    self.disabledImage = [self imageWithColor:self.disabledColor];
}


- (void)backgroundForImage
{
    [self setBackgroundImage:self.normailImage forState:UIControlStateNormal];
    [self setBackgroundImage:self.pressImage forState:UIControlStateHighlighted];
    [self setBackgroundImage:self.selectedImage forState:UIControlStateSelected];
    [self setBackgroundImage:self.disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)imageWithColor:(NSInteger)color
{
    UIImage *image = [self imageWithColor:[UIColor colorWithHex:color] bounds:self.bounds];
    return image;
}

- (UIImage*)imageWithColor: (UIColor*)color bounds:(CGRect)bounds
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
