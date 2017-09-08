//
//  YLTagsView.m
//  WitCity
//
//  Created by duyulong on 16/5/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLTagsView.h"

@interface YLTagsView ()

@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation YLTagsView

-(void)addViews
{
    [self addSubview:self.lblTitle];
}

-(void)layout
{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(5);
    }];
}

-(void)useStyle
{
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblTitle.font = [UIFont systemFontOfSize:13];
    self.lblTitle.text = @"主营业务:";
}


- (void)layoutWithArray:(NSArray *)array
{
    UIButton *btnLast;
    for (NSInteger i=0, length = array.count; i<(length > 4 ? 4 : length); i++) {
        NSString *title = array[i];
        UIButton *button = [self buttonWithTitle:title];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!btnLast) {
                make.left.mas_equalTo(self.lblTitle.mas_right).offset(5);
            } else {
                make.left.mas_equalTo(btnLast.mas_right).offset(10);
            }
            make.centerY.mas_equalTo(self.lblTitle);
            make.height.mas_equalTo(20);
        }];
        
        btnLast = button;
    }
}


- (void)updateWithArray:(NSArray *)array
{
    [self removeAllButtons];
    [self layoutWithArray:array];
}

- (UIButton *)buttonWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kYLColorFontBlue forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = kYLColorFontBlue.CGColor;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    return btn;
}

- (void)removeAllButtons
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
}

-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

@end
