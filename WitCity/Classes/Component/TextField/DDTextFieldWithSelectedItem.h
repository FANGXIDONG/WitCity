//
//  DDTextFieldWithSelectedItem.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/16.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//带有选择按钮

#import "YLNormalTextField.h"

@interface DDTextFieldWithSelectedItem : YLNormalTextField

@property (nonatomic, copy) void(^allBlock)(NSDictionary *dict);
@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign) BOOL isHideLine;

- (BOOL) deptNumInputShouldNumber;
@end
