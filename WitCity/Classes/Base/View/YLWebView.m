//
//  YLWebView.m
//  FJZ
//
//  Created by yulongdu on 11/10/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLWebView.h"
#import "YLBlockType.h"

@interface YLWebView ()<UIWebViewDelegate>

@end

@implementation YLWebView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.scalesPageToFit = NO;
        self.scrollView.scrollEnabled = YES;
        self.delegate = self;
        
    }
    return self;
}

- (void)allBlockWithDict:(NSDictionary *)dict
{
    if(self.allBlock) {
        self.allBlock(dict);
    }
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeWebLoadFinish),
                             }];
}



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSURL *url = [request URL];
    if ([url.scheme isEqualToString:@"xianbinger"]) {
        if ([url.host isEqualToString:@"goods_number"]) {
            NSDictionary *params = [self paramWithStr:[url query]];
            NSInteger value = [params[@"value"] integerValue];
            [self allBlockWithDict:@{
//                                     kYLKeyForBlockType : @(kYLBlockTypeGoodsValueChange),
                                     kYLValue :@(value)
                                     }];
        }
    }
    return YES;
}


//参数字典
- (NSMutableDictionary *)paramWithStr:(NSString *)paramStr
{
    NSMutableDictionary *ma = [NSMutableDictionary dictionary];
    NSArray *arr = [paramStr componentsSeparatedByString:@"="];
    if (arr.count > 1) {
        [ma setObject:arr[1] forKey:arr[0]];
    }
    return ma;
}


@end
