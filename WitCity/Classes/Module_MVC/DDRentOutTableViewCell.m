//
//  DDRentOutTableViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/7.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentOutTableViewCell.h"
#import "DDRentOutModel.h"       //出租model

@interface DDRentOutTableViewCell()
//出租
@property (nonatomic , strong) UIImageView *housePic;   //房屋图片
@property (nonatomic , strong) UIImageView *addrImg;    //地址图片
@property (nonatomic , strong) UILabel *houseName;      //房屋名字
@property (nonatomic , strong) UILabel *houseArea;      //房屋范围及地址
@property (nonatomic , strong) UILabel *houseType;      //出租时间
@property (nonatomic , strong) UILabel *housePrice;     //出租价格
@property (nonatomic , strong) DDRentOutModel *houseModel;
@end

@implementation DDRentOutTableViewCell

-(void)addViews{
    [self.contentView addSubview:self.housePic];
    [self.contentView addSubview:self.houseName];
    [self.contentView addSubview:self.houseArea];
    [self.contentView addSubview:self.houseType];
    [self.contentView addSubview:self.housePrice];
    [self.contentView addSubview:self.addrImg];
}
-(void)layout{
    
    //出租
    [self.housePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(5);
//        make.height.mas_equalTo(60);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(70);
//        make.width.mas_equalTo(self.housePic.height);
    }];
    
    [self.houseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.housePic.mas_right).offset(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(10);
    }];
    
    [self.houseType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.houseName);
        make.top.mas_equalTo(self.houseName.mas_bottom).offset(5);
        
    }];
    
    [self.addrImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.houseType.mas_bottom).offset(5);
        make.left.mas_equalTo(self.houseType);
        make.width.and.height.mas_equalTo(15);
    }];

    
    [self.houseArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.houseType.mas_bottom).offset(5);
        make.left.mas_equalTo(self.addrImg.mas_right).offset(5);
        make.bottom.mas_equalTo(-10);            //attention
    }];
    
    
    [self.housePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.houseType);
    }];

}
-(void)useStyle{
    //出租
    self.houseName.font = [UIFont boldSystemFontOfSize:16];
    self.houseName.numberOfLines = 0;
    self.houseName.textColor =kYLColorFontBlack;
    
    self.houseArea.font = [UIFont systemFontOfSize:13];
    self.houseArea.textColor =kYLColorFontGray;
    
    self.houseType.font = [UIFont systemFontOfSize:12];
    self.houseType.textColor = kYLColorFontGray;
    
    self.housePrice.font = [UIFont systemFontOfSize:16];
    self.housePrice.textColor = kYLColorFontOrange;
}

-(void)updateWithModel:(id)obj{

//出租

    DDRentOutModel *rentOutModel = obj;
    self.houseModel = rentOutModel;
    self.houseName.text = rentOutModel.title;
    self.houseArea.text = rentOutModel.address;
  
    self.housePrice.text = [NSString stringWithFormat:@"%@元/月",rentOutModel.price];;
    [self.housePic sd_setImageWithURL:[NSURL URLWithString:rentOutModel.thumb] placeholderImage:[UIImage imageNamed:@""]];
     
    self.addrImg.image = [UIImage imageNamed:@"cz_dizhi"];
    
//    出租类型(1主卧-合租2次卧-合租3一室-整租4两室-整租5三室-整租6四室-整租7四室以上-整租。)
    
    NSString *strType;
    if ([rentOutModel.type intValue] == 1) {
        strType = @"主卧-合租";
    }
    if ([rentOutModel.type intValue] == 2) {
        strType = @"次卧-合租";
    }
    if ([rentOutModel.type intValue] == 3) {
        strType = @"一室-整租";
    }
    if ([rentOutModel.type intValue] == 4) {
        strType = @"两室-整租";
    }
    if ([rentOutModel.type intValue] == 5) {
        strType = @"三室-整租";
    }
    if ([rentOutModel.type intValue] == 6) {
        strType = @"四室-整租";
    }
    if ([rentOutModel.type intValue] == 7) {
        strType = @"四室以上-整租";
    }
      self.houseType.text = strType;
}
@end







