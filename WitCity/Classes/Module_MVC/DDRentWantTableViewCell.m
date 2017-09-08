//
//  DDRentWantTableViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/7.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentWantTableViewCell.h"
#import "DDRentWantModel.h"

@interface DDRentWantTableViewCell()
//求租
@property (nonatomic , strong) UIImageView *rentSeekerThumb; //求租头像
@property (nonatomic , strong) UILabel *rentSeekTitle;       //求租标题
@property (nonatomic , strong) UILabel *rentSeekType;        //求租类型
@property (nonatomic , strong) UILabel *rentSeekDate;        //求租时间
@property (nonatomic , strong) UILabel *rentSeekPrice;       //求租价格
@property (nonatomic , strong) DDRentWantModel *rentSeekmodel;

@end

@implementation DDRentWantTableViewCell

-(void)addViews{
    [self.contentView addSubview:self.rentSeekerThumb];
    [self.contentView addSubview:self.rentSeekTitle];
    [self.contentView addSubview:self.rentSeekType];
    [self.contentView addSubview:self.rentSeekDate];
    [self.contentView addSubview:self.rentSeekPrice];
}
-(void)layout{
    
    //求租
    
    [self.rentSeekerThumb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.width.and.height.mas_equalTo(40);
    }];
    
    [self.rentSeekTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rentSeekerThumb.mas_right).offset(15);
        make.top.mas_equalTo(self.rentSeekerThumb.mas_top).offset(5);;
        make.right.mas_equalTo(-5);
    }];
    
    [self.rentSeekType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rentSeekTitle.mas_bottom).offset(5);
        make.left.mas_equalTo(self.rentSeekTitle);
        
    }];
    
    [self.rentSeekDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rentSeekerThumb);
        make.top.mas_equalTo(self.rentSeekType.mas_bottom).offset(10);
        
    }];
    [self.rentSeekPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rentSeekDate.mas_top).offset(-5);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-10);            //attention
    }];
}
-(void)useStyle{
    
    self.rentSeekerThumb.layer.cornerRadius = 30;
    self.rentSeekerThumb.layer.masksToBounds = YES;
    //求租
    self.rentSeekTitle.font = [UIFont boldSystemFontOfSize:16];
    self.rentSeekTitle.numberOfLines = 0;
    self.rentSeekTitle.textColor =kYLColorFontBlack;
    
    self.rentSeekType.font = [UIFont systemFontOfSize:12];
    self.rentSeekType.numberOfLines = 0;
    self.rentSeekType.textColor =kYLColorFontGray;
    
    self.rentSeekDate.font = [UIFont systemFontOfSize:12];
    self.rentSeekDate.textColor = kYLColorFontGray;
    
    self.rentSeekPrice.font = [UIFont systemFontOfSize:16];
    self.rentSeekPrice.textColor = kYLColorFontOrange;
    
}

-(void)updateWithModel:(id)obj{

    //求租

    DDRentWantModel *rentWantModel = obj;
    self.rentSeekmodel   = rentWantModel;
    self.rentSeekTitle.text = rentWantModel.title;

    self.rentSeekDate.text = rentWantModel.inserttime;
    [self.rentSeekerThumb sd_setImageWithURL:[NSURL URLWithString:rentWantModel.avatar] placeholderImage:[UIImage imageNamed:@""]];

    
//    租金选项：1、1k元以下2、1k-1.5k元3、1.5k-2k元4、2k-3k元5、3k-5k元6、5k元-8k元7、8k以上
    
    NSString *rentPrice;
    if ([rentWantModel.price intValue]==1) {
        rentPrice = @"1K以下";
    }
    if ([rentWantModel.price intValue]==2) {
        rentPrice = @"1K-1.5K";
    }
    if ([rentWantModel.price intValue]==3) {
        rentPrice = @"1.5K-2K";
    }
    if ([rentWantModel.price intValue]==4) {
        rentPrice = @"2K-3K";
    }
    if ([rentWantModel.price intValue]==5) {
        rentPrice = @"3K-5K";
    }
    if ([rentWantModel.price intValue]==6) {
        rentPrice = @"5K-8K";
    }
    if ([rentWantModel.price intValue]==7) {
        rentPrice = @"8K以上";
    }
    
    self.rentSeekPrice.text = rentPrice;
    
    
    NSString *strType;
    if ([rentWantModel.type intValue] == 1) {
        strType = @"主卧-合租";
    }
    if ([rentWantModel.type intValue] == 2) {
        strType = @"次卧-合租";
    }
    if ([rentWantModel.type intValue] == 3) {
        strType = @"一室-整租";
    }
    if ([rentWantModel.type intValue] == 4) {
        strType = @"两室-整租";
    }
    if ([rentWantModel.type intValue] == 5) {
        strType = @"三室-整租";
    }
    if ([rentWantModel.type intValue] == 6) {
        strType = @"四室-整租";
    }
    if ([rentWantModel.type intValue] == 7) {
        strType = @"四室以上-整租";
    }
        self.rentSeekType.text = strType;
}
@end



