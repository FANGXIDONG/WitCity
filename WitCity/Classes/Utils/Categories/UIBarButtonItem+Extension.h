//
//  UIBarButtonItem+Extension.h
//  WitCity
//
//  Created by 方冬冬 on 16/6/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTargat:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
