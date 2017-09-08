//
//  YLSearchContentView.m
//  WitCity
//
//  Created by simpletour on 16/5/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLSearchContentView.h"

@interface YLSearchContentView ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation YLSearchContentView

-(void)addViews
{
    [self addSubview:self.lblTitle];
    [self addSubview:self.line];
}

-(void)layout
{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(20);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblTitle.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

-(void)useStyle
{
    self.backgroundColor = kYLColorBakcgorund;
    self.line.backgroundColor = kYLColorLine;
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblTitle.font = [UIFont systemFontOfSize:14];
    self.lblTitle.text = @"热门搜索";
}

- (void)layoutWithArray:(NSArray *)array
{
    UIButton *btnLast;
    NSInteger count = 0;
    __block CGFloat widthCount = 0.0f;
    for (NSInteger i=0, length=array.count; i<length; i++) {
        NSString *title = array[i];
        UIButton *button = [self buttonWithTitle:title];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        CGFloat width = [self adaptWidthWithText:title font:button.titleLabel.font] + 10;
        widthCount += (width + 10);
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!btnLast) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(self.line.mas_bottom).offset(13);
            } else if ((widthCount + 10) >= (WINDOW_WIDTH)){
                widthCount = (width + 10);
                make.top.mas_equalTo(btnLast.mas_bottom).offset(10);
                make.left.mas_equalTo(10);
            } else {
                make.top.mas_equalTo(btnLast);
                make.left.mas_equalTo(btnLast.mas_right).offset(10);
            }
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(22);
        }];
        
        btnLast = button;
        count++;
    }

}

-(void)updateWithArray:(NSArray *)array
{
    [self removeAllButtons];
    [self layoutWithArray:array];
}


- (UIButton *)buttonWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    btn.backgroundColor = kYLColorFontBlue;
    return btn;
}

- (void)buttonClick:(UIButton *)button
{
    NSLog(@"button click  title = %@", button.currentTitle);
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeSearchTag),
                             kYLValue : button.currentTitle,
                             }];
}

- (void)removeAllButtons
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
}


- (CGFloat)adaptWidthWithText:(NSString *)text font:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(WINDOW_WIDTH,20);
    CGRect frame = [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil];
    return frame.size.width;
}

@end
