
//
//  DDRentDetailHeaderCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/11.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentDetailHeaderCell.h"
#import "DDAddressView.h"
#import "DDRentoutDetailModel.h"

#define kHouseImgHeight     200

@interface DDRentDetailHeaderCell()

@property (nonatomic, strong) DDRentoutDetailModel *model;
@property (nonatomic , strong) UIImageView *addrImg;    //地址图片
@property (nonatomic , strong) UILabel *houseName;      //房屋名字
@property (nonatomic , strong) UILabel *houseArea;      //房屋范围及地址
@property (nonatomic , strong) UILabel *housePrice;
@end

@implementation DDRentDetailHeaderCell

-(void)addViews{

    [self.contentView addSubview:self.houseName];
    [self.contentView addSubview:self.houseArea];
    [self.contentView addSubview:self.housePrice];
    [self.contentView addSubview:self.addrImg];
}

-(void)layout{
 
    [self.houseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(10);
    }];
    
    [self.housePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.houseName);
        make.top.mas_equalTo(self.houseName.mas_bottom).offset(5);
    }];
    
    [self.addrImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.housePrice.mas_bottom).offset(5);
        make.left.mas_equalTo(self.housePrice);
        make.width.and.height.mas_equalTo(15);
    }];
    
    [self.houseArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.housePrice.mas_bottom).offset(5);
        make.left.mas_equalTo(self.addrImg.mas_right).offset(5);
        make.bottom.mas_equalTo(-10);            //attention
    }];
    
}

-(void)useStyle{
    
    
    self.houseName.font = [UIFont boldSystemFontOfSize:18];
    self.houseName.numberOfLines = 0;
    self.houseName.textColor =kYLColorFontBlack;
    
    self.houseArea.font = [UIFont systemFontOfSize:13];
    self.houseArea.textColor =kYLColorFontGray;
    
    self.housePrice.font = [UIFont systemFontOfSize:20];
    self.housePrice.textColor = kYLColorFontOrange;
    
}

-(void)updateWithModel:(id)obj{
    
    DDRentoutDetailModel *rentOutModel = obj;
    self.model = rentOutModel;
    self.houseName.text = rentOutModel.title;
    self.houseArea.text = rentOutModel.address;
    self.housePrice.text = [NSString stringWithFormat:@"%@元/月",rentOutModel.price];;
    self.addrImg.image = [UIImage imageNamed:@"cz_dizhi"];
}

@end








