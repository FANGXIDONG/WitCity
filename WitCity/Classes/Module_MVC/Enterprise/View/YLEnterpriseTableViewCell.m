//
//  YLEnterpriseTableViewCell.m
//  WitCity
//
//  Created by duyulong on 16/5/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLEnterpriseTableViewCell.h"
#import "YLTagsView.h"
#import "YLCellBootomView.h"
#import "YLNewsModel.h"

@interface YLEnterpriseTableViewCell ()

@property (nonatomic, strong) UIImageView *photo;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) YLTagsView *tagsView;
@property (nonatomic, strong) YLCellBootomView *bottomView;
@property (nonatomic, strong) YLNewsModel *model;

@end

@implementation YLEnterpriseTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.tagsView];
    [self.contentView addSubview:self.bottomView];
}

-(void)layout
{
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(100, 80));
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photo);
        make.right.mas_equalTo(-16);
        make.left.mas_equalTo(self.photo.mas_right).offset(16);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.bottom.mas_equalTo(self.photo);
    }];
    
    [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.photo.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.tagsView.mas_bottom).offset(5);
        make.height.mas_equalTo(45);
    }];
}

-(void)useStyle
{
    self.lblTitle.font = [UIFont systemFontOfSize:17];
    self.lblDetail.font = [UIFont systemFontOfSize:14];
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblDetail.textColor = kYLColorFontGray;
    self.lblTitle.numberOfLines = 0;
    self.lblDetail.numberOfLines = 0;
    
    self.bottomView.type = kYLCellBootomViewTypeCollectAndFlag;
    
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
    NSURL *url = [NSURL URLWithString:model.thumb];
    [self.photo sd_setImageWithURL:url];
    self.lblTitle.text = model.title;
    self.lblDetail.text = model.content;
    [self.tagsView updateWithArray:model.tag];
    self.bottomView.flag = model.category;
    self.bottomView.collect = model.collection;
    self.bottomView.isCollect = model.status.integerValue;
}

-(void)setIsCollectCell:(BOOL)isCollectCell
{
    if (isCollectCell) {
        [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
        }];
        [self.tagsView removeFromSuperview];
        [self.bottomView removeFromSuperview];
    }
}

@end
