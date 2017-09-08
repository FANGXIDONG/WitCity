//
//  XHBaseTextView.h
//  xiaoher
//
//  Created by duyulong on 9/3/15.
//  Copyright (c) 2015 wenjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBasicViewMacro.h"
#import "YLMacro.h"


@interface YLTextView : UITextView
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UILabel *lblPlaceholder;

- (void)addViews;
- (void)processPlaceholderWithRange:(NSRange)range text:(NSString *)text;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end
