//
//  YLVersionSelectVC.m
//  WitCity
//
//  Created by simpletour on 16/5/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLVersionSelectVC.h"
#import "YLVersionSelectView.h"

@interface YLVersionSelectVC ()

@property (nonatomic, strong) YLVersionSelectView *mainView;

@end

@implementation YLVersionSelectVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@""];
    [self addViews];
}

-(void)addViews
{
    [self.view addSubview:self.mainView];
}

#pragma mark - getter
-(YLVersionSelectView *)mainView
{
    if (!_mainView) {
        _mainView = [[YLVersionSelectView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        WS(wself);
        _mainView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _mainView;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    
}

#pragma mark - server

#pragma mark - push

#pragma mark - other



@end
