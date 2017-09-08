//
//  YLUserCenterSectionView.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLUserCenterSectionView.h"
#import "YLLineBlock.h"

@interface YLUserCenterSectionView ()

@property (nonatomic, strong) YLLineBlock *lineBlock;
@property (nonatomic, strong) UIView      *line;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UILabel     *lblTitle;
@property (nonatomic, strong) UILabel     *lblValue;

@end

@implementation YLUserCenterSectionView

-(void)addViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.arrow];
    [self addSubview:self.lblTitle];
    [self addSubview:self.lblValue];
    [self addSubview:self.lineBlock];
    [self addSubview:self.line];
}

-(void)layout
{
    [self.lineBlock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(self).offset(5);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.mas_equalTo(self.imageView);
        make.width.and.height.mas_equalTo(20);
    }];
    [self.lblValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrow.mas_left).offset(-2);
        make.centerY.mas_equalTo(self.imageView);
        make.width.mas_equalTo(100);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(10);
        make.right.mas_equalTo(self.lblValue.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.imageView);
    }];
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.arrow.image = [UIImage imageNamed:@"u_arrow"];
    self.line.backgroundColor = kYLColorLine;
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblValue.font = FONT_H(13);
    self.lblValue.textColor = kDDColorGrayText;
    self.lblValue.textAlignment = NSTextAlignmentRight;
}

-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

-(void)setImageNamed:(NSString *)imageNamed
{
    self.imageView.image = [UIImage imageNamed:imageNamed];
}
-(void)setValue:(NSString *)value{
    self.lblValue.text = value;
}
@end
