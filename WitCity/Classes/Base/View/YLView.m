//
//  XHView.m
//  xiaoher
//
//  Created by yulongdu on 15/9/1.
//  Copyright (c) 2015年 wenjin. All rights reserved.
//

#import "YLView.h"

@implementation YLView

basicMethodsImplementWithView(YLView)

- (void)allBlockWithDict:(NSDictionary *)dict
{
    if(self.allBlock) {
        self.allBlock(dict);
    }
}

-(NSURL *)imageUrlWithStr:(NSString *)str
{
    NSURL *url = [NSURL URLWithString:str];
    return url;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}


@end
