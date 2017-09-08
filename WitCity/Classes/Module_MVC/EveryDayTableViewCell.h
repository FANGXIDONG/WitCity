//
//  EveryDayTableViewCell.h
//  WitCity
//
//  Created by 方冬冬 on 16/6/28.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EveryDayModel;

@interface EveryDayTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *littleLabel;
@property (nonatomic, strong) UIView *coverview;
@property (nonatomic, strong) EveryDayModel *model;

- (CGFloat)cellOffset;
@end
