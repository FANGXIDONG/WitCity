//
//  YLSettingTableViewCell.h
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLTableViewCell.h"

typedef NS_ENUM(NSUInteger, YLSettingTableViewCellStyle) {
    kYLSettingTableViewCellStyleDefault,
    kYLSettingTableViewCellStylePush,
    kYLSettingTableViewCellStyleCache,
    kYLSettingTableViewCellStyleArrow,
};

@interface YLSettingTableViewCell : YLTableViewCell

@property (nonatomic, assign) YLSettingTableViewCellStyle style;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;

@end
