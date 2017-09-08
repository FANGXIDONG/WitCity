//
//  DDLifeUserCenterTableViewCell.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//生活版个人中心单元格

#import "YLTableViewCell.h"

typedef NS_ENUM(NSInteger, DDLifeUserCenterCellStyle) {
    kDDLifeUserCenterCellStyleDefault,
    kDDLifeUserCenterCellStyleVariousSerive, //待付款、待发货、待确认、待评价、退款
};


@interface DDLifeUserCenterTableViewCell : YLTableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageNamed;
@property (nonatomic, copy) NSString *arroImg;

//@property (nonatomic, strong) NSArray *titleArr;
//@property (nonatomic, strong) NSArray *imgArr;

@property (nonatomic, assign) DDLifeUserCenterCellStyle style;
@end
