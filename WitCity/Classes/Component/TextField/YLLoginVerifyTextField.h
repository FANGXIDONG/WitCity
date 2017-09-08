//
//  YLLoginVerifyTextField.h
//  HYB
//
//  Created by simpletour on 16/3/29.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLLoginTextField.h"

@interface YLLoginVerifyTextField : YLLoginTextField

@property (nonatomic, copy) void(^allBlock)(NSDictionary *dict);
- (void)disabledStatus;

@end
