//
//  YLUtil.h
//  HYB
//
//  Created by duyulong on 16/5/2.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YLUtil : NSObject

+ (NSMutableAttributedString *)deleteLineWithText:(NSString *)text offset:(NSInteger)offset;
+ (NSMutableAttributedString *)attributedString:(NSString *)text starPoint:(CGFloat)start endPoint:(CGFloat)end colorValue:(UIColor *)color;
+(void)callWithPhone:(NSString *)phone;

@end
