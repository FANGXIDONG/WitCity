//
//  YLUtil.m
//  HYB
//
//  Created by duyulong on 16/5/2.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLUtil.h"
#import "YLMacro.h"

@implementation YLUtil

+ (NSMutableAttributedString *)deleteLineWithText:(NSString *)text offset:(NSInteger)offset
{
    NSMutableAttributedString *attributeString= [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(offset, text.length - offset)];
    return attributeString;
}

+ (NSMutableAttributedString *)attributedString:(NSString *)text starPoint:(CGFloat)start endPoint:(CGFloat)end colorValue:(UIColor *)color
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(start,end)];
    return str;
}

+(void)callWithPhone:(NSString *)phone
{
    NSString *str = [NSString stringWithFormat:@"tel:%@", phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [KEY_WINDOW addSubview:callWebview];
}

@end
