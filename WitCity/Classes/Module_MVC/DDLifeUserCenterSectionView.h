//
//  DDLifeUserCenterSectionView.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//生活版个人中分组头视图

#import "YLView.h"

typedef NS_ENUM(NSInteger, DDLifeUserCenterSectionStyle) {
    kDDLifeUserCenterSectionStyleDefault,
    kDDLifeUserCenterSectionStyleDescpription, //右边标签，查看全部订单
};

#define kDDLifeUserCenterSectionHeight (60)

@interface DDLifeUserCenterSectionView : YLView

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageNamed;
@property (nonatomic, strong) UILabel     *lblDescpription;

@property (nonatomic, assign) DDLifeUserCenterSectionStyle style;
@end
