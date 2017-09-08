//
//  YLForumTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/5/23.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLForumTableViewCell.h"
#import "YLCellBootomView.h"
#import "YLNewsModel.h"

#define kAvatarSize (20)

@interface YLForumTableViewCell ()

@property (nonatomic, strong) UIImageView      *avatar;
@property (nonatomic, strong) UILabel          *lblName;
@property (nonatomic, strong) UILabel          *lblTitle;
@property (nonatomic, strong) UILabel          *lblDetail;
@property (nonatomic, strong) UILabel          *lblDate;
@property (nonatomic, strong) YLCellBootomView *bottomView;
@property (nonatomic, strong) YLNewsModel      *model;

@end

@implementation YLForumTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.lblName];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.lblDate];
    [self.contentView addSubview:self.bottomView];
}

-(void)layout
{
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(5);
        make.width.and.height.mas_equalTo(kAvatarSize);
    }];
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatar);
        make.left.mas_equalTo(self.avatar.mas_right).offset(10);
        make.right.mas_equalTo(-16);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(self.avatar.mas_bottom).offset(5);
    }];
    [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(5);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(self.lblDate.mas_bottom).offset(5);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lblDetail.mas_bottom).offset(5);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)useStyle
{
    self.lblTitle.font = [UIFont systemFontOfSize:16];
    self.lblDate.font = [UIFont systemFontOfSize:12];
    self.lblDetail.font = [UIFont systemFontOfSize:13];
    self.lblName.font = [UIFont systemFontOfSize:13];
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = kAvatarSize / 2.0f;

    self.lblTitle.numberOfLines = 0;
    self.lblDetail.numberOfLines = 2;
    self.lblName.textColor = kYLColorFontBlack;
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblDetail.textColor = kYLColorFontGray;
    self.lblDate.textColor = kYLColorFontGray;
    self.bottomView.type = kYLCellBootomViewTypeCollectAndReply;
    WS(ws);
    self.bottomView.allBlock = ^(NSDictionary *dict) {
        NSMutableDictionary *md = [NSMutableDictionary dictionaryWithDictionary:dict];
        [md setObject:ws.model forKey:kYLModel];
        [ws allBlockWithDict:md];
    };
}

-(void)updateWithModel:(id)obj
{
    YLNewsModel *model = obj;
    self.model = model;
    NSURL *avatar = [NSURL URLWithString:model.avatar];
    [self.avatar sd_setImageWithURL:avatar placeholderImage:IMAGE_PLACEHOLDER];
    self.lblName.text = model.name;
    self.lblTitle.text = model.title;
    self.lblDetail.text = model.content;
    self.lblDate.text = model.inserttime;
    self.bottomView.collect = model.collection;
    self.bottomView.reply = model.reply;
    self.bottomView.isCollect = model.status.integerValue;
    if ([model.isnew intValue] == 0) {
        self.lblTitle.text = model.title;
    }else{
        NSMutableAttributedString * string = [[ NSMutableAttributedString alloc ] initWithString:model.title attributes:nil ] ;
        NSTextAttachment * textAttachment = [[ NSTextAttachment alloc ] initWithData:nil ofType:nil ] ;
        UIImage * smileImage = [ UIImage imageNamed:@"isNewImage" ] ;
        textAttachment.image = smileImage ;
        NSAttributedString * textAttachmentString = [ NSAttributedString attributedStringWithAttachment:textAttachment ] ;
        [ string insertAttributedString:textAttachmentString atIndex:model.title.length ] ;
        self.lblTitle.attributedText = string ;
    }
}


-(void)setIsCollectCell:(BOOL)isCollectCell
{
    if (isCollectCell) {
        [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
        }];
        [self.bottomView removeFromSuperview];
    }
}


@end
