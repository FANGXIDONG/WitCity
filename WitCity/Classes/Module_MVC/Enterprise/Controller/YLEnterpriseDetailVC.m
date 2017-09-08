//
//  YLEnterpriseDetailVC.m
//  WitCity
//
//  Created by duyulong on 16/6/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLEnterpriseDetailVC.h"

@interface YLEnterpriseDetailVC ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation YLEnterpriseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(popViewController) imageNamed:@"navi_back_black"];
    [self initButtonsWithCollectImageNamed:@"c_collect_dark_default" collectHighlightImageNamed:@"c_collect_dark_selected" shareImageNamed:@"c_share_dark"];
    [self addViews];
    self.btnCollect.selected = self.model.status.integerValue;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar lt_setBackgroundColor:kYLColorFontBlue                                                                                ];
//}

-(void)addViews
{
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:self.model.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(UIWebView *)webView
{
    if(!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
    }
    return _webView;
}

@end
