//
//  DDRentwantHaveTxtFieldCell.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLTableViewCell.h"
#import "YLTextField.h"

typedef NS_ENUM(NSUInteger, kDDCellTextFieldLineType) {
    
    kDDCellTextFieldLineTypeNormal,
    kDDCellTextFieldLineTypeHigher,
};

@interface DDRentwantHaveTxtFieldCell : YLTableViewCell
@property (nonatomic, copy) NSString *string;        //cell左边标题
@property (nonatomic, copy) NSString *headStr;       //头部阴影部分字
@property (nonatomic, copy) NSString *placeholerStr;
@property (nonatomic, assign) BOOL isHideLine;
@property (nonatomic, assign) kDDCellTextFieldLineType type;
@property (nonatomic, strong) YLTextField *txtField;
@end
