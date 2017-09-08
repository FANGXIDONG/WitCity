//
//  YLLoginVerifyTextField.m
//  HYB
//
//  Created by simpletour on 16/3/29.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLLoginVerifyTextField.h"
#import "YLVerifyButton.h"
//#import "YLUserHttpUtil.h"

@interface YLLoginVerifyTextField ()

@property (nonatomic, strong) UIView *rightCustomView;
@property (nonatomic, strong) YLVerifyButton *button;

@end

@implementation YLLoginVerifyTextField


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.validateType = kYLTextFieldTypeVercode;
        [self addRightCustomView];
        [self addButton];
        self.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    return self;
}

- (void)addRightCustomView
{
    self.rightCustomView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 100, 0, 110, 40)];
}

- (void)addButton
{
    self.button = [[YLVerifyButton alloc]initWithFrame:CGRectMake(15, 0, 80, 40)];
    [self.rightCustomView addSubview:self.button];
    self.rightView = self.rightCustomView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(UIButton *)button
{
    if (self.allBlock) {
        self.allBlock(@{
                        kYLKeyForBlockType : @(kYLBlockTypeMessageCode)
                        });
    }
}

- (void)disabledStatus
{
    __block int timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.button.enabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *newTitle = [NSString stringWithFormat:@"%d秒后获取", seconds];
            self.button.enabled = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.button setTitle:newTitle forState:UIControlStateDisabled];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


@end
