//
//  YLCommentTableViewCell.m
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCommentTableViewCell.h"
#import "YLCommentUserInfoView.h"
#import "YLCommentModel.h"

@interface YLCommentTableViewCell ()

@property (nonatomic, strong) YLCommentUserInfoView *userView;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UIView *line;

@end

@implementation YLCommentTableViewCell

-(void)addViews
{
    [self.contentView addSubview:self.userView];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.line];
}

-(void)layout
{
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(kYLCommentUserInfoHeight);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(self.userView.mas_bottom);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
    }];
}

-(void)useStyle
{
    self.lblDetail.font = [UIFont systemFontOfSize:14];
    self.lblDetail.textColor = kYLColorFontGray;
    self.lblDetail.numberOfLines = 0;
    self.line.backgroundColor = kYLColorLine;


}

-(void)updateWithModel:(id)obj
{
    YLCommentModel *model = obj;
    [self.userView updateWithCommentModel:model];
    if (model.reply_name.length > 0) {
        self.lblDetail.text = [NSString stringWithFormat:@"回复@%@:%@", model.reply_name, model.rtalk];
    } else {
        self.lblDetail.text = model.rtalk;
    }
}

-(void)setIsHideLine:(BOOL)isHideLine
{
    self.line.hidden = isHideLine;
}



@end
