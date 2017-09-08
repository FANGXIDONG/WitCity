//
//  DDPublishWithSelectedItemCell.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//带有单选框的单元格

#import "YLTableViewCell.h"

@interface DDPublishWithSelectedItemCell : YLTableViewCell
//@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign) BOOL isHideLine;
@property (nonatomic, strong) NSArray *itemArr;
@end
