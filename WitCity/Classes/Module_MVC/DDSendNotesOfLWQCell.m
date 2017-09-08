//
//  DDSendNotesOfLWQCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/9.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSendNotesOfLWQCell.h"

#import "DDMyNoteBottomView.h"
#import "DDLWQModel.h"

@interface DDSendNotesOfLWQCell()
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UILabel *lblDate;
@property (nonatomic, strong) UILabel *lblStatus;
@property (nonatomic, strong) DDMyNoteBottomView *bottomView;
@property (nonatomic, strong) DDLWQModel *lwqModel;
@property (nonatomic, copy) NSString *circle_id;
@end

@implementation DDSendNotesOfLWQCell

-(void)addViews
{
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.lblDate];
    [self.contentView addSubview:self.lblStatus];
    [self.contentView addSubview:self.bottomView];
}

-(void)layout
{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(10);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblTitle);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(10);
    }];
    
    [self.lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblDetail);
        make.top.mas_equalTo(self.lblDetail.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
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
    self.lblTitle.textColor = kYLColorFontBlack;
    self.lblTitle.numberOfLines = 0;

    self.lblDetail.font = [UIFont systemFontOfSize:13];
    self.lblDetail.numberOfLines = 2;
    self.lblDetail.textColor = kYLColorFontGray;
    
    self.lblDate.textColor = kYLColorFontGray;
    self.lblDate.font = [UIFont systemFontOfSize:12];
    self.lblDate.textAlignment = NSTextAlignmentRight;
    
    self.lblStatus.textColor = kYLColorFontRed;
    self.lblStatus.font = [UIFont systemFontOfSize:12];
    
    self.bottomView.type = kDDNotesBottomOnlyDelete;
    
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
        case kDDBlockTypeNotesDelete:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesDelete),
                                     kYLValue:self.circle_id,
                                     }];
        }break;
        default:
            break;
    }
}

-(void)updateWithModel:(id)obj
{
    DDLWQModel *model = obj;
    self.lwqModel = model;
    self.lblTitle.text = model.title;
    self.lblDetail.text = model.content;
    self.lblStatus.text = [self PassStatus:model.status];
    self.lblDate.text = model.inserttime;
//    self.bottomView.editString = @"编辑";
//    self.bottomView.deleteString = @"删除";
    self.circle_id = model.circle_id;
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
