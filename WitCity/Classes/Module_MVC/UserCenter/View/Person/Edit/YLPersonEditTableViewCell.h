//
//  YLPersonEditTableViewCell.h
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLTableViewCell.h"

@interface YLPersonEditTableViewCell : YLTableViewCell

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isHideTopLine;
@property (nonatomic, assign) BOOL isHideBottomLine;
@property (nonatomic, assign) BOOL isPassword;

@end
