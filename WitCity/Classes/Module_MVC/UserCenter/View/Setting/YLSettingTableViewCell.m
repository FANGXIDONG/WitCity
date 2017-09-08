//
//  YLSettingTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLSettingTableViewCell.h"

@interface YLSettingTableViewCell ()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UISwitch *sthPush;
@property (nonatomic, strong) UIImageView *arrow;

@end

@implementation YLSettingTableViewCell

-(void)addViews
{
    [self addSubview:self.lblTitle];
    [self addSubview:self.lblDetail];
    [self addSubview:self.sthPush];
    [self addSubview:self.arrow];
}

-(void)layout
{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.width.mas_equalTo(200);
    }];
}

-(void)useStyle
{
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblTitle.font = [UIFont systemFontOfSize:14];
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblDetail.textColor = kYLColorFontGray;
    self.arrow.image = [UIImage imageNamed:@"u_arrow"];
}


-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

-(void)setDetail:(NSString *)detail
{
    self.lblDetail.text = detail;
}


-(void)setStyle:(YLSettingTableViewCellStyle)style
{
    switch (style) {
        case kYLSettingTableViewCellStyleDefault:{
            [self.sthPush removeFromSuperview];
        }break;
        case kYLSettingTableViewCellStylePush:{
            [self.sthPush mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.right.mas_equalTo(-16);
                make.height.mas_equalTo(20);
                make.width.mas_equalTo(60);
            }];
        }break;
        case kYLSettingTableViewCellStyleCache:{
            [self.sthPush removeFromSuperview];
            [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.bottom.mas_equalTo(0);
                make.right.mas_equalTo(-16);
            }];
        }break;
        case kYLSettingTableViewCellStyleArrow:{
            [self.sthPush removeFromSuperview];
            [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-16);
                make.centerY.mas_equalTo(self);
                make.width.and.height.mas_equalTo(20);
            }];
        }break;
        default:
            break;
    }
    
    _style = style;
}

@end
