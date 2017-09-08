//
//  DDEnterpriseHomepageVC.m
//  WitCity
//
//  Created by 方冬冬 on 2017/8/1.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseHomepageVC.h"

@interface DDEnterpriseHomepageVC ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *addFriendBtn;
@end

@implementation DDEnterpriseHomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(popViewController) imageNamed:@"navi_back_black"];
    [self initButtonsWithCollectImageNamed:@"" collectHighlightImageNamed:@"" shareImageNamed:@"c_share_dark"];
    [self addViews];
    self.btnCollect.selected = self.model.status.integerValue;
}
-(void)addViews
{
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.webView];
    [self.bottomView addSubview:self.addFriendBtn];
    
    NSURL *url = [NSURL URLWithString:self.dataModel.url];
    NSLog(@"url:%@",url);
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.addFriendBtn setTitle:@"加该公司为好友" forState:UIControlStateNormal];
    [self.addFriendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addFriendBtn.backgroundColor = kYLColorFontBlue;
    self.addFriendBtn.layer.cornerRadius = 5;
    self.addFriendBtn.layer.masksToBounds = YES;
}
-(UIView *)bottomView{
    if(!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CONTENT_HEIGHT2 - 60, WINDOW_WIDTH, 60)];
    }
    return _bottomView;
}
-(UIButton *)addFriendBtn{
    if (!_addFriendBtn) {
        _addFriendBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 15, WINDOW_WIDTH - 60, 30)];
    }
    return _addFriendBtn;
}
-(UIWebView *)webView
{
    if(!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 60)];
    }
    return _webView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end






