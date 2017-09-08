//
//  XHVerifyTextField.h
//  style_ios
//
//  Created by duyulong on 9/23/15.
//  Copyright © 2015 nick. All rights reserved.
//

//#import "YLNormalTextField.h"
#import "YLLoginTextField.h"
#import "YLVerifyButton.h"
#import <UIKit/UIKit.h>

@interface YLVerifyTextField : YLLoginTextField

@property (nonatomic, strong) YLVerifyButton *button;

- (void)sendSmsWithPhone:(NSString *)phone;

@end
