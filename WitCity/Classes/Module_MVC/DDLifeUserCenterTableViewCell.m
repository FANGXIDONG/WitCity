//
//  DDLifeUserCenterTableViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDLifeUserCenterTableViewCell.h"


@interface DDLifeUserCenterTableViewCell()

@property (nonatomic, strong) UIImageView *photo;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UILabel     *lblTitle;
@property (nonatomic, strong) UIView      *line;


@end

@implementation DDLifeUserCenterTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.arrow];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.line];
}

-(void)layout
{
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(self);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.mas_equalTo(self.photo);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.photo.mas_right).offset(10);
        make.right.mas_equalTo(self.arrow.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.photo);
    }];    
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblTitle.textColor = kYLColorFontBlack;
    self.line.backgroundColor = kYLColorLine;

}

-(void)setArroImg:(NSString *)arroImg{
        self.arrow.image = [UIImage imageNamed:arroImg];
}

-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

-(void)setImageNamed:(NSString *)imageNamed
{
    self.photo.image = [UIImage imageNamed:imageNamed];
}


-(void)setStyle:(DDLifeUserCenterCellStyle)style
{
    switch (style) {
        case kDDLifeUserCenterCellStyleDefault:{

            
        }break;
        case kDDLifeUserCenterCellStyleVariousSerive:{
//            [self.arrow removeFromSuperview];

        }break;
        default:
            break;
    }
    _style = style;
}


@end
