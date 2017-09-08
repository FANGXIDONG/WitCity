
//
//  DDSendNotesOfRentoutCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/9.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSendNotesOfRentoutCell.h"
#import "DDMyNoteBottomView.h"
#import "DDRentOutModel.h"

@interface DDSendNotesOfRentoutCell()
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblStatus;
@property (nonatomic, strong) UILabel *lblDate;
@property (nonatomic, strong) DDMyNoteBottomView *bottomView;
@property (nonatomic, strong) DDRentOutModel *rentoutModel;
@property (nonatomic, copy) NSString *lease_id;

@end

@implementation DDSendNotesOfRentoutCell

-(void)addViews
{
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.lblPrice];
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
        make.left.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(10);
    }];
    
    [self.lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblDetail);
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
        make.top.mas_equalTo(self.lblDate.mas_bottom).offset(5);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)useStyle
{
    self.lblTitle.font = [UIFont systemFontOfSize:16];
    self.lblTitle.numberOfLines = 0;
    self.lblTitle.textColor = kYLColorFontBlack;
    
    
    self.lblDate.font = [UIFont systemFontOfSize:12];
    self.lblDate.textColor = kYLColorFontGray;
    self.lblDate.textAlignment = NSTextAlignmentRight;
    
    self.lblDetail.font = [UIFont systemFontOfSize:15];
    self.lblDetail.numberOfLines = 2;
    self.lblDetail.textColor = kYLColorFontGray;
    
    self.lblPrice.textColor = kYLColorFontGray;
    self.lblPrice.font =[ UIFont systemFontOfSize:16];
   
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
                                     kYLModel:self.rentoutModel,
                                     }];
        }break;
        case kDDBlockTypeNotesDelete:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesDelete),
                                     kYLValue:self.lease_id,
                                     }];
        }break;
        default:
            break;
    }
}


-(void)updateWithModel:(id)obj
{
    DDRentOutModel *model = obj;
    self.rentoutModel = model;
    self.lblTitle.text = model.title;
    self.lblDetail.text = [self rentType:model];
    self.lblPrice.text = [NSString stringWithFormat:@"%@元/月",model.price];
    self.lblStatus.text = [self PassStatus:model.status];
    self.lblDate.text = model.inserttime;
//    self.bottomView.editString = @"编辑";
//    self.bottomView.deleteString = @"删除";
    
    self.lease_id = model.lease_id;
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


-(NSString *)rentType :(DDRentOutModel *)model{
    
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





