//
//  YLPolicyDetailVC.m
//  WitCity
//
//  Created by simpletour on 16/6/13.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLDefaultDetailVC.h"

@interface YLDefaultDetailVC ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation YLDefaultDetailVC

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
    self.btnCollect.selected = self.model.status.integerValue;
}

-(UIWebView *)webView
{
    if(!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
    }
    return _webView;
}

@end
