//
//  YLUserCenterTableViewCell.h
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLTableViewCell.h"

@interface YLUserCenterTableViewCell : YLTableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageNamed;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) BOOL   isHideLine;

@end
