//
//  DDRentDetailInfoCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/11.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentDetailInfoCell.h"
#import "DDRentoutDetailModel.h"
#import "YLLineBlock.h"

#define cellPadding   15
#define kLineH        10

@interface DDRentDetailInfoCell()

@property (nonatomic, strong) UILabel *infoTitleLabel;     //基本信息
@property (nonatomic, strong) UILabel *houseTypeLabel;     //类型
@property (nonatomic, strong) UILabel *houseResourceLabel; //来源
@property (nonatomic, strong) UILabel *houseFloorLabel;    //楼层
@property (nonatomic, strong) UILabel *houseRoomLabel;     //停尸
@property (nonatomic, strong) DDRentoutDetailModel *model;
@property (nonatomic, strong) YLLineBlock *line;       //分割线
@end

@implementation DDRentDetailInfoCell

-(void)addViews{
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.infoTitleLabel];
    [self.contentView addSubview:self.houseTypeLabel];
    [self.contentView addSubview:self.houseResourceLabel];
    [self.contentView addSubview:self.houseFloorLabel];
    [self.contentView addSubview:self.houseRoomLabel];
}

-(void)layout{
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(kLineH);
    }];

    [self.infoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(10);
        make.left.mas_equalTo(cellPadding);
        make.right.mas_equalTo(-cellPadding);
    }];
    
    [self.houseTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoTitleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.infoTitleLabel);
        make.width.mas_equalTo((WINDOW_WIDTH - cellPadding*2)/2);
    }];
    [self.houseResourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoTitleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(WINDOW_WIDTH/2);
        make.right.mas_equalTo(-cellPadding);
    }];
    [self.houseFloorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.houseTypeLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.houseTypeLabel);
        make.width.mas_equalTo(self.houseTypeLabel);
    }];
    [self.houseRoomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.houseResourceLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.houseResourceLabel);
        make.width.mas_equalTo(self.houseResourceLabel);
        make.bottom.mas_equalTo(-10);
    }];
}

-(void)useStyle{
    
   
    self.infoTitleLabel.font = [UIFont systemFontOfSize:20];
    self.infoTitleLabel.textColor = kYLColorFontBlack;
    
    self.houseTypeLabel.font = [UIFont systemFontOfSize:16];
    self.houseTypeLabel.textColor = kYLColorFontBlack;
    
    self.houseResourceLabel.font = [UIFont systemFontOfSize:16];
    self.houseResourceLabel.textColor = kYLColorFontBlack;
    
    self.houseFloorLabel.font = [UIFont systemFontOfSize:16];
    self.houseFloorLabel.textColor = kYLColorFontBlack;
    
    self.houseRoomLabel.font = [UIFont systemFontOfSize:16];
    self.houseRoomLabel.textColor = kYLColorFontBlack;
    
}

-(void)updateWithModel:(id)obj{
    
    //同一标签显示不同颜色
    DDRentoutDetailModel *model = obj;
    self.model = model;
    self.infoTitleLabel.text = @"基本信息";
    self.houseTypeLabel.attributedText = [self typeString:model];
    self.houseResourceLabel.attributedText = [self resourceString:model];
    self.houseFloorLabel.attributedText = [self floorString:model];
    self.houseRoomLabel.attributedText = [self roomString:model];
}

-(NSMutableAttributedString *)roomString:(DDRentoutDetailModel *)model{
    NSString *type = [self rentType:model];
    NSArray *arr= [self stringSeparated:type];
    NSString *string = [NSString stringWithFormat:@"厅室：%@",arr[0]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,3)];
    return str;
}

-(NSMutableAttributedString *)typeString:(DDRentoutDetailModel *)model{
    
    NSString *type = [self rentType:model];
    NSArray *arr= [self stringSeparated:type];
    NSString *string = [NSString stringWithFormat:@"类型：%@",arr[1]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,3)];
    return str;
}

-(NSMutableAttributedString *)floorString:(DDRentoutDetailModel *)model{
    NSString *string = [NSString stringWithFormat:@"楼层：%@",model.floor];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,3)];
    return str;

}

-(NSMutableAttributedString *)resourceString:(DDRentoutDetailModel *)model{
    NSString *sourceStr;
    switch ([model.source intValue]) {
        case 1:
        {
            sourceStr = @"个人房东";
        }
            break;
        case 2:
        {
            sourceStr = @"中介";
        }
            break;
            
        default:
            break;
    }
    NSString *string = [NSString stringWithFormat:@"来源：%@",sourceStr];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,3)];
    return str;
}

//字符串分割
-(NSArray *)stringSeparated:(NSString *)str{
    
    NSArray *array = [str componentsSeparatedByString:@"-"];
    return array;
}

-(NSString *)rentType :(DDRentoutDetailModel *)model{
    
    NSString *typeStr;
    switch ([model.type intValue]) {
        case 1:
        {
            typeStr = @"主卧-合租";
        }
            break;
        case 2:
        {
            typeStr = @"次卧-合租";
        }
            break;
        case 3:
        {
            typeStr = @"一室-整租";
        }
            break;
        case 4:
        {
            typeStr = @"两室-整租";
        }
            break;
        case 5:
        {
            typeStr = @"三室-整租";
        }
            break;
        case 6:
        {
            typeStr = @"四室-整租";
        }
            break;
        case 7:
        {
            typeStr = @"四室以上-整租";
        }
            break;
            
        default:
            break;
    }
    return typeStr;
}



@end














