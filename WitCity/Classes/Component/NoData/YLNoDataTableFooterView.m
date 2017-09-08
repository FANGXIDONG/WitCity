//
//  XHNoDataTableFooterView.m
//  style_ios
//
//  Created by yulongdu on 10/9/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLNoDataTableFooterView.h"

@interface YLNoDataTableFooterView()

@property (nonatomic, strong) UILabel *label;

@end

@implementation YLNoDataTableFooterView

-(void)addViews
{
    [self addSubview:self.label];
}

-(void)layout
{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.mas_equalTo(0);
    }];
}

-(void)useStyle
{
    self.label.text = @"没有更多了";
    self.label.textColor = [UIColor colorWithHex:0x747474];
    self.label.backgroundColor = [UIColor colorWithHex:0xf1f1f1];
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.textAlignment = NSTextAlignmentCenter;
}

@end
