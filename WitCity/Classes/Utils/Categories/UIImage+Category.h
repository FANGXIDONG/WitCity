//
//  UIImage+Category.h
//  WasowaPE
//
//  Created by duyulong on 10/30/14.
//  Copyright (c) 2014 Wasowa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Categery)
//设置宽高
- (UIImage *)transformWidth:(CGFloat)width height:(CGFloat)height;
//等比例缩放
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
//另一种设置宽高
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
+ (UIImage *)reSizeOpaqueImage:(UIImage *)image toSize:(CGSize)reSize;

+ (UIImage *)imageWithColor:(UIColor *)color;
@end
