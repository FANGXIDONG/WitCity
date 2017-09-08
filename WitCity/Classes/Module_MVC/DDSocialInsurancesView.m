//
//  SocialInsurancesView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/29.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSocialInsurancesView.h"
#import "DDScocialInsuranceInquireView.h"      //社保查询
#import "DDSocialInsuranceInfoView.h"          //账户信息
#import "DDSocialInsuranceOpenIntroduceView.h" //业务介绍
#import "DDSocialInsuranceOpenView.h"          //开通社保

@interface DDSocialInsurancesView()
//社保查询
@property (nonatomic, strong) DDScocialInsuranceInquireView *inquireView;
//账户信息
@property (nonatomic, strong) DDSocialInsuranceInfoView *infoView;
//业务介绍
@property (nonatomic, strong) DDSocialInsuranceOpenIntroduceView *introduceView;
//开通社保
@property (nonatomic, strong) DDSocialInsuranceOpenView *openView;
@end

@implementation DDSocialInsurancesView

-(void)addViews{
    [self addSubview:self.inquireView];
    [self addSubview:self.infoView];
    [self addSubview:self.introduceView];
    [self addSubview:self.openView];
}

-(void)layout{
     [self.inquireView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.and.left.and.right.and.bottom.mas_equalTo(0);
    }];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.mas_equalTo(0);
    }];
    [self.introduceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.mas_equalTo(0);
    }];
    [self.openView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.mas_equalTo(0);
    }];
    WS(wself);
    self.inquireView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
//    WS(wself);
    self.infoView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
//    WS(wself);
    self.introduceView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
//    WS(wself);
    self.openView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
}

-(void)setType:(kDDScocialInsuranceViewType)type{
    
    self.inquireView.hidden = YES;
    self.infoView.hidden = YES;
    self.introduceView.hidden = YES;
    self.openView.hidden = YES;
    
    switch (type) {
        case kDDSocialInsuranceViewTypeInquiry:
        {
            self.inquireView.hidden = NO;
            
        }break;
        case kDDSocialInsuranceViewTypeOpen:
        {
            self.openView.hidden = NO;
            
        }break;
        case kDDSocialInsuranceViewTypeAccountInfo:
        {
            self.infoView.hidden = NO;
            
        }break;
        case kDDSocialInsuranceViewTypeOpenIntroduce:
        {
            self.introduceView.hidden = NO;
            
        }break;

        default:
            break;
    }
    _type = type;
}

-(void)callbackWithDict:(NSDictionary *)dict{

     NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
            //点击开通
        case kDDBlockTypeSocialInsurnceOpen:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeSocialInsurnceOpen),
                                     }];
        }
            break;
            //点击查询
        case kDDBlockTypeSocialInsurnceInquire:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeSocialInsurnceInquire),
                                     kYLValue:dict[kYLValue],
                                     }];
        }
            break;
            //点击查看近两笔消费
        case kDDBlockTypeWatchRencentTwoConsume:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeWatchRencentTwoConsume),
                                     }];
        }
            break;
        case kDDBlockTypeSocialInsurnceOpenConfirmed:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeSocialInsurnceOpenConfirmed),
                                     kYLModel:dict[kYLModel],
                                     }];
        }
            break;
        case kDDPopPickerViewAction:
        {
            
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDPopPickerViewAction),
                                     }];
        }
            break;
            
        default:
            break;
    }
}

@end









