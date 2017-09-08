
//
//  DDEnterpriTableViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 2017/8/3.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriTableViewCell.h"
#import "DDDataPercentView.h"
#import "DDEnterpriseModel.h"   

@interface DDEnterpriTableViewCell()

@property (nonatomic, strong) UILabel *company_nameLabel;
@property (nonatomic, strong) UIImageView *thumbView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *industryLabel;
@property (nonatomic, strong) DDDataPercentView *percentView;
@property (nonatomic, strong) DDEnterpriseModel  *model;
@end

@implementation DDEnterpriTableViewCell

-(void)addViews{
    [self.contentView addSubview:self.company_nameLabel ];
    [self.contentView addSubview:self.thumbView];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.industryLabel];
    [self.contentView addSubview:self.percentView];
}
-(void)layout{
    [self.thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(75);
//        make.height.mas_equalTo(55);
        make.bottom.mas_equalTo(-15);
    }];
    [self.company_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thumbView.mas_right).offset(10);
        make.top.mas_equalTo(self.thumbView);
        make.right.mas_equalTo(-20);
    }];
    [self.percentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.company_nameLabel);
        make.top.mas_equalTo(self.company_nameLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(-50);
        make.width.mas_equalTo(80);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.percentView.mas_right).offset(5);
        make.top.mas_equalTo(self.company_nameLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [self.industryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeLabel.mas_right).offset(5);
        make.top.mas_equalTo(self.typeLabel);
//        make.bottom.mas_equalTo(-30);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];

}
-(void)useStyle{

    self.company_nameLabel.textColor = kYLColorFontBlack;
    self.company_nameLabel.numberOfLines = 0;
    self.company_nameLabel.font = [UIFont boldSystemFontOfSize:17];
    
    self.typeLabel.font =FONT_H(12);
    self.typeLabel.textColor = kYLColorFontBlue;
    self.typeLabel.layer.borderWidth = 1;
    self.typeLabel.layer.borderColor = kYLColorFontBlue.CGColor;
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.industryLabel.font =FONT_H(12);
    self.industryLabel.textColor = kYLColorFontBlue;
    self.industryLabel.layer.borderWidth = 1;
    self.industryLabel.layer.borderColor = kYLColorFontBlue.CGColor;
    self.industryLabel.textAlignment = NSTextAlignmentCenter;
}
-(void)updateWithModel:(id)obj{
    
    DDEnterpriseModel *model = obj;
    self.model = model;

    [self.thumbView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"img_default"]];
    self.percentView.percent = model.percent;
    self.typeLabel.text = model.reg_type;
    self.industryLabel.text = model.industry;
    
    
    if (model.name) {
        //0未认证1已认证
        if ([model.is_check intValue] == 0) {
            self.company_nameLabel.text = model.name;
        }else{
            //图文混排标新
            NSMutableAttributedString * string = [[ NSMutableAttributedString alloc ] initWithString:model.name attributes:nil ] ;
            NSTextAttachment * textAttachment = [[ NSTextAttachment alloc ] initWithData:nil ofType:nil ] ;
            UIImage * smileImage = [ UIImage imageNamed:@"enterpriseAuth" ] ;
            textAttachment.image = smileImage ;
            textAttachment.bounds = CGRectMake(0, -5, 50, 20);
            NSAttributedString * textAttachmentString = [ NSAttributedString attributedStringWithAttachment:textAttachment ] ;
            [ string insertAttributedString:textAttachmentString atIndex:model.name.length ] ;
            self.company_nameLabel.attributedText = string ;
        }
    }

}
@end








