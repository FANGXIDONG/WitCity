//
//  DDSocialInsuranceOpenIntroduceView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/1.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSocialInsuranceOpenIntroduceView.h"
#import "YLLineBlock.h"

@interface DDSocialInsuranceOpenIntroduceView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *openBtn;
@property (nonatomic, strong) YLLineBlock *lineGap;
@property (nonatomic, strong) YLLineBlock *lineBottom;

@end

@implementation DDSocialInsuranceOpenIntroduceView

-(void)addViews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.openBtn];
    [self addSubview:self.lineGap];
    [self addSubview:self.lineBottom];
}

-(void)layout{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
//        make.height.mas_equalTo(40);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(self.titleLabel);
    }];
    
    [self.lineGap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(15);
        make.right.and.left.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineGap.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];

    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.openBtn.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)useStyle{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel.text = @"您尚未开通社保查询业务";
    self.titleLabel.textColor = kYLColorFontBlack;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.contentLabel.text = @"根据京人社保发[2013]210号文件《关于印发<北京市社会保险个人权益记录使用管理办法>的通知》和京社保发[2013]45号文件《关于统一规范社会保险个人权益记录查询使用经办业务的通知》的规定，自2013年10月1日起，参保的用人单位和个人查询打印社会保险个人权益记录将可通过以下四种途径：\n（1）到参保地的区（县）社会保险事业管理中心进行查询；\n（2）自行操作使用安装在社保中心的自助终端进行查询；\n（3）登录北京市社会保险网上服务平台(http://www.bjrbj.gov.cn/csibiz)进行查询\n（4）通过“12333”热线服务电话查询（预计2014年1月正式使用）。一下是四种途径查询的详细操作步骤：";
    self.contentLabel.textColor = kYLColorFontGray;
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.numberOfLines = 0;
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLabel.text length])];
    self.contentLabel.attributedText = attributedString;
    [self.contentLabel sizeToFit];
    
    
    [self.openBtn setTitle:@"点击开通" forState:UIControlStateNormal];
    [self.openBtn setTitleColor:kYLColorFontRed forState:UIControlStateNormal];
    [self.openBtn addTarget:self action:@selector(SIOpenAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)SIOpenAction:(UIButton *)sender{
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeSocialInsurnceOpen),
                             }];
}
@end


















