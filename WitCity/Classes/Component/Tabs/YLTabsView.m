//
//  XHTabsView.m
//  style_ios
//
//  Created by yulongdu on 10/17/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLTabsView.h"

@interface YLTabsView()

@property(nonatomic, strong) NSArray *items;
@property(nonatomic, strong) UIButton *selectedButton;

@end

@implementation YLTabsView

-(instancetype)initWithFrame:(CGRect)frame  items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemCount = items.count;
        self.items = items;
        [self layoutWithItems:self.items];
    }
    return self;
}

-(void)addViews
{
    [self addSubview:self.currLine];
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            [v removeFromSuperview];
        }
    }
    [self layoutWithItems:self.items];
 
}

-(void)layout{}

- (void)layoutWithItems:(NSArray *)items
{
    CGFloat btnWidth = CGRectGetWidth(self.frame) / items.count;
    CGFloat currLineWith = [self widthWithCount:items.count];
    
    UIButton *btnLast = nil;
    for (NSInteger i=0; i<items.count; i++) {
        UIButton *button = [self buttonWithTitle:items[i] tag:(100 + i)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (btnLast) {
                make.left.mas_equalTo(btnLast.mas_right);
            } else {
                make.left.mas_equalTo(0);
            }
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(btnWidth);
            make.height.mas_equalTo(self.mas_height).offset(-5);
        }];
        
        if (i == self.selectedIndex) {
            button.selected = YES;
            self.selectedButton = button;
            [self.currLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(button);
            }];
        }
        
        btnLast = button;
    }
    
    [self.currLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnLast.mas_bottom).offset(1);
        make.centerX.mas_equalTo(self.selectedButton);
        make.width.mas_equalTo(currLineWith);
        make.height.mas_equalTo(3);
    }];

    [self layoutIfNeeded];
}


-(void)useStyle
{
    self.currLine.backgroundColor = kDefaultFontColor;
}

- (UIButton *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:kDefaultFontColor forState:UIControlStateSelected];
    [button setTitleColor:kDefaultFontColor forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    return button;
}

- (void)buttonClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    [self offsetLineWithButton:button];

}

- (void)selectedButtonWithIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)[self viewWithTag:(100 + index)];
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    [self offsetLineWithButton:button];
}

- (void)offsetLineWithButton:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        self.currLine.center = CGPointMake(button.center.x, self.currLine.center.y);
    }];
    [self selectWithButton:button];
}

- (void)selectWithButton:(UIButton *)button
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeTabsView),
                             kYLValue : @(button.tag - 100)
                             }];
}

- (void)updateLinePositionWithOffset:(CGFloat)offset
{
    
    UIButton *button = (UIButton *)[self viewWithTag:100];
    self.currLine.center = CGPointMake(button.center.x + offset, self.currLine.center.y);
}


- (CGFloat)widthWithCount:(NSInteger)count
{
    CGFloat width = 0;
    switch (count) {
        case 0:{
            width = 60.0f;
        }break;
        case 1:{
            width = 60.0f;
        }break;
        case 2:{
            width = 60.0f;
        }break;
        case 3:{
            width = 60.0f;
        }break;
        default:
            break;
    }
    
    return width;
}

@end
