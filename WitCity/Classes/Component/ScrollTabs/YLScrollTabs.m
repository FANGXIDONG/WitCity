//
//  YLScrollTabs.m
//  WitCity
//
//  Created by simpletour on 16/5/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLScrollTabs.h"
#import "YLCategoryModel.h"

#define kLineNumber (5)
#define kBaseTag (100)

@interface YLScrollTabs ()


@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger itemCount;

@end

@implementation YLScrollTabs

-(void)addViews
{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.currLine];
}

-(void)layout
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(0);
        make.width.mas_equalTo(WINDOW_WIDTH);
        make.height.mas_equalTo(kYLScrollTabsHeight);
    }];
}

-(void)useStyle
{
    self.currLine.backgroundColor = kYLColorFontBlue;
//    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)layoutWithArray:(NSArray *)array
{
    NSInteger length = array.count;
    CGFloat itemWidth = length > kLineNumber ? WINDOW_WIDTH / kLineNumber : WINDOW_WIDTH / length;
    UIButton *btnLast;
    for (NSInteger i=0; i<length; i++) {
        YLCategoryModel *model = array[i];
        NSString *title = model.name;
        UIButton *button = [self buttonWithTitle:title tag:(kBaseTag + i)];
        [self.scrollView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!btnLast) {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(btnLast.mas_right);
            }
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(itemWidth);
        }];
        
        if (0 == i) {
            self.selectedButton = button;
        }
        btnLast = button;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.scrollView.contentSize  = CGSizeMake(itemWidth * length, kYLScrollTabsHeight);
    });
    
    [self.currLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(btnLast);
        make.width.mas_equalTo((self.lineWidth > 0 ? @(self.lineWidth) : btnLast));
        make.centerX.mas_equalTo(self.selectedButton);
        make.height.mas_equalTo(3);
    }];
    [self.scrollView bringSubviewToFront:self.currLine];
}

- (void)updateWithArray:(NSArray *)array
{
    self.itemCount = array.count;
    self.items = array;
    [self removeAllItems];
    [self layoutWithArray:array];
}

- (void)removeAllItems
{
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
}


- (UIButton *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:kYLColorFontBlack forState:UIControlStateSelected];
    [button setTitleColor:kYLColorFontBlack forState:UIControlStateHighlighted];
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

- (void)offsetLineWithButton:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.currLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.and.bottom.mas_equalTo(button);
            make.width.mas_equalTo((self.lineWidth > 0 ? @(self.lineWidth) : button));
            make.height.mas_equalTo(3);
        }];
    }];
    
    [self updateScrollPositioinWithButton:button];
    [self selectWithButton:button];
}

- (void)updateScrollPositioinWithButton:(UIButton *)button
{
    CGFloat minX = CGRectGetMinX(button.frame);
    CGFloat maxX = CGRectGetMaxX(button.frame);
    CGFloat offsetX = self.scrollView.contentOffset.x;
    
    if (minX - offsetX < 0) {
        [self.scrollView setContentOffset:CGPointMake(CGRectGetMinX(button.frame), 0) animated:YES];
    } else if (maxX - offsetX > WINDOW_WIDTH) {
        [self.scrollView setContentOffset:CGPointMake(CGRectGetMaxX(button.frame) - WINDOW_WIDTH, 0) animated:YES];
    }
}

- (void)updateLinePositionWithOffset:(CGFloat)offset
{
    NSInteger count = self.itemCount > kLineNumber ? kLineNumber : self.itemCount;
    CGFloat x = offset / count;
    self.currLine.center = CGPointMake((CGRectGetWidth(self.selectedButton.frame) / 2.0f) + x, self.currLine.center.y);
}

- (void)selectedButtonWithIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)[self viewWithTag:(kBaseTag + index)];
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    [self offsetLineWithButton:button];
}

- (void)selectWithButton:(UIButton *)button
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeTabsView),
                             kYLValue : @(button.tag - kBaseTag)
                             }];
}

-(void)setLineWidth:(NSInteger)lineWidth
{
    _lineWidth = lineWidth;
    if (self.itemCount) {
        [self.currLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.selectedButton);
            make.centerX.mas_equalTo(self.selectedButton);
            make.width.mas_equalTo(lineWidth);
            make.height.mas_equalTo(3);
        }];
    }
}

@end
