//
//  DDLifeUserCenterSectionView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDLifeUserCenterSectionView.h"
#import "YLLineBlock.h"

@interface DDLifeUserCenterSectionView ()

@property (nonatomic, strong) YLLineBlock *lineBlock;
@property (nonatomic, strong) UIView      *line;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UILabel     *lblTitle;

@end


@implementation DDLifeUserCenterSectionView

-(void)addViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.arrow];
    [self addSubview:self.lblTitle];
    [self addSubview:self.lineBlock];
    [self addSubview:self.line];
    [self addSubview:self.lblDescpription];
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
    
    [self.lblDescpription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self.arrow.mas_left).offset(-20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(self.imageView);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(10);
        make.right.mas_equalTo(self.arrow.mas_left).offset(-10);
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
    self.lblDescpription.textColor =kYLColorFontGray;
    self.lblDescpription.font = [UIFont systemFontOfSize:13];
    self.lblDescpription.textAlignment = NSTextAlignmentRight;
}

-(void)setStyle:(DDLifeUserCenterSectionStyle)style
{
    switch (style) {
            case kDDLifeUserCenterSectionStyleDefault:{
                self.lblDescpription.hidden = YES;
                
            }break;
            case kDDLifeUserCenterSectionStyleDescpription:{
                self.lblDescpription.hidden = NO;
                
                
            }break;
        default:
            break;
    }
    _style = style;
}



-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

-(void)setImageNamed:(NSString *)imageNamed
{
    self.imageView.image = [UIImage imageNamed:imageNamed];
}


@end
