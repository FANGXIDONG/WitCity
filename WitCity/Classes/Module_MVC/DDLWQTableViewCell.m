//
//  DDLWQTableViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/7.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDLWQTableViewCell.h"
#import "DDLWQModel.h"           //柳梧圈model
#import "DDBrowserImageInfo.h"
//#import <UIImageView+WebCache.h>

@interface DDLWQTableViewCell()
//柳梧圈
@property (nonatomic , strong) UIImageView *publisherThumb; //发布者头像
@property (nonatomic , strong) UILabel *publisherName;      //发布者头像
@property (nonatomic , strong) UILabel *publisherContent;   //发布内容
@property (nonatomic , strong) UILabel *publisherDate;      //发布时间
@property (nonatomic , strong) UILabel *replyCountLab;      //评论数
//@property (nonatomic , strong) DDLWQModel *lwqModel;
@property (nonatomic , strong) UIImageView *replyView; //评论图标
//@property (nonatomic , strong) UIImageView *contextPic1; //内容图片
//@property (nonatomic , strong) UIImageView *contextPic2; //内容图片
//@property (nonatomic , strong) UIImageView *contextPic3; //内容图片

@property (nonatomic, strong) DDImageContentView* imageContentView;
@property (nonatomic, assign) float selfHeight;
@end

@implementation DDLWQTableViewCell


-(void)addViews{
    [self.contentView addSubview:self.publisherThumb];
    [self.contentView addSubview:self.publisherName];
    [self.contentView addSubview:self.publisherContent];
    [self.contentView addSubview:self.publisherDate];
    [self.contentView addSubview:self.replyCountLab];
    [self.contentView addSubview:self.replyView];
    [self.contentView addSubview:self.imageContentView];
}

-(void)layout{

    [self.publisherThumb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.publisherName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.publisherThumb.mas_right).offset(8);
        make.top.mas_equalTo(self.publisherThumb);
    }];
    [self.publisherDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.publisherName.mas_bottom).offset(5);
        make.left.mas_equalTo(self.publisherName);
    }];
    
    [self.replyCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.publisherName);
        make.height.mas_equalTo(20);
    }];
    
    [self.replyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.replyCountLab.mas_left).offset(-5);
        make.top.mas_equalTo(self.replyCountLab);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [self.publisherContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.publisherDate);
        make.top.mas_equalTo(self.publisherDate.mas_bottom).offset(0);
        make.right.mas_equalTo(-8);
        
    }];
//    [self.imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.publisherContent);
//        make.top.mas_equalTo(self.publisherContent.mas_bottom).offset(5);
//        make.right.mas_equalTo(-80);
//        make.bottom.mas_equalTo(-10);
//    }];
    
    self.imageContentView.sd_layout
    .leftEqualToView(self.publisherContent)
    .topSpaceToView(self.publisherContent,5)
    .rightSpaceToView(self.contentView,80)
    .autoHeightRatio(0);
    
    WS(wself);
    _imageContentView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    
    [self setupAutoHeightWithBottomView:self.imageContentView bottomMargin:10];
}
#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypeLwqImageBrowser:
        {
             DDBrowserImageInfo *browserImg =dict[kYLModel];
            
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeLwqImageBrowser),
                                     kYLModel:browserImg,
                                     }];
        }break;
        default:
            break;
    }
}

-(void)useStyle{
    
    self.publisherThumb.layer.cornerRadius = 30;
    self.publisherThumb.layer.masksToBounds = YES;
    
    self.publisherName.textColor  =kYLColorFontBlack;
    self.publisherName.font = [UIFont systemFontOfSize:14];
    
    self.publisherDate.font = [UIFont systemFontOfSize:8];
    self.publisherDate.textColor =kYLColorFontGray;
    
    self.replyView.image = [UIImage imageNamed:@"lwq_pinglun"];
    self.replyCountLab.textColor =kYLColorFontGray;
    self.replyCountLab.font = [UIFont systemFontOfSize:12];
    
    self.replyCountLab.userInteractionEnabled = YES;
    self.replyView.userInteractionEnabled = YES;
//    [self.replyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replyClick:)]];
//[self.replyCountLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replyClick:)]];

    self.publisherContent.textColor = kYLColorFontBlack;
    self.publisherContent.numberOfLines = 1;
    self.publisherContent.font = [UIFont systemFontOfSize:16];
    
//    [self.imageContentView setTranslatesAutoresizingMaskIntoConstraints:NO];

 }

//-(void)replyClick:(UITapGestureRecognizer *)tap{
//    
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"message" message:@"点击评论" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//        [alert show];
//    
//}

-(void)updateWithModel:(id)obj{

    DDLWQModel *lwqModel = obj;
    self.model = lwqModel;
    self.publisherName.text = lwqModel.name;
    self.publisherContent.text = lwqModel.title;
    self.publisherDate.text = lwqModel.inserttime;
    self.replyCountLab.text = [NSString stringWithFormat:@"%@",lwqModel.reply];
    [self.publisherThumb sd_setImageWithURL:[NSURL URLWithString:lwqModel.avatar] placeholderImage:[UIImage imageNamed:@""]];
 
    self.imageContentView.imageArray = lwqModel.imageArray;
    
//   NSLog(@"头像高度：%f--内容高度%f----图片高度%f",self.publisherThumb.frame.size.height,self.publisherContent.frame.size.height,self.imageContentView.frame.size.height);
//  
//    self.selfHeight = self.publisherThumb.frame.size.height +self.publisherContent.frame.size.height +self.imageContentView.frame.size.height;
    
}



@end













