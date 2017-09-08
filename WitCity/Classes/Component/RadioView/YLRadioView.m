//
//  YLRadioView.m
//  WitCity
//
//  Created by simpletour on 16/5/30.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLRadioView.h"

@interface YLRadioView ()

@property (nonatomic, strong) UIButton *btnImage;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation YLRadioView

-(void)addViews
{
    [self addSubview:self.btnImage];
    [self addSubview:self.lblTitle];
}

-(void)layout
{
    [self.btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(0);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(self.btnImage.mas_right).offset(10);
    }];
}

-(void)useStyle
{
    self.userInteractionEnabled = YES;
    self.btnImage.userInteractionEnabled = NO;
    [self.btnImage setImage:[UIImage imageNamed:@"c_radio_detault"] forState:UIControlStateNormal];
    [self.btnImage setImage:[UIImage imageNamed:@"c_radio_selected"] forState:UIControlStateSelected];
    self.lblTitle.font = [UIFont systemFontOfSize:14];
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblTitle.highlightedTextColor = [UIColor blueColor];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(radioClick:)]];
}

- (void)radioClick:(UITapGestureRecognizer *)gesture
{
    if (!self.selected) {
        self.selected = !self.btnImage.selected;
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kYLBlockTypePickerRadioClick),
                                 kYLValue : self,
                                 }];
    }
}

-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.btnImage.selected = selected;
    self.lblTitle.highlighted = selected;
}

@end
