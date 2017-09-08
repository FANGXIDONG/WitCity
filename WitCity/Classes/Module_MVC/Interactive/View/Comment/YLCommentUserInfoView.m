//
//  YLCommentUserInfoView.m
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCommentUserInfoView.h"
#import "YLNewsModel.h"
#import "DDLWQModel.h"

#define kYLAvatarSize (30)

@interface YLCommentUserInfoView ()

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblDate;

@end

@implementation YLCommentUserInfoView

-(void)addViews
{
    [self addSubview:self.avatar];
    [self addSubview:self.lblName];
    [self addSubview:self.lblDate];
}

-(void)layout
{
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(16);
        make.width.and.height.mas_equalTo(kYLAvatarSize);
    }];
    
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatar.mas_right).offset(10);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(2);
    }];
    
    [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblName);
        make.top.mas_equalTo(self.lblName.mas_bottom).offset(5);
        make.height.mas_equalTo(15);
    }];
}

-(void)useStyle
{
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = kYLAvatarSize / 2.0f;
    self.lblName.textColor = kYLColorFontBlack;
    self.lblDate.textColor = kYLColorFontGray;
    self.lblName.font = [UIFont systemFontOfSize:15];
    self.lblDate.font = [UIFont systemFontOfSize:13];
}

- (void)updateWithLwqModel:(id)obj{
    
    DDLWQModel *model = obj;
    NSURL *url = [NSURL URLWithString:model.avatar];
    [self.avatar sd_setImageWithURL:url];
    self.lblName.text = model.name;
    self.lblDate.text = model.inserttime;
}

- (void)updateWithModel:(id)obj
{
    YLNewsModel *model = obj;
    NSURL *url = [NSURL URLWithString:model.avatar];
    [self.avatar sd_setImageWithURL:url];
    self.lblName.text = model.name;
    self.lblDate.text = model.inserttime;
}

-(void)updateWithCommentModel:(YLCommentModel *)model
{
    NSURL *url = [NSURL URLWithString:model.ravatar];
    [self.avatar sd_setImageWithURL:url];
    self.lblName.text = model.rname;
    self.lblDate.text = model.rinsertime;
}

@end
