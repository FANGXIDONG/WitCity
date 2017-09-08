//
//  XHBaseTextView.m
//  xiaoher
//
//  Created by duyulong on 9/3/15.
//  Copyright (c) 2015 wenjin. All rights reserved.
//

#import "YLTextView.h"
#import "UIColor+YL.h"



@interface YLTextView()<UITextViewDelegate>

@end

@implementation YLTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        self.delegate = self;
    }
    return self;
}

- (void)addViews
{
    [self addLblPlaceholder];
}

- (void)addLblPlaceholder 
{
    _lblPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(3, -6, WINDOW_WIDTH - 10, 45)];
    _lblPlaceholder.font = self.font;
    _lblPlaceholder.textColor = [UIColor colorWithHex:0x999999];
    _lblPlaceholder.numberOfLines = 0;
    [self addSubview:self.lblPlaceholder];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _lblPlaceholder.text = placeholder;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self processPlaceholderWithRange:range text:text];
    return YES;
}

- (void)processPlaceholderWithRange:(NSRange)range text:(NSString *)text
{
    if (![text isEqualToString:@""]) {
        _lblPlaceholder.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _lblPlaceholder.hidden = NO;
    }
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    if(self.text.length > 0) {
        _lblPlaceholder.hidden = YES;
    }
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    _lblPlaceholder.font = font;
}

@end
