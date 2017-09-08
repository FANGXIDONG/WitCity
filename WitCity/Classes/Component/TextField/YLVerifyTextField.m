//
//  XHVerifyTextField.m
//  style_ios
//
//  Created by duyulong on 9/23/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLVerifyTextField.h"

@interface YLVerifyTextField()

@property (nonatomic, strong) UIView *rightCustomView;

@end

@implementation YLVerifyTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self addRightCustomView];
        [self addButton];
        self.keyboardType = UIKeyboardTypeNamePhonePad;
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
    }
    return self;
}

- (void)addRightCustomView
{
    self.rightCustomView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 100, 0, 100, 50)];
    
}

- (void)addButton
{
    self.button = [[YLVerifyButton alloc]initWithFrame:self.rightCustomView.bounds];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightCustomView addSubview:self.button];
    self.rightView = self.rightCustomView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
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

#pragma mark - 发送验证码
- (void)sendSmsWithPhone:(NSString *)phone
{
    if (self.button.enabled) {
        [self smsWithPhone:phone];
    }
    [self disabledStatus];
}

- (void)smsWithPhone:(NSString *)phone
{

}


@end
