
//
//  DDMyreplyCell.m
//  WitCity
//
//  Created by 方冬冬 on 2016/11/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyreplyCell.h"
#import "DDMyreplyModel.h"

@interface DDMyreplyCell()
@property (nonatomic, strong) UILabel *replyName;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblContent;
//@property (nonatomic, strong) DDMyreplyModel *mdoel;
@end

@implementation DDMyreplyCell
-(void)addViews{
    [self.contentView addSubview:self.replyName];
    [self.contentView addSubview:self.lblTime];
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblContent];
}
-(void)layout{
    [self.lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
    }];
    [self.replyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.lblTime);
        make.right.mas_equalTo(self.lblTime.mas_left).offset(10);
    }];
 
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.replyName);
        make.top.mas_equalTo(self.replyName.mas_bottom).offset(5);
        make.right.mas_equalTo(-10);
    }];
    [self.lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(5);
        make.bottom.mas_equalTo(-10);
    }];
}

-(void)useStyle{
    
    self.replyName.textColor = kYLColorFontGray;
    self.replyName.font = [UIFont systemFontOfSize:12];
    self.lblTime.textColor = kYLColorFontGray;
    self.lblTime.font = [UIFont systemFontOfSize:10];
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblContent.textColor = kYLColorFontGray;
    self.lblContent.font = [UIFont systemFontOfSize:13];
}

-(void)updateWithModel:(id)obj{
    DDMyreplyModel  *model = obj;
    self.replyName.text = [NSString stringWithFormat:@"%@回复我：",model.rname];
    self.lblTime.text = model.inserttime;
    self.lblTitle.text = model.title;
    self.lblContent.text = model.content;
}
@end








