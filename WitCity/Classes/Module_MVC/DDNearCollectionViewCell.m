

//
//  DDNearCollectionViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/13.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDNearCollectionViewCell.h"
#import "DDZTHomeModel.h"

@interface DDNearCollectionViewCell()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *oldPriceLabel;
@property (nonatomic, strong) UILabel *currentPriceLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) DDZTHomeModel *model;
@end

@implementation DDNearCollectionViewCell

//重写父类的构造函,完成单元格的定制
-(id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.iconView  = [[UIImageView alloc] init];
        self.infoLabel = [[UILabel alloc] init];
        self.oldPriceLabel = [[UILabel alloc] init];
        self.currentPriceLabel = [[UILabel alloc] init];
        self.nameLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.infoLabel];
        [self.contentView addSubview:self.oldPriceLabel];
        [self.contentView addSubview:self.currentPriceLabel];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo((WINDOW_WIDTH-15)/2 - 80);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView);
            make.top.mas_equalTo(self.iconView.mas_bottom).offset(5);
            make.width.mas_equalTo(self.iconView);
        }];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(self.nameLabel);
        }];
        [self.currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.infoLabel);
            make.width.mas_equalTo(50);
            make.top.mas_equalTo(self.infoLabel.mas_bottom).offset(5);
        }];
        [self.oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.currentPriceLabel.mas_right).offset(0);
            make.top.mas_equalTo(self.currentPriceLabel);
        }];
    
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.nameLabel.textColor = kYLColorFontBlack;
        
        self.infoLabel.font = [UIFont systemFontOfSize:13];
        self.infoLabel.textColor = kYLColorFontGray;
        
        self.currentPriceLabel.font = [UIFont systemFontOfSize:15];
        self.currentPriceLabel.textColor = kYLColorFontRed;
        
        self.oldPriceLabel.font = [UIFont systemFontOfSize:15];
        self.oldPriceLabel.textColor = kYLColorFontGray;
    }
    return self;
}

-(void)updateWithModel:(id)obj{
    
    DDZTHomeModel *model = obj;
    self.model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = model.name;
    self.infoLabel.text = model.info;
    self.currentPriceLabel.text = model.current_price;
    /**
     * 原价添加删除线
     */
    NSString *oldPrice = model.origin_price;
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid |
     NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName
                  value:kYLColorFontGray range:NSMakeRange(0, length)];
    [self.oldPriceLabel setAttributedText:attri];
}


@end
