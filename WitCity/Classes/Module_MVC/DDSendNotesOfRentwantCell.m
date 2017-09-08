//
//  DDSendNotesOfRentwantCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/9.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSendNotesOfRentwantCell.h"
#import "DDMyNoteBottomView.h"
#import "DDRentWantModel.h"

@interface DDSendNotesOfRentwantCell()
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UILabel *lblDate;
@property (nonatomic, strong) UILabel *lblStatus;
@property (nonatomic, strong) DDMyNoteBottomView *bottomView;
@property (nonatomic, strong) DDRentWantModel *rentwantModel;
@property (nonatomic, copy) NSString *qzu_id;

@end

@implementation DDSendNotesOfRentwantCell

-(void)addViews
{
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.lblStatus];
    [self.contentView addSubview:self.lblDate];
    [self.contentView addSubview:self.bottomView];
}

-(void)layout
{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(5);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(10);
    }];
    
    [self.lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblDetail.mas_bottom).offset(10);
//        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblStatus);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lblDate.mas_bottom).offset(10);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)useStyle
{
    self.lblTitle.font = [UIFont systemFontOfSize:16];
    self.lblTitle.numberOfLines = 0;
    self.lblTitle.textColor = kYLColorFontBlack;
    
    self.lblDetail.font = [UIFont systemFontOfSize:13];
    self.lblDetail.numberOfLines = 2;
    self.lblDetail.textColor = kYLColorFontGray;
    
    self.lblDate.textColor = kYLColorFontGray;
    self.lblDate.font = [UIFont systemFontOfSize:12];
    self.lblDate.textAlignment = NSTextAlignmentRight;
    
    self.lblStatus.font = [UIFont systemFontOfSize:12];
    self.lblStatus.textColor = kYLColorFontRed;
    
    self.bottomView.type = kDDNotesBottomEditAndDelete;
    
    WS(wself);
    _bottomView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
}
#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypeNotesEdit:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesEdit),
                                     kYLModel:self.rentwantModel,
                                     }];
        }break;
        case kDDBlockTypeNotesDelete:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesDelete),
                                     kYLValue:self.qzu_id,
                                     }];
        }break;
        default:
            break;
    }
}


-(void)updateWithModel:(id)obj
{
    DDRentWantModel *model = obj;
    self.rentwantModel = model;
    self.lblTitle.text = model.title;
    self.lblDetail.text = [self expectRenthouse:model];
    self.lblDate.text = model.inserttime;
    self.lblStatus.text = [self PassStatus:model.status];
//    self.bottomView.editString = @"编辑";
//    self.bottomView.deleteString = @"删除";
    self.qzu_id = model.qzu_id;
}

-(NSString *)expectRenthouse :(DDRentWantModel *)model{
    
    NSString *expectStr;
    
    expectStr = [NSString stringWithFormat:@"期望房租：%@元/月",model.price];
    
    return expectStr;
}

-(NSString *)PassStatus :(NSString *)str{
    
    NSString *statusStr;
    
    switch ([str intValue]) {
        case 1:
        {
            statusStr = @"审核通过";
        }
            break;
        case 2:
        {
            statusStr = @"审核中";
        }
            break;
        case 3:
        {
            statusStr = @"审核不通过";
        }
            break;
            
        default:
            break;
    }
    return statusStr;
}


@end
