//
//  YLInteractiveVC.m
//  WitCity
//
//  Created by simpletour on 16/5/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLInteractiveVC.h"
#import "YLNoticeVC.h"
#import "YLForumVC.h"
#import "YLUserCenterVC.h"
#import "YLSearchVC.h"
#import "YLPostVC.h"
#import "YLLoginVC.h"
#import "YLLoginManager.h"

@interface YLInteractiveVC ()

@property (nonatomic, strong) YLNoticeVC         *noticeVC;
@property (nonatomic, strong) YLForumVC          *forumVC;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIBarButtonItem    *btnSearch;
@property (nonatomic, strong) UIBarButtonItem    *btnPost;
@property (nonatomic, strong) YLLoginManager     *loginManager;

@end

@implementation YLInteractiveVC

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(leftClick) imageNamed:@"hudong_titleleft"];
    self.navigationItem.rightBarButtonItem = [self buttonForNavigationBarWithAction:@selector(rightClick) imageNamed:@"c_search"];
}

-(void)addViews
{
    self.navigationItem.titleView = self.segment;
    [self addChildViewController:self.forumVC];
    [self addChildViewController:self.noticeVC];
    [self.view addSubview:self.forumVC.view];
    [self.view addSubview:self.noticeVC.view];
}

- (void)leftClick
{
    [self pushUserCenterVC];
}

- (void)rightClick
{
    [self pushSearchVC];
}


#pragma mark - getter
-(UISegmentedControl *)segment
{
    if(!_segment) {
        NSArray *items = @[@"公告", @"论坛"];
        _segment = [[UISegmentedControl alloc]initWithItems:items];
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

-(YLNoticeVC *)noticeVC
{
    if(!_noticeVC) {
        _noticeVC = [[YLNoticeVC alloc]init];
    }
    return _noticeVC;
}

-(YLForumVC *)forumVC
{
    if(!_forumVC) {
        _forumVC = [[YLForumVC alloc]init];
    }
    return _forumVC;
}

-(UIBarButtonItem *)btnSearch
{
    if(!_btnSearch) {
        _btnSearch = [self buttonForNavigationBarWithAction:@selector(rightClick) imageNamed:@"c_search"];
    }
    return _btnSearch;
}

-(UIBarButtonItem *)btnPost
{
    if(!_btnPost) {
        _btnPost = [self buttonForNavigationBarWithAction:@selector(pushPostVC) imageNamed:@"hdlt_right_03"];
    }
    return _btnPost;
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

#pragma mark - callback 
-(void)callbackWithDict:(NSDictionary *)dict
{
    
}

#pragma mark - server

#pragma mark - push
- (void)pushSearchVC
{
    YLSearchVC *vc = [[YLSearchVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushModalWithController:vc];
}

- (void)pushUserCenterVC
{
    YLUserCenterVC *vc = [[YLUserCenterVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushPostVC
{
    YLPostVC *vc = [[YLPostVC alloc]init];
    [self pushWithVC:vc];
}

#pragma mark - other
- (void)segmentClick:(UISegmentedControl *)segment
{
    self.noticeVC.view.hidden = segment.selectedSegmentIndex == 1;
    self.forumVC.view.hidden = !self.noticeVC.view.hidden;
    self.navigationItem.rightBarButtonItem = segment.selectedSegmentIndex == 1 ? self.btnPost : self.btnSearch;
}

- (void)pushWithVC:(UIViewController *)vc
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


@end
