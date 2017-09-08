//
//  YLBannerDetailVC.m
//  WitCity
//
//  Created by simpletour on 16/6/22.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLBannerDetailVC.h"

@interface YLBannerDetailVC ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation YLBannerDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@""];
    [self addViews];
}

-(void)addViews
{
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:self.model.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(UIWebView *)webView
{
    if(!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
    }
    return _webView;
}


@end
