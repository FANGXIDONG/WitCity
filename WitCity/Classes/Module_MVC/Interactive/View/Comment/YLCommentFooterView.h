//
//  YLCommentFooterView.h
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

#define kYLCommentFooterHeight (44)

@interface YLCommentFooterView : YLView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UITextField *textField;

@end
