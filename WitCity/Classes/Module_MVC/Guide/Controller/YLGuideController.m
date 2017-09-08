//
//  YLGuideController.m
//
//
//  Created by simpletour on 16/5/5.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLGuideController.h"
#import "YLGuideView.h"
#import "AppDelegate.h"

@interface YLGuideController ()

@property (nonatomic, strong) YLGuideView *mainView;

@end

@implementation YLGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
}

- (void)addViews
{
    [self.view addSubview:self.mainView];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mainView.scrollView.contentSize = CGSizeMake(WINDOW_WIDTH * kYLGuidePages, WINDOW_HEIGHT);
}

-(YLGuideView *)mainView
{
    if(!_mainView) {
        _mainView = [[YLGuideView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
        WS(wself);
        _mainView.allBlock = ^(NSDictionary *dict) {
            [wself changeHomeController];
        };
    }
    return _mainView;
}

#pragma mark - change honme
- (void)changeHomeController
{
    [UD setObject:@"firstLogin" forKey:@"firstLogin"];
    APPDELEGATE.window.rootViewController = APPDELEGATE.tbc;
}

@end
