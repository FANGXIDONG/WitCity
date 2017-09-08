//
//  DDSendNotesOfJobwantCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/9.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSendNotesOfJobwantCell.h"

#import "DDMyNoteBottomView.h"
#import "DDJobSeekModel.h"

@interface DDSendNotesOfJobwantCell()
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblEdu;
@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UILabel *lblStatus;
@property (nonatomic, strong) UILabel *lblDate;
@property (nonatomic, strong) DDMyNoteBottomView *bottomView;
@property (nonatomic, strong) DDJobSeekModel *jobseekModel;
@property (nonatomic, copy) NSString *qzhi_id;

@end

@implementation DDSendNotesOfJobwantCell

-(void)addViews
{
    [self.contentView addSubview:self.lblTitle];
    [self.contentView addSubview:self.lblEdu];
    [self.contentView addSubview:self.lblDetail];
    [self.contentView addSubview:self.lblStatus];
    [self.contentView addSubview:self.lblDate];
    [self.contentView addSubview:self.bottomView];
}

-(void)layout
{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(10);
    }];
    [self.lblEdu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblTitle.mas_right);
        make.top.mas_equalTo(self.lblTitle);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblTitle);
        make.right.mas_equalTo(self.lblEdu);
        make.top.mas_equalTo(self.lblTitle.mas_bottom).offset(10);
    }];
    
    [self.lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblDetail.mas_bottom).offset(10);
        make.left.mas_equalTo(self.lblDetail);
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
    self.lblTitle.font = [UIFont systemFontOfSize:17];
    self.lblTitle.numberOfLines = 0;
    self.lblTitle.textColor = kYLColorFontBlack;
    
    self.lblEdu.textColor= kYLColorFontGray;
    self.lblEdu.font = [UIFont systemFontOfSize:17];
    
    self.lblDetail.font = [UIFont systemFontOfSize:13];
    self.lblDetail.numberOfLines = 0;
    self.lblDetail.textColor = kYLColorFontGray;
    
    self.lblDate.font = [UIFont systemFontOfSize:12];
    self.lblDate.textColor = kYLColorFontGray;
    self.lblDate.textAlignment = NSTextAlignmentRight;
    
    self.lblStatus.font = [UIFont systemFontOfSize:12];
    self.lblStatus.textColor = kYLColorFontRed;
    
    self.bottomView.type = kDDNotesBottomEditAndStatus;

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
                                     kYLModel:self.jobseekModel,
                                     }];
        }break;
        case kDDBlockTypeNotesShow:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesShow),
                                     kYLValue:self.qzhi_id,
                                     }];
        }break;
        case kDDBlockTypeNotesHide:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesHide),
                                     kYLValue:self.qzhi_id,
                                     }];
        }break;
        default:
            break;
    }
}


-(void)updateWithModel:(id)obj
{
    DDJobSeekModel *model = obj;
    self.jobseekModel = model;
    self.lblTitle.text = model.name;
    self.lblEdu.text = [self getCollegeAndEdu:model];
    self.lblDetail.text = [self getExpectWorkData:model];
    self.lblDate.text = model.inserttime;
    self.lblStatus.text = [self jobwantPassStatus:model.status];
    self.qzhi_id = model.qzhi_id;
    if ([model.show isEqualToString:@"1"]) {
        self.bottomView.deleteString = @"显示";
    }if ([model.show isEqualToString:@"2"]) {
        self.bottomView.deleteString = @"隐藏";
    }
}

-(NSString *)jobwantPassStatus :(NSString *)str{
    
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



-(NSString *)getCollegeAndEdu :(DDJobSeekModel *)model{
    
    NSString *colStr;
    NSString *eduStr;
    switch ([model.edu intValue]) {
        case 1:
        {
            eduStr = @"高中";
        }
            break;
        case 2:
        {
            eduStr = @"中专";
        }
            break;
        case 3:
        {
            eduStr = @"大专";
        }
            break;
        case 4:
        {
            eduStr = @"本科";
        }
            break;
        case 5:
        {
            eduStr = @"硕士";
        }
            break;
        case 6:
        {
            eduStr = @"博士";
        }
            break;
        case 7:
        {
            eduStr = @"博士后";
        }
            break;
        case 8:
        {
            eduStr = @"学历不限";
        }
            break;
            
        default:
            break;
    }
    
    colStr = [NSString stringWithFormat:@"（%@、%@）",model.college,eduStr];
    
    return colStr;
}

-(NSString *)getExpectWorkData :(DDJobSeekModel *)model{
    
    NSString *expectStr;
    NSString *salaryStr;
//    NSString *workType;
//    switch ([model.worktype intValue]) {
//        case 1:
//        {
//            workTypeStr = @"全职";
//        }
//            break;
//        case 2:
//        {
//            workTypeStr = @"兼职";
//        }
//            break;
//        case 3:
//        {
//            workTypeStr = @"实习";
//        }
//            break;
//        default:
//            break;
//    }

    switch ([model.salary intValue]) {
        case 1:
        {
            salaryStr = @"2K以下";
        }
            break;
        case 2:
        {
            salaryStr = @"2K-3K";
        }
            break;
        case 3:
        {
            salaryStr = @"3K-5K";
        }
            break;
        case 4:
        {
            salaryStr = @"5K-8K";
        }
            break;
        case 5:
        {
            salaryStr = @"8K-10K";
        }
            break;
        case 6:
        {
            salaryStr = @"10K以上";
        }
            break;
        case 7:
        {
            salaryStr = @"面议";
        }
            break;
            
        default:
            break;
    }

    expectStr = [NSString stringWithFormat:@"期望工作：%@；%@",model.job,salaryStr];
    
    return expectStr;
}

@end












