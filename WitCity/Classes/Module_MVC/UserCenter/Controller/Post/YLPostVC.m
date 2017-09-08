//
//  YLPostVC.m
//  WitCity
//
//  Created by simpletour on 16/6/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLPostVC.h"
#import "YLPostView.h"
#import "YLUserHttpUtil.h"

@interface YLPostVC ()

@property (nonatomic, strong) YLPostView *mainView;

@end

@implementation YLPostVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"发表帖子"];
    [self addViews];
    self.navigationItem.rightBarButtonItem = [self buttonForNavigationBarWithAction:@selector(rightClick) title:@"发表"];
}

- (void)rightClick
{
    [self postWithTitle:self.mainView.title content:self.mainView.content];
}

-(void)addViews
{
    [self.view addSubview:self.mainView];
}

#pragma mark - getter
-(YLPostView *)mainView
{
    if(!_mainView) {
        _mainView = [[YLPostView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        WS(wself);
        _mainView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _mainView;
}

#pragma mark - callback

#pragma mark - server
- (void)postWithTitle:(NSString *)title content:(NSString *)content
{
    if (title.length <= 0) {
        [YLToast showToastWithView:self.view text:@"请输入标题"];
        return;
    }
    
    if (content.length <= 0) {
        [YLToast showToastWithView:self.view text:@"请输入内容"];
        return;
    }
    
    [YLUserHttpUtil postWithTitle:title content:content block:^(NSDictionary *dict) {
        [YLToast showToastInKeyWindowWithText:@"发帖成功"];
        [self popViewController];
    } failure:^{
        
    }];
}

#pragma mark - push

#pragma mark - other



@end
