//
//  SocialInsurancesView.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/29.
//  Copyright © 2016年 BeijingXYBS. All rights reserved.
//

//视图复用。社保查询、社保账户信息展示、社保开通简介、社保开通填写信息

#import "YLView.h"

typedef NS_ENUM(NSUInteger, kDDScocialInsuranceViewType) {
    
    kDDSocialInsuranceViewTypeInquiry = 0,
    kDDSocialInsuranceViewTypeOpen,
    kDDSocialInsuranceViewTypeAccountInfo,
    kDDSocialInsuranceViewTypeOpenIntroduce,
};


@interface DDSocialInsurancesView : YLView

@property (nonatomic, assign) kDDScocialInsuranceViewType type;
@end
