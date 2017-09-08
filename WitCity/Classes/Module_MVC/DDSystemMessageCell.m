
//
//  DDSystemMessageCell.m
//  WitCity
//
//  Created by 方冬冬 on 2016/11/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSystemMessageCell.h"
#import "DDSystemMessageModel.h"

@interface DDSystemMessageCell()
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblContent;
@property (nonatomic, strong) UILabel *lblTime;
@end

@implementation DDSystemMessageCell
-(void)addViews{
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblContent];
    [self.contentView addSubview:self.lblTime];
}
-(void)layout{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    [self.lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(10);
    }];
    [self.lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.lblContent.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-10);
    }];
}
-(void)useStyle{
    self.lblTitle.numberOfLines = 2;
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblContent.numberOfLines = 0;
    self.lblContent.textColor = kYLColorFontGray;
    self.lblContent.font = [UIFont systemFontOfSize:13];
    self.lblTime.textColor = kYLColorFontGray;
    self.lblTime.font = [UIFont systemFontOfSize:12];
}
-(void)updateWithModel:(id)obj{
    DDSystemMessageModel *model = obj;
    self.lblTitle.text = model.title;
    self.lblContent.text = model.content;
    self.lblTime.text = model.inserttime;
}
@end





