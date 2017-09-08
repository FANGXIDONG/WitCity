//
//  YLPersonInfoTableViewCell.h
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLTableViewCell.h"

typedef NS_ENUM(NSInteger, YLPersonInfoCellStyle) {
    kYLPersonInfoCellStyleDefault,
    kYLPersonInfoCellStyleAvatar,
    kYLPersonInfoCellStyleNickname
};


@interface YLPersonInfoTableViewCell : YLTableViewCell

@property (nonatomic, strong) UIImageView           *photo;
@property (nonatomic, strong) UIImageView           *avatar;
@property (nonatomic, copy) NSString                *title;
@property (nonatomic, copy) NSString                *detail;
@property (nonatomic, assign) YLPersonInfoCellStyle style;

@end
