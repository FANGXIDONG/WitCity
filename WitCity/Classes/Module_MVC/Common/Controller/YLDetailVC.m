//
//  YLDetailVC.m
//  WitCity
//
//  Created by simpletour on 16/6/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLDetailVC.h"
#import "YLCollectManager.h"
#import "YLShareManager.h"
#import "YLShareView.h"
#import "YLLoginVC.h"
#import "YLLoginManager.h"

@interface YLDetailVC ()

@property (nonatomic, strong) YLCollectManager *manager;
@property (nonatomic, strong) YLShareManager   *shareManager;
@property (nonatomic, strong) YLShareView      *shareView;
@property (nonatomic, strong) YLLoginManager   *loginManager;

@end

@implementation YLDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.enterpriseModel == nil) {
        [self initButtonsWithCollectImageNamed:@"c_collect_default" collectHighlightImageNamed:@"c_collect_selected" shareImageNamed:@"c_share_white"];
        self.btnCollect.selected = self.model.status.integerValue;
    }else{
        [self initButtonsWithCollectImageNamed:@"" collectHighlightImageNamed:@"" shareImageNamed:@"c_share_white"];
        self.btnCollect.selected = self.model.status.integerValue;
    }

    [self.view addSubview:self.shareView];
}

-(YLCollectManager *)manager
{
    if(!_manager) {
        _manager = [[YLCollectManager alloc]initWithController:self];
    }
    return _manager;
}

-(YLShareView *)shareView
{
    if(!_shareView) {
        _shareView = [[YLShareView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        _shareView.hidden = YES;
        WS(wself);
        _shareView.allBlock = ^(NSDictionary *dict) {
            
            [wself callbackWithDic:dict];
        };
    }
    return _shareView;
}

-(YLShareManager *)shareManager
{
    if(!_shareManager) {
        _shareManager = [[YLShareManager alloc]initWithController:self];
    }
    return _shareManager;
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

- (void)initButtonsWithCollectImageNamed:(NSString *)collectImageNamed collectHighlightImageNamed:(NSString *)collectHighlightImageNamed shareImageNamed:(NSString *)shareImageNamed
{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -10;
    UIBarButtonItem *btnCollect = [self buttonForNavigationBarWithAction:@selector(collectClick:) imageNamed:collectImageNamed highlightImageNamed:collectHighlightImageNamed  block:^(UIButton *button) {
        self.btnCollect = button;
    }];
    UIBarButtonItem *btnShare = [self buttonForNavigationBarWithAction:@selector(btnShareClick:) imageNamed:shareImageNamed highlightImageNamed:shareImageNamed  block:^(UIButton *button) {
        self.btnShare = button;
    }];
    self.navigationItem.rightBarButtonItems = @[space, btnShare, btnCollect];
}


-(void)callbackWithDic:(NSDictionary *)dict
{
    
    YLModel *cmodel;
    
//    if (self.model==nil) {
//        cmodel = self.newsModel;
//    }
//    if (self.newsModel == nil) {
//        cmodel = self.model;
//    }
    
    if (self.model == nil && self.newsModel == nil) {
        cmodel = self.contactModel;
    }else if (self.contactModel == nil && self.model == nil){
        cmodel = self.newsModel;
    }else if (self.contactModel == nil && self.newsModel == nil){
        cmodel = self.model;
    }else{
        cmodel = self.dataModel;
    }
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kYLBlockTypeShareWeChatFriend:{//微信好友
            [self.shareManager shareWithNameKey:UMShareToWechatSession model:cmodel block:^{
                [YLToast showToastInKeyWindowWithText:@"分享成功"];
            }];
        }break;
        case kYLBlockTypeShareWeChatCycle:{//微信朋友圈
            [self.shareManager shareWithNameKey:UMShareToWechatTimeline model:cmodel block:^{
                [YLToast showToastInKeyWindowWithText:@"分享成功"];
            }];
        }break;
        default:
            break;
    }
}

- (void)collectClick:(UIButton *)button
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        if (button.selected) {
            [self.manager collectCancelWithContentId:self.model.content_id categoryId:self.categoryId block:^(NSDictionary *dict) {
                self.model.status = @"1";
            } failure:^{}];
            
        } else {
            [self.manager collectWithContentId:self.model.content_id categoryId:self.categoryId block:^(NSDictionary *dict) {
                 self.model.status = @"0";
            } failure:^{}];
        }
        button.selected = !button.selected;
    }];
}

- (void)btnShareClick:(UIButton *)button
{
    [self.view bringSubviewToFront:self.shareView];
    [self.shareView show];
}

@end
