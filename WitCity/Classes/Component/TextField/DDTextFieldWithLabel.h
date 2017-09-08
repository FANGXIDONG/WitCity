//
//  DDTextFieldWithLabel.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/16.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//左边label

#import "YLNormalTextField.h"

typedef NS_ENUM(NSUInteger, kDDTextFieldWithLabelSelectedType) {
    
    kDDTextFieldWithoutSelectedItem = 0,     //没有选择的
    kDDTextFieldWithSelectedItem ,    //有选取按钮的 医保号、医保卡号
    
};


@interface DDTextFieldWithLabel : YLNormalTextField

@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign) BOOL isHideLine;

@property (nonatomic, assign) kDDTextFieldWithLabelSelectedType type;
@end
